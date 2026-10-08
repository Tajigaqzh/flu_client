// ============================================================
// 知识点 12:Flex —— 布局之根(必看)
//   Row = 横着摆的 Flex,Column = 竖着摆的 Flex。
//   看懂 Flex,前面 Expanded / Flexible / Spacer / 对齐就全通。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class FlexPage extends StatelessWidget {
  const FlexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: 'Flex 布局之根',
      children: [
        KnowledgeCard('Flex', 'Row 和 Column 都是 Flex 的子类。Flex(direction: …) 的 direction 决定方向:horizontal=横(≈Row)、vertical=竖(≈Column)。它负责把主轴剩余空间分给 Expanded/Flexible/Spacer。'),

        SectionTitle('① Row / Column 本质就是 Flex'),
        LearnNote('看这行:Flex 当 Row 用(direction: horizontal),和 Row 一模一样。'),
        Container(
          color: Colors.grey.shade50,
          child: const Flex(
            direction: Axis.horizontal,
            children: [Box('A', size: 40), SizedBox(width: 8), Box('B', color: Colors.teal, size: 40)],
          ),
        ),

        SectionTitle('② Flex + Expanded:弹性比例分配'),
        LearnNote('同一个 Flex 里,Expanded 按 flex 比例分剩余空间。下面的 2:1。'),
        Container(
          color: Colors.grey.shade50,
          child: const Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(flex: 2, child: Box('2份', color: Colors.blue, size: 40)),
              SizedBox(width: 6),
              Expanded(flex: 1, child: Box('1份', color: Colors.indigo, size: 40)),
            ],
          ),
        ),

        SectionTitle('③ Flex + Spacer:留空档'),
        LearnNote('Spacer 就是“不吃内容、专门占位”的 Expanded。'),
        const Row(
          children: [Box('A'), Spacer(flex: 2), Box('B'), Spacer(flex: 1), Box('C')],
        ),

        SectionTitle('④ TextBaseline:基线对齐'),
        LearnNote('Flex 还有更精细的对齐选项,比如 baseline。一般用默认即可,知道存在就好。'),
      ],
    );
  }
}