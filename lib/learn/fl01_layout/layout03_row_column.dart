// ============================================================
// 知识点 3:横竖排布  Column / Row
//   最常用的一对:Column 竖着排,Row 横着排。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class RowColumnPage extends StatelessWidget {
  const RowColumnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '横竖排布',
      children: [
        KnowledgeCard('Column / Row', 'Column 从上到下竖着排(表单、列表常用);Row 从左到右横着排。内容是“一列/一行”。'),

        SectionTitle('① Column:竖着排'),
        LearnNote('孩子从上到下摆。spacing 是孩子之间留的缝。'),
        Container(
          height: 170,
          color: Colors.grey.shade50,
          child: const Column(
            spacing: 6,
            children: [
              Box('上', size: 40, color: Colors.orange),
              Box('中', size: 50),
              Box('下', size: 40, color: Colors.orange),
            ],
          ),
        ),

        SectionTitle('② Row:横着排'),
        LearnNote('孩子从左到右摆。和 Column 用法一模一样,只是方向换了 90°。'),
        Container(
          color: Colors.grey.shade50,
          child: const Row(
            spacing: 6,
            children: [
              Box('左', color: Colors.blue),
              Box('右', color: Colors.blue),
            ],
          ),
        ),
      ],
    );
  }
}