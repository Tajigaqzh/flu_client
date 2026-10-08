// ============================================================
// 知识点 14:LayoutBuilder —— 拿到约束再布局
//   给一个 builder,你会拿到 constraints(父级约束),
//   然后“用代码决定怎么摆”。做响应式适配的核心。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class LayoutBuilderPage extends StatelessWidget {
  const LayoutBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: 'LayoutBuilder',
      children: [
        KnowledgeCard('LayoutBuilder', '把父级约束(constraints)递给你,让你根据实际宽度/高度决定布局。屏幕宽度够就横排,不够就竖排——这就是响应式。'),

        SectionTitle('① 拿到宽度,动态排布'),
        LearnNote('拖动手机上半屏,当宽度超过 360 时改成横排,否则竖排。试试横竖屏旋转模拟器看变化。'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          color: Colors.grey.shade50,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 360;
              if (wide) {
                return const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Box('A', color: Colors.teal, size: 60),
                    Box('B', color: Colors.indigo, size: 60),
                    Box('C', color: Colors.orange, size: 60),
                  ],
                );
              }
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Box('A(窄)', color: Colors.teal, size: 60),
                  Box('B(窄)', color: Colors.indigo, size: 60),
                ],
              );
            },
          ),
        ),

        SectionTitle('② 显示当前约束'),
        LearnNote('直接在 builder 里读 constraints,把它打印到界面上,最直观理解“约束传导”。'),
        LayoutBuilder(
          builder: (context, c) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.blue.shade50,
              child: Text(
                '父级给我:宽 ${c.maxWidth.toStringAsFixed(0)} ~ 高 ${c.maxHeight.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 13),
              ),
            );
          },
        ),
      ],
    );
  }
}