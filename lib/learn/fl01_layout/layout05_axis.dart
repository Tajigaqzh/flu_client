// ============================================================
// 知识点 5:对齐概念
//   mainAxisAlignment(主轴怎么分布) /
//   crossAxisAlignment(交叉轴怎么对齐) / MainAxisSize(撑不撑满)
//   这是看懂任意 Row/Column 排布的关键。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class AxisPage extends StatelessWidget {
  const AxisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '对齐概念',
      children: [
        KnowledgeCard('主/交叉轴', '主轴=孩子排布的方向(Row 是水平,Column 是垂直);交叉轴=垂直另一个轴。mainAxisAlignment 管主轴分布,crossAxisAlignment 管交叉轴对齐。'),

        SectionTitle('① mainAxisAlignment:主轴分布'),
        LearnNote('spaceBetween=两端贴边、中间留空;spaceEvenly=每个间隙相等;center=整体居中;还有 spaceAround。'),
        Container(
          width: double.infinity,
          color: Colors.grey.shade100,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Box('一', size: 34),
              Box('二', size: 50),
              Box('三', size: 34),
            ],
          ),
        ),

        SectionTitle('① mainAxisAlignment:主轴分布'),
        LearnNote('spaceBetween=两端贴边、中间留空;spaceEvenly=每个间隙相等;center=整体居中;还有 spaceAround。'),
        Container(
          width: double.infinity,
          color: Colors.grey.shade100,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Box('一', size: 34),
              Box('二', size: 50),
              Box('三', size: 34),
            ],
          ),
        ),



        SectionTitle('① mainAxisAlignment:主轴分布'),
        LearnNote('spaceBetween=两端贴边、中间留空;spaceEvenly=每个间隙相等;center=整体居中;还有 spaceAround。'),
        Container(
          width: double.infinity,
          color: Colors.grey.shade100,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Box('一', size: 34),
              Box('二', size: 50),
              Box('三', size: 34),
            ],
          ),
        ),

        SectionTitle('① mainAxisAlignment:主轴分布'),
        LearnNote('spaceBetween=两端贴边、中间留空;spaceEvenly=每个间隙相等;center=整体居中;还有 spaceAround。'),
        Container(
          width: double.infinity,
          color: Colors.grey.shade100,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Box('一', size: 34),
              Box('二', size: 50),
              Box('三', size: 34),
            ],
          ),
        ),



        SectionTitle('① mainAxisAlignment:主轴分布'),
        LearnNote('spaceBetween=两端贴边、中间留空;spaceEvenly=每个间隙相等;center=整体居中;还有 spaceAround。'),
        Container(
          width: double.infinity,
          color: Colors.grey.shade100,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Box('一', size: 34),
              Box('二', size: 50),
              Box('三', size: 34),
            ],
          ),
        ),



        SectionTitle('① mainAxisAlignment:主轴分布'),
        LearnNote('spaceBetween=两端贴边、中间留空;spaceEvenly=每个间隙相等;center=整体居中;还有 spaceAround。'),
        Container(
          width: double.infinity,
          color: Colors.grey.shade100,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Box('一', size: 34),
              Box('二', size: 50),
              Box('三', size: 34),
            ],
          ),
        ),




        SectionTitle('② MainAxisSize:撑不撑满'),
        LearnNote('默认 max 撑满整行;改成 min 就只包内容宽度,右侧露空。'),
        Container(
          color: Colors.orange.shade50,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [Box('小', size: 30), Box('窄', size: 30)],
          ),
        ),

        SectionTitle('③ crossAxisAlignment:交叉轴对齐'),
        LearnNote('三个方块高度不同。想让他们“顶端对齐”就改成 CrossAxisAlignment.start。'),
        Container(
          height: 70,
          width: double.infinity,
          color: Colors.grey.shade100,
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Box('高', size: 60),
              Box('中', size: 40),
              Box('矮', size: 20),
            ],
          ),
        ),
      ],
    );
  }
}