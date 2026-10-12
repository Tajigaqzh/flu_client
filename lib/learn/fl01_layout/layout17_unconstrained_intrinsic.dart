import 'package:flutter/material.dart';
import '../common.dart';

class UnconstrainedIntrinsicPage extends StatelessWidget {
  const UnconstrainedIntrinsicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '约束扩展 / Intrinsic',
      children: [
        KnowledgeCard('约束扩展', 'UnconstrainedBox 暂时放松约束；LimitedBox 只在收到无限约束时提供上限；Intrinsic 按子内容尺寸做额外测量。'),
        SectionTitle('① UnconstrainedBox：放松约束'),
        LearnNote('外层宽度只有 180，子项仍按 260 宽布局，因此会溢出。它不会自动缩放；需要缩放时考虑 FittedBox，需要允许尺寸超界时考虑 OverflowBox。'),
        Container(
          width: 180,
          height: 70,
          alignment: Alignment.centerLeft,
          color: Colors.red.shade50,
          child: const UnconstrainedBox(
            alignment: Alignment.centerLeft,
            child: SizedBox(width: 260, child: Box('260 宽的子组件', color: Colors.deepOrange)),
          ),
        ),
        SectionTitle('② LimitedBox：限制无限尺寸'),
        LearnNote('在有限约束下它基本不改变尺寸；当父级给出无限宽度时，maxWidth 才会成为上限。'),
        SizedBox(
          height: 54,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              LimitedBox(maxWidth: 150, child: Box('最多 150', color: Colors.teal)),
              SizedBox(width: 8),
              Box('第二项', color: Colors.indigo),
            ],
          ),
        ),
        SectionTitle('③ IntrinsicWidth：内容决定宽度'),
        LearnNote('按钮按最长文本统一宽度。IntrinsicWidth 会进行额外布局测量，复杂或大量列表中应谨慎使用。'),
        IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton(onPressed: () {}, child: const Text('短')),
              FilledButton(onPressed: () {}, child: const Text('较长的按钮文字')),
            ],
          ),
        ),
        SectionTitle('④ IntrinsicHeight：子项统一高度'),
        LearnNote('Row 的高度取最高子项，再让其他子项匹配；IntrinsicHeight 同样会增加测量成本。'),
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(child: Container(color: Colors.blue.shade100, alignment: Alignment.center, child: const Text('短内容'))),
              const VerticalDivider(width: 2),
              Expanded(child: Container(color: Colors.amber.shade100, child: const Text('较长内容\n第二行\n第三行'))),
            ],
          ),
        ),
        const KnowledgeCard('选择提示', '优先用明确约束、Expanded/Flexible 和 LayoutBuilder。Intrinsic 用在小型、有限的布局中更合适。'),
      ],
    );
  }
}
