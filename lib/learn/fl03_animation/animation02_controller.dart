// ============================================================
// 动画 2:显式动画 AnimationController(重点)
//   自己造一个“进度 0→1”的控制器,想怎么用就怎么用。
//   三件套:AnimationController(进度) + Animation(值)
//          + 监听值改 UI。
//   能控制它 forward(正放)/ reverse(倒放) / repeat(循环)。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class ControllerPage extends StatelessWidget {
  const ControllerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: 'AnimationController',
      children: [
        KnowledgeCard('AnimationController', '一个 0→1 的“进度条”,一秒跑多少由 duration 定。要三样:vsync(绑一个 State)、duration(时长)、再 addListener 把进度接到界面上。用 `SingleTickerProviderStateMixin` 让 State 当 vsync。'),

        SectionTitle('① 核心示例:点一下,方块放大再回来'),
        LearnNote('看代码三件套:\n'
                 ' 1. late final _ctrl = AnimationController(vsync: this, duration: …)\n'
                 ' 2. _ctrl.forward().then((_) => _ctrl.reverse())　先放再收回\n'
                 ' 3. _ctrl.addListener(() => setState((){}))　每帧更新界面\n'
                 '别忘了 dispose() 释放,否则报内存泄漏警告。'),
        const _CoreDemo(),

        SectionTitle('② 最常用:控制器驱动 Transform'),
        LearnNote('用 _ctrl.value (0~1) 去控制 Transform.scale 的缩放倍数。这是“入场放大”动画的标准写法。'),
        const _TransformDemo(),
      ],
    );
  }
}

class _CoreDemo extends StatefulWidget {
  const _CoreDemo();

  @override
  State<_CoreDemo> createState() => _CoreDemoState();
}

class _CoreDemoState extends State<_CoreDemo> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  )..addListener(() => setState(() {}));

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 宽度 = 60 + 120 × 进度。进度 0 → 宽 60,进度 1 → 宽 180。
    final width = 60.0 + 120 * _ctrl.value;
    return Column(
      children: [
        Container(
          width: width,
          height: 60,
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text('${(_ctrl.value * 100).toStringAsFixed(0)}%', style: const TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            _ctrl.forward(from: 0).then((_) => _ctrl.reverse());
          },
          child: Text(_ctrl.isAnimating ? '播放中…' : '点我:放大再缩小'),
        ),
      ],
    );
  }
}

class _TransformDemo extends StatefulWidget {
  const _TransformDemo();

  @override
  State<_TransformDemo> createState() => _TransformDemoState();
}

class _TransformDemoState extends State<_TransformDemo> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  )..addListener(() => setState(() {}));

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // scale = 0 + 1×进度 → 从 0 放大到 1。
    return Column(
      children: [
        Transform.scale(
          scale: _ctrl.value,
          child: Container(
            width: 110,
            height: 110,
            color: Colors.teal,
            alignment: Alignment.center,
            child: const Text('放大', style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => _ctrl.forward(from: 0),
          child: const Text('入场放大'),
        ),
      ],
    );
  }
}