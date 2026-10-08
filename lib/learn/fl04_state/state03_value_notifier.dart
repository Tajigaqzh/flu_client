// ============================================================
// 状态管理 3:ValueNotifier / ValueListenableBuilder
//   setState 是“整棵 State 重画”;这里只要“值”变了,
//   只有监听它的那一小块重画。更省、更解耦。
//   内置,不用装第三方库。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class ValueNotifierPage extends StatelessWidget {
  const ValueNotifierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: 'ValueNotifier',
      children: [
        KnowledgeCard('ValueNotifier', '一个能“存一个值、变了就广播”的对象。谁用 ValueListenableBuilder 包住它,值一变那块就自动重画。ValueListenableBuilder.value = 新值 就触发更新(不用 setState)。'),

        SectionTitle('① 用 ValueNotifier 做计数器'),
        LearnNote('只把包住的 Text 局部重画,其他区域不重建。改颜色 / 加减都走 value 赋值。'),
        const _NotifierDemo(),
      ],
    );
  }
}

/// 父级持有 ValueNotifier,一处存,多处能用 ValueListenableBuilder 监听。
class _NotifierDemo extends StatefulWidget {
  const _NotifierDemo();

  @override
  State<_NotifierDemo> createState() => _NotifierDemoState();
}

class _NotifierDemoState extends State<_NotifierDemo> {
  // 状态:一个能广播的箱子,初始值 0
  final ValueNotifier<int> _count = ValueNotifier(0);

  @override
  void dispose() {
    _count.dispose(); // ValueNotifier 也要释放
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 只有这个 builder 的匿名区域随 _count 变
        ValueListenableBuilder<int>(
          valueListenable: _count,
          builder: (context, value, _) {
            return Text(
              '$value',
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.purple),
            );
          },
        ),
        const SizedBox(height: 4),
        Text('这个说明文字不会变,证明只有上面的数字被重建。',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton.filled(
              onPressed: () => _count.value--,
              icon: const Icon(Icons.remove),
            ),
            const SizedBox(width: 12),
            IconButton.filled(
              onPressed: () => _count.value++,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const LearnNote('关键点:改状态用的是 `_count.value = …`(箱子塞新值,自动广播),而不是 setState。真正连形状都有变化的场景一般仍用 AnimatedBuilder 这类。'),
      ],
    );
  }
}