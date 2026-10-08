// ============================================================
// 动画 1:隐式动画(最省事,3 分钟见效)
//   AnimatedContainer / AnimatedOpacity / AnimatedSwitcher
//   你只要改一个“目标值”,Flutter 自动补出中间过程。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class ImplicitPage extends StatelessWidget {
  const ImplicitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '隐式动画',
      children: [
        KnowledgeCard('隐式动画', '改一个目标值,给 Flutter 一个 duration(时长),中间过程自动补。不用碰控制器。AnimatedContainer 大小/颜色/圆角都能动。'),

        SectionTitle('① AnimatedContainer:大小 + 颜色 + 圆角'),
        LearnNote('点“切换”按钮,绿方块会平滑变大、变圆、变色。你只改了一个 bool,剩下的动画由 AnimatedContainer 自己完成。'),
        const _SizeDemo(),

        SectionTitle('② AnimatedOpacity:淡入淡出'),
        LearnNote('切换 visible,文字在可见/隐藏之间渐变,而不是瞬间消失。常用的“加载遮罩淡出”就是这么做的。'),
        const _OpacityDemo(),

        SectionTitle('③ AnimatedSwitcher:内容切换过渡'),
        LearnNote('每次换一个 child,自动“旧淡出、新淡入”。数量/状态来回切换很常用。'),
        const _SwitcherDemo(),
      ],
    );
  }
}

/// 点按钮 → 在两种尺寸/颜色/圆角间切换。
class _SizeDemo extends StatefulWidget {
  const _SizeDemo();

  @override
  State<_SizeDemo> createState() => _SizeDemoState();
}

class _SizeDemoState extends State<_SizeDemo> {
  bool _big = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          width: _big ? 140 : 90,
          height: _big ? 90 : 90,
          decoration: BoxDecoration(
            color: _big ? Colors.teal : Colors.indigo,
            borderRadius: BorderRadius.circular(_big ? 45 : 8),
          ),
          alignment: Alignment.center,
          child: const Text('动画', style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => setState(() => _big = !_big),
          child: Text(_big ? '还原' : '变大变圆'),
        ),
      ],
    );
  }
}

/// 点按钮 → 淡入淡出。
class _OpacityDemo extends StatefulWidget {
  const _OpacityDemo();

  @override
  State<_OpacityDemo> createState() => _OpacityDemoState();
}

class _OpacityDemoState extends State<_OpacityDemo> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: _visible ? 1 : 0,
          duration: const Duration(milliseconds: 500),
          child: Container(
            padding: const EdgeInsets.all(12),
            color: Colors.amber.shade100,
            child: const Text('这段文字会淡入淡出', style: TextStyle(fontSize: 15)),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => setState(() => _visible = !_visible),
          child: Text(_visible ? '隐藏' : '显示'),
        ),
      ],
    );
  }
}

/// 点按钮 → 在两种内容间过渡切换。
class _SwitcherDemo extends StatefulWidget {
  const _SwitcherDemo();

  @override
  State<_SwitcherDemo> createState() => _SwitcherDemoState();
}

class _SwitcherDemoState extends State<_SwitcherDemo> {
  int _n = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: Container(
            key: ValueKey(_n), // 每次换值,key 变了,Switcher 就知道“内容不同了”
            padding: const EdgeInsets.all(14),
            color: _n.isEven ? Colors.orange : Colors.purple,
            child: Text('第 $_n 张', style: const TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => setState(() => _n++),
          child: const Text('换一张'),
        ),
      ],
    );
  }
}