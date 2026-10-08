// ============================================================
// 知识点 6:叠放布局  Stack / Positioned
//   让多个控件“层叠”在一起:后面的压在前面的上面。
//   Positioned 能在叠层里精确指定每个孩子的位置。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class StackPage extends StatelessWidget {
  const StackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '叠放布局',
      children: [
        KnowledgeCard('Stack / Positioned', 'Stack 把多个孩子叠在原点上(像 PS 图层);Positioned 能把它精确放到 top/right/left/bottom 指定的位置。做角标、悬浮按钮、头像上的红点都用它。'),

        SectionTitle('① Stack:层层叠加'),
        LearnNote('第一个孩子在最底,后面的依次往上压。颜色更深的最先画,浅的压在上面。'),
        SizedBox(
          height: 110,
          child: Stack(
            children: [
              Container(width: double.infinity, height: 90, color: Colors.grey.shade200),
              const Box('底层', color: Colors.red, size: 60),
              const Positioned(top: 30, right: 20, child: Box('右上', color: Colors.amber, size: 40)),
              const Positioned(bottom: 0, left: 80, child: Box('底部', color: Colors.black87, size: 30)),
            ],
          ),
        ),

        SectionTitle('② Positioned:精确定位'),
        LearnNote('top=距顶部,N 像素;right=距右;bottom/left 同理。这一行就把方块钉在右上角。'),
        Container(
          height: 90,
          color: Colors.grey.shade100,
          child: const Stack(
            children: [
              Positioned(top: 6, right: 6, child: Box('右上角', color: Colors.pink, size: 50)),
            ],
          ),
        ),
      ],
    );
  }
}