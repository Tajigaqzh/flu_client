// ============================================================
// 知识点 1:单子布局  Center / Align / Padding
//   专门管“只有一个孩子”怎么摆。
//   Center=居中;Align=任意位置;Padding=四周留白。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class SinglePage extends StatelessWidget {
  const SinglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '单子布局',
      children: [
        KnowledgeCard(
          '单子布局',
          '只有一个孩子想摆位置时用这三种:Center 居中、Align 指到任意角、Padding 四周留白。',
        ),

        SectionTitle('① Center:水平垂直都居中'),
        LearnNote('只有一个孩子且要居中 → 用它。是 Align 的“居中特例”。'),
        Container(
          height: 110,
          width: double.infinity,
          color: Colors.grey.shade100,
          child: const Center(
            child: Box('居中', color: Colors.blueGrey, size: 40),
          ),
        ),

        SectionTitle('② Align:能指到任意位置'),
        LearnNote('比 Center 自由:alignment 填右上/左下/右下…值越大越靠边。改成 bottomLeft 试试。'),
        Container(
          height: 150,
          width: double.infinity,
          color: Colors.grey.shade100,
          child: const Align(
            alignment: Alignment.topRight,
            child: Box('右上', color: Colors.indigo, size: 40),
          ),
        ),
        LearnNote(
          'Align 会在父级区域中摆放孩子。这里让 Stack 位于左侧，并用 SizedBox 限定为图标大小，这样 Positioned 的 right/top 就相对图标定位。',
        ),
        Container(
          width: double.infinity,
          color: Colors.grey.shade100,
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 48,
              height: 48,
              child: Stack(
                children: [
                  const Icon(Icons.notifications, size: 48),
                  Positioned(
                    right: 4,
                    top: 2,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        '3',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        SectionTitle('③ Padding:四周留白'),
        LearnNote('给内容四周加“内边距”。值越大,内容离边越远。'),
        Container(
          width: double.infinity,
          color: Colors.grey.shade50,
          child: const Padding(
            padding: EdgeInsets.all(24),
            child: Box('内容', color: Colors.green, size: 60),
          ),
        ),

        Container(
          height: 150,
          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
          color: Colors.red,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(width: 40, height: 40, color: Colors.amberAccent),
          ),
        ),
      ],
    );
  }
}
