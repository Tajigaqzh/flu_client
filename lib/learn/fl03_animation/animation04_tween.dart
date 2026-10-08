// ============================================================
// 动画 4:Tween —— 把进度 0~1 映成一个“范围内的值”
//   之前手动写 60 + 120*value,太笨。Tween 帮你做插值:
//     Tween(begin, end).animate(控制器)  得到一个“动画值”
//   自己也知道:颜色 / 尺寸 / 圆角 都是对象,都能被插值。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class TweenPage extends StatelessWidget {
  const TweenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: 'Tween',
      children: [
        KnowledgeCard('Tween', '把进度 0~1 翻译成另一个区间(尺寸 10→10、颜色 红→蓝、偏移 左→右)。写法:`Tween(begin:…, end:…).animate(控制器)`。比手动算公式更清晰。'),

        SectionTitle('① 尺寸 + 颜色一起 Tween'),
        LearnNote('两个 Tween:SizeTween 控制大小,ColorTween 控制颜色。一个进度,两样东西联动画。'),
        const _ColorDemo(),

        SectionTitle('② 位移 Tween:把方块从左边挪到右边'),
        LearnNote('用 Tween<Offset>(end: Offset(220,0)) 让方块水平位移。要 animate 的对象得“可插值”,Offset、Color 都内置支持。'),
        const _OffsetDemo(),
      ],
    );
  }
}

class _ColorDemo extends StatefulWidget {
  const _ColorDemo();

  @override
  State<_ColorDemo> createState() => _ColorDemoState();
}

class _ColorDemoState extends State<_ColorDemo> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..addListener(() => setState(() {}));

  late final Animation<double> _size = Tween<double>(begin: 60, end: 130).animate(_ctrl);
  late final Animation<Color> _color =
      ColorTween(begin: Colors.red, end: Colors.blue).animate(_ctrl) as Animation<Color>;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: _size.value,
          height: _size.value,
          color: _color.value,
          alignment: Alignment.center,
          child: const Text('大+变色', style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => _ctrl.forward(from: 0),
          child: const Text('切换:变大 + 红变蓝'),
        ),
      ],
    );
  }
}

class _OffsetDemo extends StatefulWidget {
  const _OffsetDemo();

  @override
  State<_OffsetDemo> createState() => _OffsetDemoState();
}

class _OffsetDemoState extends State<_OffsetDemo> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  )..addListener(() => setState(() {}));

  late final Animation<Offset> _off = Tween<Offset>(end: const Offset(220, 0)).animate(_ctrl);

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Transform.translate(
            offset: _off.value,
            child: Container(width: 60, height: 60, color: Colors.purple, alignment: Alignment.center, child: const Text('跑', style: TextStyle(color: Colors.white))),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => _ctrl.forward(from: 0),
          child: const Text('右移 220px'),
        ),
      ],
    );
  }
}