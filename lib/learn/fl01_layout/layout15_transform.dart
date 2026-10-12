// ============================================================
// 知识点 15:Transform —— 变换(动画的地基)
//   rotate 旋转 / scale 缩放 / translate 平移 / translate 斜切。
//   视觉上改变一个控件,布局上它是“未变”的一块,
//   所以能叠加,也是各种动画效果的第一步。
// ============================================================

import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../common.dart';

class TransformPage extends StatelessWidget {
  const TransformPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: 'Transform 变换',
      children: [
        KnowledgeCard(
          'Transform',
          '用 Transform.scale / .rotate / .translate / .skew 在视觉上改变控件,不改布局。动画、倾斜徽章、翻转都从这里起步。',
        ),

        SectionTitle('① Transform.scale:缩放'),
        LearnNote('scale: 0.7 缩小、2 放大。注意:只变“看起来”,不占更多布局空间。'),
        Transform.scale(
          scale: 0.6,
          child: const Box('缩小0.6倍', color: Colors.blue, size: 80),
        ),

        SectionTitle('测试2'),
        // scale 与 scaleX/scaleY 互斥：统一缩放用 scale，横纵分开用 scaleX/scaleY
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Transform.scale(
              scale: 0.5,
              child: const Box('统一0.5', color: Colors.purple, size: 80),
            ),
            Transform.scale(
              scaleX: 1.5, // 横向拉伸
              scaleY: 0.5, // 纵向压扁
              child: const Box('横1.5纵0.5', color: Colors.orange, size: 80),
            ),
            Transform.flip(
              flipX: true, // 水平镜像翻转
              child: const Box('翻转', color: Colors.pink, size: 80),
            ),
          ],
        ),

        SectionTitle('② Transform.rotate:旋转'),
        LearnNote('angle 单位是弧度。Math.pi / 4 = 45°。做倾斜的“新贴图”徽章常用。'),
        Transform.rotate(
          angle: math.pi / 4,
          child: const Box('斜45°', color: Colors.teal, size: 80),
        ),

        SectionTitle('③ Transform.translate:平移'),
        LearnNote('offset 向右下移 (20, 10)。'),
        Transform.translate(
          offset: const Offset(20, 10),
          child: const Box('往下移', color: Colors.orange, size: 80),
        ),

        SectionTitle('④ 叠加 + 旋转徽章例子'),
        LearnNote(
          '三个 Transform 叠一起,做出一个“斜着的、放大的、带红色 NEW 角标”的卡片——动画和真实 App 里的花活都这么拼。',
        ),
        SizedBox(
          width: 160,
          height: 120,
          child: Stack(
            children: [
              Positioned(
                left: 20,
                top: 20,
                child: Transform.rotate(
                  angle: -0.15,
                  child: Container(
                    width: 110,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(2, 3),
                        ),
                      ],
                    ),
                    child: const Text(
                      '卡片',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 6,
                top: 2,
                child: Transform.rotate(
                  angle: 0.4,
                  child: const Stack(
                    children: [
                      Box('', color: Colors.red, size: 34),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'NEW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
