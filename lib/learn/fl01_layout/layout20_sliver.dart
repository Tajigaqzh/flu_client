import 'package:flutter/material.dart';
import '../common.dart';

class SliverPage extends StatelessWidget {
  const SliverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 170,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Sliver 混合滚动'),
              background: Container(color: Colors.teal.shade300, alignment: Alignment.center, child: const Icon(Icons.view_day, size: 64, color: Colors.white)),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const KnowledgeCard('CustomScrollView', '在同一滚动视口中组合 Sliver 列表、网格和普通 Widget。Sliver 根据滚动位置按需布局。'), const SectionTitle('普通内容放入 Sliver'), const LearnNote('SliverToBoxAdapter 是普通 Widget 与 Sliver 滚动协议之间的适配器。')]),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 112, child: ListView.separated(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: 8, separatorBuilder: (_, _) => const SizedBox(width: 8), itemBuilder: (context, index) => SizedBox(width: 130, child: Card(color: Colors.amber.shade100, child: Center(child: Text('横向卡片 ${index + 1}')))))),
          ),
          const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.fromLTRB(16, 18, 16, 8), child: Text('SliverList：懒加载列表', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)))),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(leading: CircleAvatar(child: Text('$index')), title: Text('列表项目 ${index + 1}'), subtitle: const Text('由 SliverChildBuilderDelegate 按需构建')),
              childCount: 12,
            ),
          ),
          const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.fromLTRB(16, 18, 16, 8), child: Text('SliverGrid：网格区域', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)))),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) => Container(color: Colors.indigo.shade100, alignment: Alignment.center, child: Text('网格 $index')), childCount: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 2.2),
            ),
          ),
          const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(16), child: LearnNote('大量内容优先用懒加载 Sliver。shrinkWrap 会让滚动子项更早测量，可能增加布局成本；嵌套滚动应先评估是否能合并到一个 CustomScrollView。'))),
        ],
      ),
    );
  }
}
