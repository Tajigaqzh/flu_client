// ============================================================
// 知识点 4:弹性分配  Expanded / Flexible / Spacer
//   让某个孩子“占满剩余空间”,或留一块空档把别人推开。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class ElasticPage extends StatelessWidget {
  const ElasticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '弹性分配',
      children: [
        KnowledgeCard('弹性分配', 'Expanded=占满剩余空间(flex 定占比);Flexible=可伸缩但能被压缩;Spacer=透明占位,把两边的孩子推开。三者都只能用在 Row/Column 里。'),

        SectionTitle('① Expanded:占满剩余空间'),
        LearnNote('两个 Expanded,flex 2:1,剩余空间按 2:1 分。固定“固定A/”后剩下多少都给它们。'),
        Row(
          children: [
            const Box('固定A', size: 50),
            Expanded(
              flex: 2,
              child: Container(height: 50, color: Colors.purple, alignment: Alignment.center, child: const Text('Expanded 2', style: TextStyle(color: Colors.white))),
            ),
            Expanded(
              flex: 1,
              child: Container(height: 50, color: Colors.deepPurple, alignment: Alignment.center, child: const Text('1', style: TextStyle(color: Colors.white))),
            ),
          ],
        ),

        SectionTitle('② Flexible:可伸缩但不强撑'),
        LearnNote('默认 loose:空间够就不拉长,不够才压缩。比 Expanded 更“容忍”。'),
        Row(
          children: const [
            Box('20%', size: 50),
            Flexible(child: Box('Flexible 不强撑', color: Colors.indigo, size: 50)),
            Box('20%', size: 50),
          ],
        ),

        SectionTitle('③ Spacer:透明占位推开别人'),
        LearnNote('A──B──C,flex 2:1,左边空档是右边两倍。'),
        Row(
          children: const [
            Box('A'),
            Spacer(flex: 2),
            Box('B'),
            Spacer(flex: 1),
            Box('C'),
          ],
        ),
      ],
    );
  }
}