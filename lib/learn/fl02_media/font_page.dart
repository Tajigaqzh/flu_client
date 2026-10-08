// ============================================================
// 知识点:如何应用字体
//   1) 用系统 / 内置字体:TextStyle 里写 fontFamily
//   2) 用自定义字体(推荐,独家识别度):先放 TTF → pubspec 注册 → 用 fontFamily 名
//      —— 见本页顶部的 pubspec 配置卡
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class FontPage extends StatelessWidget {
  const FontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '应用字体',
      children: [
        KnowledgeCard('应用字体', '中文字体默认是系统字体。想变风格,靠 TextStyle 的 fontFamily / fontWeight / fontStyle / fontSize。宝定做的字体要先进 pubspec 注册。'),

        SectionTitle('① 用系统内置字体名 fontFamily'),
        LearnNote('不装字体也能指定常见内置族:默认 sans-serif / monospace / serif。下面两行就是不同 fontFamily 的效果。'),
        Text('这是默认字体', style: TextStyle(fontSize: 16)),
        const Text('这是 monospace 等宽字体',
            style: TextStyle(fontFamily: 'monospace', fontSize: 16)),
        const Text('这是 serif 衬线字体', style: TextStyle(fontFamily: 'serif', fontSize: 16)),

        SectionTitle('② 字号 / 粗细 / 斜体'),
        LearnNote('同一字体靠这些参数变化:size 字号、fontWeight 粗、fontStyle 斜、decoration 划线。'),
        Text('普通 · 16', style: TextStyle(fontSize: 16)),
        Text('大号 · 28 加粗', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        Text('灰色 · 斜体', style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey)),
        Text('带下划线', style: TextStyle(fontSize: 16, decoration: TextDecoration.underline)),

        SectionTitle('③ 用自定义字体(重点★)'),
        LearnNote('三步:\n'
            '  1. 把 MyFont-Regular.ttf 放到 assets/fonts/\n'
            '  2. 在 pubspec.yaml 的 flutter 里注册 family\n'
            '  3. 代码里 fontFamily: \'MyFont\' 使用'),
        _PubspecCodeCard(),
        const SizedBox(height: 8),
        LearnNote('下面这行演示 fontFamily 一旦注册成功后的写法(当前没装字体,回退到默认字体;配置好就会变)。'),
        const Text('MyFont 字体效果', style: TextStyle(fontFamily: 'MyFont', fontSize: 22, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

/// 用等宽字体展示「pubspec.yaml 里怎么写」。
class _PubspecCodeCard extends StatelessWidget {
  const _PubspecCodeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blueGrey.shade200),
      ),
      child: const Text(
        'flutter:\n'
        '  fonts:\n'
        '    - family: MyFont\n'
        '      fonts:\n'
        '        - asset: assets/fonts/MyFont-Regular.ttf',
        style: TextStyle(fontFamily: 'monospace', fontSize: 13, height: 1.6),
      ),
    );
  }
}