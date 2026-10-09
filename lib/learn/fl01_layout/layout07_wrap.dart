// ============================================================
// 知识点 7:自动换行  Wrap
//   一行放不下时,自动换到下一行(就像文字会自动折行)。
//   做“标签”、“筛选项”这种带很多小块的布局很合适。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class WrapPage extends StatelessWidget {
  const WrapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '自动换行',
      children: [
        KnowledgeCard(
          'Wrap',
          '一行塞不下就自动换行。spacing 是同一行里孩子间的缝,runSpacing 是换行之后两行之间的缝。',
        ),

        SectionTitle('① Wrap:自动换行'),
        LearnNote('孩子多了会自己折成多行。改小 spacing 缝隙更窄。'),
        Container(
          width: double.infinity,
          color: Colors.grey.shade50,
          child: const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Box('标签', size: 44),
              Box('太多', size: 44),
              Box('自动', size: 44),
              Box('换行', size: 44),
              Box('换行', size: 44),
              Box('换行', size: 44),
              Box('换行', size: 44),
              Box('换行', size: 44),
              Box('换行', size: 44),
              Box('换行', size: 44),
              Box('换行', size: 44),
              Box('换行', size: 44),
              Box('换行', size: 44),
              Box('换行', size: 44),
              Box('换行', size: 44),
              Box('换行', size: 44),
              Box('换行', size: 44),
              Box('换行', size: 44),
              Box('换行', size: 44),
              Box('换行', size: 44),
              Box('换行', size: 44),
              Box('换行', size: 44),
              Box('✓', size: 44),
            ],
          ),
        ),
      ],
    );
  }
}
