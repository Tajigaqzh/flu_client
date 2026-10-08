// ============================================================
// 动画 3:曲线 CurvedAnimation
//   让进度“没规律的走”:先快后慢 / 回弹 / 抛物线。
//   CurvedAnimation(parent: 控制器, curve: Curves.xxx)
//   然后你继续用这个 Animated 曲线值,而不是原进度。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class CurvePage extends StatelessWidget {
  const CurvePage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '动画曲线',
      children: [
        KnowledgeCard('CurvedAnimation', '给进度加“节奏”:easeIn 由慢到快、easeOut 由快到慢、easeInOut 两头慢中间快。用 CurvedAnimation(parent: 控制器, curve: Curves.xxx) 包一层再当值用。'),

        SectionTitle('① 三种常见曲线对比'),
        LearnNote('下面一颗小球用三种曲线滚向 400px:\n'
                 ' ● 蓝 = linear 匀速\n'
                 ' ● 绿 = easeOut 快到慢(落地感)\n'
                 ' ● 橙 = easeInBack 会“先倒冲再冲出去”(回弹感)\n'
                 '跑完约 1.6 秒,耐心看。'),

        const _RaceDemo(),

        SectionTitle('② 常用曲线一览'),
        LearnNote('记这几个就行:\n'
                 ' Curves.easeIn / easeOut / easeInOut(最基本)\n'
                 ' Curves.easeOutBack(过冲一点再回来,做弹出最灵)\n'
                 ' Curves.bounceOut(落地弹跳)\n'
                 ' Curves.linearToEaseOut(先快后慢)。'),
      ],
    );
  }
}

class _RaceDemo extends StatefulWidget {
  const _RaceDemo();

  @override
  State<_RaceDemo> createState() => _RaceDemoState();
}

class _RaceDemoState extends State<_RaceDemo> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..addListener(() => setState(() {}));

  late final CurvedAnimation _linear = CurvedAnimation(parent: _ctrl, curve: Curves.linear);
  late final CurvedAnimation _easeOut = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
  late final CurvedAnimation _back = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack);

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double x(double v) => v * 380; // 进度 → 水平位移
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 一条竞速跑道:三条线,每线一颗球
        for (final (label, color, value) in [
          ('linear 匀速', Colors.blue, _linear.value),
          ('easeOut 快到慢', Colors.green, _easeOut.value),
          ('easeInBack 回弹', Colors.orange, _back.value),
        ])
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                SizedBox(width: 96, child: Text(label, style: const TextStyle(fontSize: 11))),
                SizedBox(
                  width: 380,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(height: 2, color: Colors.grey.shade300),
                      Transform.translate(
                        offset: Offset(x(value), 0),
                        child: Container(width: 14, height: 14, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 6),
        ElevatedButton(
          onPressed: () => _ctrl.forward(from: 0),
          child: Text(_ctrl.isAnimating ? '跑动中…' : '重新开跑'),
        ),
      ],
    );
  }
}