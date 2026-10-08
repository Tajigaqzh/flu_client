// ============================================================
// 知识点 9:滚动布局  ListView / SingleChildScrollView
//   内容超出一屏时,让用户能往下滑。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class ScrollPage extends StatelessWidget {
  const ScrollPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '滚动布局',
      children: [
        KnowledgeCard('ListView / SingleChildScrollView', '一列可滚动用 ListView;只有一个内容却超高了,包一层 SingleChildScrollView 就能滚。数据多时 ListView 用 .builder 懒加载省内存。'),

        SectionTitle('① ListView:可滚动的一列'),
        LearnNote('下面是一个 20 项的列表,只截了高 120 的窗口看,能上下滚。'),
        SizedBox(
          height: 120,
          child: ListView.separated(
            itemCount: 20,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, i) => Text('列表项 #$i'),
          ),
        ),

        SectionTitle('② SingleChildScrollView:单个内容超高'),
        LearnNote('下面两个方块总高超出窗口,包一层后能下滑看到“第2行”。'),
        Container(
          height: 90,
          color: Colors.grey.shade50,
          child: const SingleChildScrollView(
            child: Column(
              children: [
                Box('第1行', color: Colors.deepOrange, size: 60),
                Box('超出高度,下滑可见', color: Colors.deepOrange, size: 60),
              ],
            ),
          ),
        ),
      ],
    );
  }
}