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
            expandedHeight: 10,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('滚动'),
              background: Container(color: Colors.red.shade50),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsetsGeometry.only(left: 15, top: 10, right: 15),
              child: Column(
                children: [
                  KnowledgeCard(
                    '测试',
                    '君不见黄河之水天上来，奔流到海不复回。君不见高堂明镜悲白发，朝如青丝暮成雪。人生得意须尽欢，莫使金樽空对月',
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 130,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 8,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) => SizedBox(
                  width: 130,
                  child: Card(
                    color: Colors.amber.shade100,
                    child: Center(child: Text('横向卡片 ${index + 1}')),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsetsGeometry.only(top: 10),
              child: SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  // ListView 默认是竖向的，而且在没有指定 padding 时，可能会自动加上屏幕顶部的安全区间距
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => SizedBox(
                    // width: 50,
                    height: 100,
                    child: Card(
                      color: Colors.blue.shade100,
                      child: Center(child: Text('测试')),
                    ),
                  ),
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemCount: 8,
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsetsGeometry.only(top: 10),
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: 10,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.zero,
                    height: 50,
                    margin: EdgeInsets.only(bottom: index == 9 ? 0 : 10),
                    alignment: Alignment.center,
                    color: Colors.blueAccent.shade100,

                    // 斜体还可以通过TextStyle实现 fontStyle:FontStyle.italic
                    child: Transform(
                      transform: Matrix4.skewX(-0.25),
                      child: Text(
                        'item',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 18, 16, 8),
              child: Text(
                'SliverGrid：网格区域',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const KnowledgeCard(
                    'CustomScrollView',
                    '在同一滚动视口中组合 Sliver 列表、网格和普通 Widget。Sliver 根据滚动位置按需布局。',
                  ),
                  const SectionTitle('普通内容放入 Sliver'),
                  const LearnNote(
                    'SliverToBoxAdapter 是普通 Widget 与 Sliver 滚动协议之间的适配器。',
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 18, 16, 8),
              child: Text(
                'SliverList：懒加载列表',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                leading: CircleAvatar(child: Text('$index')),
                title: Text('列表项目 ${index + 1}'),
                subtitle: const Text('由 SliverChildBuilderDelegate 按需构建'),
              ),
              childCount: 12,
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                'SliverGrid：网格区域',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                  color: Colors.red.shade100,
                  alignment: Alignment.center,
                  child: Text('测试'),
                ),
                childCount: 8,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 2,
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                  color: Colors.indigo.shade100,
                  alignment: Alignment.center,
                  child: Text('网格 $index'),
                ),
                childCount: 8,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 2.2,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: LearnNote(
                '大量内容优先用懒加载 Sliver。shrinkWrap 会让滚动子项更早测量，可能增加布局成本；嵌套滚动应先评估是否能合并到一个 CustomScrollView。',
              ),
            ),
          ),
        ],
      ),
    );
    // return Scaffold(
    //   body: CustomScrollView(
    //     slivers: [
    //       SliverAppBar(
    //         pinned: true,
    //         expandedHeight: 170,
    //         flexibleSpace: FlexibleSpaceBar(
    //           title: const Text('Sliver 混合滚动'),
    //           background: Container(color: Colors.teal.shade300, alignment: Alignment.center, child: const Icon(Icons.view_day, size: 64, color: Colors.white)),
    //         ),
    //       ),
    //       SliverToBoxAdapter(
    //         child: Padding(
    //           padding: const EdgeInsets.all(16),
    //           child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const KnowledgeCard('CustomScrollView', '在同一滚动视口中组合 Sliver 列表、网格和普通 Widget。Sliver 根据滚动位置按需布局。'), const SectionTitle('普通内容放入 Sliver'), const LearnNote('SliverToBoxAdapter 是普通 Widget 与 Sliver 滚动协议之间的适配器。')]),
    //         ),
    //       ),
    //       SliverToBoxAdapter(
    //         child: SizedBox(height: 112, child: ListView.separated(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: 8, separatorBuilder: (_, _) => const SizedBox(width: 8), itemBuilder: (context, index) => SizedBox(width: 130, child: Card(color: Colors.amber.shade100, child: Center(child: Text('横向卡片 ${index + 1}')))))),
    //       ),
    //       const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.fromLTRB(16, 18, 16, 8), child: Text('SliverList：懒加载列表', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)))),
    //       SliverList(
    //         delegate: SliverChildBuilderDelegate(
    //           (context, index) => ListTile(leading: CircleAvatar(child: Text('$index')), title: Text('列表项目 ${index + 1}'), subtitle: const Text('由 SliverChildBuilderDelegate 按需构建')),
    //           childCount: 12,
    //         ),
    //       ),
    //       const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.fromLTRB(16, 18, 16, 8), child: Text('SliverGrid：网格区域', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)))),
    //       SliverPadding(
    //         padding: const EdgeInsets.symmetric(horizontal: 16),
    //         sliver: SliverGrid(
    //           delegate: SliverChildBuilderDelegate((context, index) => Container(color: Colors.indigo.shade100, alignment: Alignment.center, child: Text('网格 $index')), childCount: 8),
    //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 2.2),
    //         ),
    //       ),
    //       const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(16), child: LearnNote('大量内容优先用懒加载 Sliver。shrinkWrap 会让滚动子项更早测量，可能增加布局成本；嵌套滚动应先评估是否能合并到一个 CustomScrollView。'))),
    //     ],
    //   ),
    // );
  }
}
