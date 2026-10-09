// ============================================================
// 知识点 11:约束传导 BoxConstraints(打地基·必看)
//   Flutter 布局唯一的底层规则,看懂它前面 10 课全通了:
//     父级给“约束”→ 孩子按约束返回“尺寸”→ 再决定“对齐”。
//   约束不是某个控件,而是一种“规则/约定”,体现为
//   minWidth / maxWidth / minHeight / maxHeight 四个值。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class ConstraintPage extends StatelessWidget {
  const ConstraintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '约束传导',
      children: [
        KnowledgeCard(
          'BoxConstraints',
          'Flutter 布局底层一条铁律:父级用 BoxConstraints(min/maxWidth、min/maxHeight)把“约束”传给孩子,孩子算好尺寸返回来。所有控件都是这套规则的套路。',
        ),

        const ConceptCard(),

        SectionTitle('① 约束 → 尺寸 → 对齐,三步走'),
        LearnNote(
          '举例:ConstrainedBox 传下 maxWidth=60,孩子想要 100,结果被压成 60。这就是“约束先于尺寸”。',
        ),
        Row(
          children: [
            const Box('自由100', color: Colors.purple),
            const SizedBox(width: 16),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 60, maxHeight: 60),
              child: const Box('被压60', color: Colors.deepPurple, size: 100),
            ),
          ],
        ),

        SectionTitle('② 四种约束场景'),
        LearnNote(
          '宽松约束(0~∞)=随孩子自己;紧约束(min=max)=孩子必须精确到这个尺寸;有上限=最多不能超过;有下限=最小不能小于。',
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Bound('宽松(0~∞)', 'min:0  max:∞  → 孩子想要多大就多大', Colors.blue),
            _Bound(
              '紧(max=min=80)',
              'min:80 max:80 → 固定 80,想大想小都不行',
              Colors.teal,
            ),
            _Bound('上限(max:60)', 'min:0  max:60 → 最多 60,小了随意', Colors.orange),
            _Bound('下限(min:90)', 'min:90 max:∞ → 至少 90,大了随意', Colors.purple),
          ],
        ),

        SectionTitle('③ 口诀'),
        LearnNote('「父给约束,子报尺寸,再谈对齐」。真正用起来你只需要记:缺哪个尺寸,就往上找最近那个“能给约束/尺寸”的控件。'),
      ],
    );
  }
}

/// 概念卡片:三种常见约束的代表控件。
class ConceptCard extends StatelessWidget {
  const ConceptCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        '常见约束来源:\n'
        '  ● 紧约束:SizedBox(w,h)、Container 给了 width/height\n'
        '  ● 宽松约束:Center、Align、ListView(垂直)的宽度方向\n'
        '  ● 上限约束:ConstrainedBox(maxWidth)、Column 的高度方向\n'
        '  ● 由你决定:Flexible、Expanded 这类由主轴剩余空间分配\n\n'
        '一个控件最终能多大 = 父级约束 ∩ 自身需求,取交集。',
        style: TextStyle(fontSize: 13, height: 1.6),
      ),
    );
  }
}

/// 一行“约束类型 → 效果”说明。
class _Bound extends StatelessWidget {
  const _Bound(this.title, this.desc, this.color);

  final String title;
  final String desc;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 70,
            padding: const EdgeInsets.symmetric(vertical: 6),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(desc, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}
