/// Birdle 的游戏逻辑和支撑类型。
/// Birdle 是一个类似 Wordle 的五字母猜词游戏。
///
/// 本文件定义了 [Game] 状态机,以及用来表示「猜测结果」的
/// [Word]、[Letter] 和 [HitType] 数据模型,
/// 它们用于把每一次猜测与隐藏单词进行比对。
library;

import 'dart:collection';
import 'dart:math';

/// 对一个猜测中的 [Letter] 打分后得到的结果类型。
enum HitType {
  /// 该字母还没有被评估(尚未比对)。
  none,

  /// 该字母与隐藏单词中「同一位置」的字母一致(位置和字母都对)。
  hit,

  /// 该字母存在于隐藏单词中,但位置不对(字母对、位置错)。
  partial,

  /// 该字母完全不在隐藏单词中。
  miss,
}

/// 一个字母(char)与它相对隐藏单词的 [HitType] 配对。
/// 这就是「一个格子」的数据表示。
typedef Letter = ({String char, HitType type});

/// 所有允许合法输入的单词。
/// = 可以作为答案的单词 + 额外放行的单词。
const List<String> allLegalGuesses = [...legalWords, ...legalGuesses];

/// 可以被选作隐藏单词的单词。
const List<String> legalWords = ['aback', 'abase', 'abate', 'abbey', 'abbot'];

/// 除 [legalWords] 之外,额外允许玩家当成猜测输入的单词。
const List<String> legalGuesses = [
  'aback',
  'abase',
  'abate',
  'abbey',
  'abbot',
  'abhor',
  'abide',
  'abled',
  'abode',
  'abort',
];

/// 一局 Birdle 的游戏状态。
/// Birdle 是一个类似 Wordle 的五字母猜词游戏。
///
/// 向 UI 暴露了「评估猜测、追踪进度」所需的全部状态和方法,
/// 但它本身不会自动推进对局。
///
/// 客户端通过调用 [guess] 提交猜测、调用 [resetGame] 重新开始,
/// 来驱动每一局的进行。
class Game {
  /// 一局游戏允许的最大猜测次数([Game] 的默认值)。
  static const int defaultMaxGuesses = 5;

  /// 创建一个 [maxGuesses] 次猜测机会的新游戏。
  ///
  /// 如果提供了 [seed],隐藏单词会从 [legalWords] 中按固定规则选取;
  /// 否则随机选取。
  Game({this.maxGuesses = defaultMaxGuesses, this.seed})
      : _wordToGuess = _generateInitialWord(seed),
        _guesses = List<Word>.filled(maxGuesses, Word.empty());

  /// 本局游戏允许的最大猜测次数。
  final int maxGuesses;

  /// 用来确定隐藏单词的种子;若为 `null` 表示是随机选的。
  final int? seed;

  /// 当前隐藏单词,对外通过 [hiddenWord] 只读暴露。
  Word _wordToGuess;

  /// [guesses] 的底层存储。
  ///
  /// 按顺序保存每一个猜测槽位,
  /// 未填写的槽位用空的 [Word] 占位。
  List<Word> _guesses;

  /// 玩家正在猜的隐藏单词。
  Word get hiddenWord => _wordToGuess;

  /// 所有猜测槽位的只读视图(包含仍是空白的槽位)。
  UnmodifiableListView<Word> get guesses => UnmodifiableListView(_guesses);

  /// 最近一次提交的猜测;
  /// 如果一局都没猜过,则返回一个空的 [Word]。
  Word get previousGuess {
    final index = _guesses.lastIndexWhere((word) => word.isNotEmpty);
    return index == -1 ? Word.empty() : _guesses[index];
  }

  /// 下一个空猜测槽位的下标;如果所有槽位都满了则返回 `-1`。
  int get activeIndex => _guesses.indexWhere((word) => word.isEmpty);

  /// 玩家还剩下多少次猜测机会。
  int get guessesRemaining {
    if (activeIndex == -1) return 0;
    return maxGuesses - activeIndex;
  }

  /// 最近一次猜测是否完全命中了隐藏单词。
  bool get didWin {
    if (_guesses.first.isEmpty) return false;

    for (final letter in previousGuess) {
      if (letter.type != HitType.hit) return false;
    }

    return true;
  }

  /// 是否已经耗尽了所有猜测机会且仍未获胜。
  bool get didLose => guessesRemaining == 0 && !didWin;

  /// 重新选一个隐藏单词,并清空所有已提交的猜测。
  void resetGame() {
    _wordToGuess = _generateInitialWord(seed);
    _guesses = List<Word>.filled(maxGuesses, Word.empty());
  }

  /// 把 [guess] 与隐藏单词比对、结果写入 [guesses],并返回比对结果。
  ///
  /// 如果需要在提交前校验输入,调用 [isLegalGuess];
  /// 如果只想评估而不记录结果,调用 [matchGuessOnly]。
  Word guess(String guess) {
    final result = matchGuessOnly(guess);
    addGuessToList(result);
    return result;
  }

  /// [guess] 是否是一个合法可输入的单词。
  ///
  /// UI 可以在调用 [guess] 前先调用此方法,
  /// 当玩家输入了非法单词时给出提示。
  bool isLegalGuess(String guess) => Word.fromString(guess).isLegalGuess;

  /// 评估 [guess] 与隐藏单词的比对结果,但不推进游戏进度。
  Word matchGuessOnly(String guess) =>
      Word.fromString(guess).evaluateGuess(_wordToGuess);

  /// 把 [guess] 存入 [guesses] 的下一个空槽位。
  void addGuessToList(Word guess) {
    final guessIndex = activeIndex;
    if (guessIndex == -1) {
      throw StateError('No guesses remaining.'); // 已经没有剩余猜测次数
    }

    _guesses[guessIndex] = guess;
  }

  /// 返回新一轮游戏的起始隐藏单词。
  ///
  /// 提供了 [seed] 时从 [legalWords] 中确定性选取,否则随机选取。
  static Word _generateInitialWord(int? seed) =>
      seed == null ? Word.random() : Word.fromSeed(seed);
}

/// 一个由 [Letter] 组成的五字母单词,每个字母都记录了自己的 [HitType]。
class Word with IterableMixin<Letter> {
  /// 用指定的 [Letter] 列表构造一个单词。
  Word(this._letters);

  /// 创建一个五个空字母、类型都是 [HitType.none] 的单词(空白行)。
  factory Word.empty() =>
      Word(List<Letter>.filled(5, (char: '', type: HitType.none)));

  /// 从 [guess] 字符串构造一个 [Word]。
  ///
  /// 每个字符都会被转成小写,
  /// 每个 [Letter] 的初始 [HitType] 都是 [HitType.none]。
  factory Word.fromString(String guess) {
    if (guess.length != 5) {
      throw ArgumentError.value(
        guess,
        'guess',
        'Must be exactly 5 characters long.', // 必须恰为 5 个字符
      );
    }

    final letters = guess
        .toLowerCase() // 统一小写
        .split('') // 拆成单个字符
        .map((char) => (char: char, type: HitType.none)) // 初始均为未评估
        .toList();
    return Word(letters);
  }

  /// 从 [legalWords] 中随机挑一个单词。
  factory Word.random() {
    final random = Random();
    final nextWord = legalWords[random.nextInt(legalWords.length)];
    return Word.fromString(nextWord);
  }

  /// 用 [seed] 作为下标,从 [legalWords] 中挑一个单词(确定性)。
  factory Word.fromSeed(int seed) =>
      Word.fromString(legalWords[seed % legalWords.length]);

  /// 组成这个单词的 [Letter] 列表(只读,不可从外部修改)。
  final List<Letter> _letters;

  @override
  Iterator<Letter> get iterator => _letters.iterator;

  /// 这个单词的每个 [Letter] 是否都没有字符(即全是空白)。
  @override
  bool get isEmpty => every((letter) => letter.char.isEmpty);

  @override
  int get length => _letters.length;

  /// 下标 [i] 处的 [Letter]。
  Letter operator [](int i) => _letters[i];

  @override
  String toString() => _letters.map((letter) => letter.char).join().trim();

  /// 返回一个多行字符串,每个 [Letter] 后面标注它的 [HitType]。
  ///
  /// 用于从命令行体验这个游戏。
  String toStringVerbose() => _letters
      .map((letter) => '${letter.char} - ${letter.type.name}')
      .join('\n');
}

/// 定义在 [Word] 上的「校验」和「猜词比对」逻辑。
extension WordUtils on Word {
  /// 这个单词是否存在于 [allLegalGuesses] 中(是否合法)。
  bool get isLegalGuess => allLegalGuesses.contains(toString());

  /// 把这个 [Word] 与给定的 [hiddenWord] 比对,
  /// 返回一个新 [Word]:字母相同,但每个 [Letter] 的 [HitType]
  /// 会被更新为 [HitType.hit]、[HitType.partial] 或 [HitType.miss]。
  Word evaluateGuess(Word hiddenWord) {
    assert(isLegalGuess);

    final result = List<Letter>.filled(length, (char: '', type: HitType.none));
    // 记录隐藏单词里「还可以被拿去当作 partial(字母相同但位置不同)」的剩余字母个数。
    final unmatchedHiddenLetterCounts = <String, int>{};

    // 第一遍:先确定「位置也完全匹配」的字母。
    for (var i = 0; i < length; i++) {
      final guessChar = this[i].char; // 猜测位置的字母
      final hiddenChar = hiddenWord[i].char; // 相同位置的答案字母

      if (guessChar == hiddenChar) {
        // 字母和位置都对 → hit
        result[i] = (char: guessChar, type: HitType.hit);
      } else {
        // 位置不匹配:先把答案里这个字母计数起来,留给下一遍的 partial 判定。
        final unmatchedCount = unmatchedHiddenLetterCounts[hiddenChar] ?? 0;
        unmatchedHiddenLetterCounts[hiddenChar] = unmatchedCount + 1;
      }
    }

    // 第二遍:对每个非 hit 的位置,用剩余字母判定 partial 或 miss。
    // 关键点:每个答案字母只能「被消费/占用一次」用于 partial,
    // 避免「答案里只有 1 个 e,玩家猜了 2 个 e 却都判成 partial」的错误。
    for (var i = 0; i < length; i++) {
      if (result[i].type == HitType.hit) continue; // hit 的不再处理

      final guessChar = this[i].char;
      final unmatchedCount = unmatchedHiddenLetterCounts[guessChar] ?? 0;
      final isPartial = unmatchedCount > 0; // 还有剩余可用的隐藏字母 → partial
      if (isPartial) {
        // 消费掉一个隐藏字母,保证它只能被匹配一次。
        unmatchedHiddenLetterCounts[guessChar] = unmatchedCount - 1;
      }

      // 字母在答案里出现过但位置不对 → partial;否则 → miss
      result[i] = (
      char: guessChar,
      type: isPartial ? HitType.partial : HitType.miss,
      );
    }

    return Word(result);
  }
}