// ============================================================
// 状态管理 1:setState —— 最简单、最直接
//   当一个值变了、想让界面跟着变,就 setState。
//   setState 会重新 build 整个 State,把新值画上去。
//   “3 行代码让 App 动起来”说的就是它。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class SetStatePage extends StatelessWidget {
  const SetStatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: 'setState',
      children: [
        KnowledgeCard('setState', '想要“改个值 → 界面跟着变”,把这个值放进 State,改了之后调用 setState(() {}) 通知重画。它是 Flutter 最底层的状态手段,其他方案都是对它的封装/优化。'),

        SectionTitle('① 核心:数字 + 按钮'),
        LearnNote('下面这个“计数器”:每次点按钮都 `计数++` 再 `setState(() {})`。setState 里指定的回调执行完,整个 build 会重跑,新的数字就上屏了。'),
        const _CounterDemo(),

        SectionTitle('② setState 写在哪儿?'),
        LearnNote('必须写在「这个 State」自己的 State 类里(即 build 方法所在的那个 State)。想改这个界面,就在它里面 setState;想改另一个的,得先想办法把状态传过去(下一页讲)。'),
      ],
    );
  }
}

class _CounterDemo extends StatefulWidget {
  const _CounterDemo();

  @override
  State<_CounterDemo> createState() => _CounterDemoState();
}

class _CounterDemoState extends State<_CounterDemo> {
  int _count = 0; // 状态:会被界面读取,也会被事件修改

  void _add() {
    setState(() => _count++); // 改状态 + 通知重画
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$_count',
          style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        const SizedBox(height: 4),
        Text('这是 build 里读 _count 画出来的', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        const SizedBox(height: 10),
        FilledButton(onPressed: _add, child: const Text('+1')),
      ],
    );
  }
}