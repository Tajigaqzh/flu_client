// ============================================================
// 知识点 8:网格布局  GridView
//   按“行 × 列”摆控件,而且能滚动。
//   相册九宫格、商品列表、emoji 面板都是它。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class GridPage extends StatelessWidget {
  const GridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '网格布局',
      children: [
        KnowledgeCard(
          'GridView',
          '按网格摆孩子:crossAxisCount=每行几个。主轴/交叉轴间距用 mainAxisSpacing / crossAxisSpacing。数据多再用 .builder 懒加载。',
        ),

        SectionTitle('① GridView.count:固定每行数量'),
        LearnNote('count 写死每行 4 个。下面 8 个格子自动排成两行。改成 3 会变成三列。'),
        // SizedBox(
        //   height: 150,
        //   child: GridView.count(
        //     crossAxisCount: 4,
        //     mainAxisSpacing: 6,
        //     crossAxisSpacing: 6,
        //     children: [
        //       for (var i = 0; i < 8; i++)
        //         Container(color: Colors.lightBlue.shade100, alignment: Alignment.center, child: Text('$i')),
        //     ],
        //   ),
        // ),

        SizedBox(
          height: 100,
          child: GridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 40,
            crossAxisSpacing: 20,
            children: List.generate(8, (i) {
              final showNum = i + 1;
              return Container(
                color: Colors.lightBlue.shade100,
                alignment: Alignment.center,
                child: Text("$showNum"),
              );
            }),
          ),
        ),

        SectionTitle('2.GridView.count:固定每行数量'),
        LearnNote('count 写死每行 4 个。下面 8 个格子自动排成两行。改成 3 会变成三列。'),

        SizedBox(
          height: 100,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(
              context,
            ).copyWith(scrollbars: false),
            child: GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 40,
              crossAxisSpacing: 20,
              children: List.generate(8, (i) {
                final showNum = i + 1;
                return Container(
                  color: Colors.lightBlue.shade100,
                  alignment: Alignment.center,
                  child: Text("$showNum"),
                );
              }),
            ),
          ),
        ),

        SectionTitle('3.GridView.count:固定每行数量'),
        LearnNote('count 写死每行 4 个。下面 8 个格子自动排成两行。改成 3 会变成三列。'),

        SizedBox(
          height: 100,
          child: ScrollbarTheme(
            data: ScrollbarThemeData(
              thumbColor: WidgetStateProperty.all(Colors.red),
              // thumbColor: WidgetStateProperty.all(Colors.teal),   // 滑块颜色
              thickness: WidgetStateProperty.all(10),
              // 滑块粗细
              radius: const Radius.circular(3),
              // 圆角
              trackColor: WidgetStateProperty.all(Colors.blue.shade400),
              // 轨道颜色
              trackVisibility: WidgetStateProperty.all(true), // 轨道默认看不见,要显式打开
            ),
            child: GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 40,
              crossAxisSpacing: 20,
              children: List.generate(8, (i) {
                final showNum = i + 1;
                return Container(
                  color: Colors.lightBlue.shade100,
                  alignment: Alignment.center,
                  child: Text("$showNum"),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
