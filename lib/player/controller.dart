// ============================================================
// 高度可控音频播放器 · 核心控制器
// 基于 just_audio:把播放状态/中/速度/进度全部封装成一个
// 可重复使用的控制器,UI 只负责消费状态、触发动作。
//
// 用 ValueNotifier<List<...>> 与 Stream 暴露状态:
//   - state      总体状态(loading/playing/paused/stopped/completed)
//   - position   当前播放位置(秒)
//   - duration   总时长(秒)
//   - currentTitle 当前曲目名
// 想监听变化,就在 UI 里:
//   valueListenable: controller.progress   (PositionNotifier 之类)
//   或 controller.player.positionStream.listen(...)
// ============================================================

import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

/// 播放器的整体开关状态(带,够 UI 判断交互是否可用)
enum PlayerStatus { loading, ready, playing, paused, stopped, completed }

/// 循环模式:单曲 / 列表 / 不循环
enum LoopModeSetting { none, single, all }

/// 一条曲目(演示用:既支持网络 URL,也支持 assets 资源)
class Track {
  final String id;
  final String title;
  final String? url; // 网络地址 / 本地文件路径
  final String? assetPath; // 打包进 App 的资源,如 assets/audio/x.mp3

  const Track({required this.id, required this.title, this.url, this.assetPath});
}

/// 高度可控的音频播放器控制器。
/// 把 just_audio 的所有能力收口到这里,连 UI 都不知道引擎细节。
class AudioPlayerController {
  // just_audio 的底层播放器(它也自带 state/position stream)
  final AudioPlayer player;

  AudioPlayerController() : player = AudioPlayer() {
    _init();
  }

  // ---- 对外暴露的只读状态 ----
  /// 像过时的当前总状态(loading/playing/…)
  Stream<PlayerStatus> get statusStream => player.playerStateStream.map(mapStatus);
  /// 当前播放位置(秒)
  Stream<Duration> get positionStream => player.positionStream;
  /// 当前曲目索引(列表高亮用)
  final ValueNotifier<int> currentIndex = ValueNotifier(-1);

  /// 用于 UI 展示的当前曲目名
  final ValueNotifier<String> currentTitle = ValueNotifier('未载入');
  /// 当前是否加载中
  final ValueNotifier<bool> loading = ValueNotifier(true);

  List<Track> _queue = [];
  int _currentIndex = -1;

  /// 播放列表里的曲目数(UI 渲染用)
  int get trackCount => _queue.length;
  /// 取第 i 首的标题(UI 列表用)
  String titleAt(int i) => i >= 0 && i < _queue.length ? _queue[i].title : '';

  /// 循环模式
  LoopModeSetting _loop = LoopModeSetting.all;
  LoopModeSetting get loop => _loop;

  /// 供 just_audio 使用的循环映射
  LoopMode get _engineLoop {
    switch (_loop) {
      case LoopModeSetting.none: return LoopMode.off;
      case LoopModeSetting.single: return LoopMode.one;
      case LoopModeSetting.all: return LoopMode.all;
    }
  }

  Future<void> _init() async {
    player.setLoopMode(_engineLoop);
    // 让系统把我们的音频当作媒体会话(后台可被锁屏/通知栏控制)
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    // 监听结束:自动播下一首(列表循环时)
    player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed && _loop != LoopModeSetting.single) {
        next();
      }
    });
  }

  /// 载入一个播放列表(可为空,后面再 addTrack)
  Future<void> setQueue(List<Track> tracks) async {
    _queue = List.of(tracks);
    if (_queue.isNotEmpty) {
      await playIndex(0);
    }
  }

  /// 载入单条音轨(没有列表时)
  Future<void> load(Track track) async {
    await setQueue([track]);
  }

  /// 播放第 index 首
  Future<void> playIndex(int index) async {
    if (index < 0 || index >= _queue.length) return;
    _currentIndex = index;
    currentIndex.value = index;
    final t = _queue[index];
    currentTitle.value = t.title;
    loading.value = true;
    try {
      if (t.url != null) {
        await player.setUrl(t.url!);
      } else if (t.assetPath != null) {
        await player.setAsset(t.assetPath!);
      }
    } catch (e) {
      currentTitle.value = '加载失败: ${t.title}';
    } finally {
      loading.value = false;
    }
    await player.play();
  }

  /// 播放 / 暂停切换
  Future<void> togglePlayPause() async {
    if (player.playing) {
      await player.pause();
    } else {
      await player.play();
    }
  }

  /// 停止(回到开头)
  Future<void> stop() {
    return player.stop();
  }

  /// 快进/快退 n 秒(正数为前进)
  Future<void> skip(Duration by) async {
    final target = player.position + by;
    await player.seek(target);
  }

  /// 跳转到任意时间点(进度条拖动
  Future<void> seekTo(Duration position) => player.seek(position);

  /// 变速 0.5x ~ 2x
  Future<void> setSpeed(double speed) => player.setSpeed(speed);

  /// 音量 0.0 ~ 1.0
  Future<void> setVolume(double vol) => player.setVolume(vol);

  /// 切循环:单曲 → 列表 → 关闭
  Future<void> cycleLoop() async {
    switch (_loop) {
      case LoopModeSetting.none: _loop = LoopModeSetting.single;
      case LoopModeSetting.single: _loop = LoopModeSetting.all;
      case LoopModeSetting.all: _loop = LoopModeSetting.none;
    }
    await player.setLoopMode(_engineLoop);
  }

  /// 下一首
  Future<void> next() async {
    if (_queue.isEmpty) return;
    await playIndex((_currentIndex + 1) % _queue.length);
  }

  /// 上一首
  Future<void> previous() async {
    if (_queue.isEmpty) return;
    await playIndex((_currentIndex - 1 + _queue.length) % _queue.length);
  }

  /// 完全释放(页面销毁时调用)
  Future<void> dispose() async {
    await player.dispose();
  }

  /// 把 just_audio 的 ProcessingState 翻译成我们自己的枚举
  static PlayerStatus mapStatus(PlayerState s) {
    if (s.processingState == ProcessingState.loading) {
      return PlayerStatus.loading;
    }
    if (s.playing) {
      return PlayerStatus.playing;
    }
    if (s.processingState == ProcessingState.completed) {
      return PlayerStatus.completed;
    }
    if (s.processingState == ProcessingState.ready) {
      return s.playing ? PlayerStatus.playing : PlayerStatus.paused;
    }
    return PlayerStatus.stopped;
  }
}

