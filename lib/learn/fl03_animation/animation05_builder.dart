// ============================================================
// 动画 5:AnimatedBuilder —— 只重绘动画那一块
//   之前用 addListener + setState(整个 State 重绘)太浪费。
//   AnimatedBuilder 把“会动的区域”包起来,只它自己重建。
//   性能更好,代码也更干净。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class BuilderPage extends StatelessWidget {
  const BuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: 'AnimatedBuilder',
      children: [
        KnowledgeCard('AnimatedBuilder', '把会和动画一起变的那一小块包进 AnimatedBuilder(animation: 控制器, builder: 用 value 返回 UI)。控制器变,只重建这块,其余不动。是显式动画的“推荐姿势”。'),

        SectionTitle('① 旋转的圆环'),
        LearnNote('这一页 AnimatedBuilder 外面是 static 的文字(不会动),里面是旋转圆环(每次 rebuild)。跑的时候注意:只有圆环那块变,标题文字纹丝不动。'),
        const _SpinDemo(),
      ],
    );
  }
}

class _SpinDemo extends StatefulWidget {
  const _SpinDemo();

  @override
  State<_SpinDemo> createState() => _SpinDemoState();
}

class _SpinDemoState extends State<_SpinDemo> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  );

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 只有这个 AnimatedBuilder 会随动画重建
        AnimatedBuilder(
          animation: _ctrl,
          builder: (context, _) {
            return Transform.rotate(
              angle: _ctrl.value * 6.28318, // 转满一圈 2π
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Colors.orange, Colors.pink]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Align(
                  alignment: Alignment.topCenter,
                  child: Icon(Icons.arrow_upward, color: Colors.white),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () => _ctrl.repeat(), // 一直转
          child: Text(_ctrl.isAnimating ? '旋转中' : '开始旋转'),
        ),
      ],
    );
  }
}