// ============================================================
// 动画 7:弹簧效果 SpringSimulation —— iOS 那种回弹
//   不是“几秒内匀速走到”,而是“像弹簧一样冲出去再弹回来”。
//   用 _ctrl.animateWith(SpringSimulation(...)) 驱动,
//   比 CurvedAnimation 更有“真实物理”感。
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import '../common.dart';

class SpringPage extends StatelessWidget {
  const SpringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '弹簧效果',
      children: [
        KnowledgeCard('SpringSimulation', '真物理模拟:给一个起始速度,像弹簧一样“冲过头再弹回,慢慢稳住”。用 `_ctrl.animateWith(SpringSimulation(mass, stiffness, damping, start, velocity))` ,代替 duration 模式。'),

        SectionTitle('① 弹一下:球被甩出去又弹回'),
        LearnNote('点“弹一下”:方块像有弹簧拉着冲出去、回弹、摆动几次才停。参数里 damping 越小弹得越久。'),
        const _SpringDemo(),
      ],
    );
  }
}

class _SpringDemo extends StatefulWidget {
  const _SpringDemo();

  @override
  State<_SpringDemo> createState() => _SpringDemoState();
}

class _SpringDemoState extends State<_SpringDemo> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    lowerBound: 0,
    upperBound: 300, // 我们的“跑道长度”
  )..addListener(() => setState(() {}));

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _spring() {
    // 弹簧物理参数:质量、刚度、阻尼、起点、初速度
    final spring = SpringSimulation(
      const SpringDescription(mass: 1, stiffness: 120, damping: 12),
      0,   // 起点
      280, // 终点(冲到右边 280)
      0,   // 起始速度
    );
    _ctrl.animateWith(spring);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: 60,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Positioned(
                left: _ctrl.value,
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                  child: const Text('弹', style: TextStyle(color: Colors.white)),
                ),
              ),
              // 一条地面线
              Positioned(bottom: 0, left: 0, right: 0, child: Container(height: 2, color: Colors.grey.shade300)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _spring,
          child: Text(_ctrl.isAnimating ? '弹动中…' : '弹一下'),
        ),
        const LearnNote('把 damping 从 12 调到 4 再跑,弹性会明显更大、抖得更久。SpringDescription(mass, stiffness, damping) 就是调物理手感的三颗旋钮。'),
      ],
    );
  }
}