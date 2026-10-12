import 'package:flutter/material.dart';
import '../common.dart';

class ResponsiveLayoutPage extends StatelessWidget {
  const ResponsiveLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '响应式布局',
      children: [
        KnowledgeCard(
          '响应式',
          '根据可用空间调整结构，而不是按设备型号写死尺寸。LayoutBuilder 观察局部约束，MediaQuery 读取整个窗口信息。',
        ),
        SectionTitle('① LayoutBuilder：按宽度断点切换'),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final columns = width >= 900
                ? 3
                : width >= 600
                ? 2
                : 1;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LearnNote(
                  '当前可用宽度 ${width.toStringAsFixed(0)}；布局列数 $columns。旋转设备或调整桌面窗口宽度观察变化。',
                ),
                SizedBox(
                  height: 250,
                  child: Row(
                    children: [
                      if (columns >= 2)
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.teal.shade100,
                            alignment: Alignment.center,
                            child: const Text('导航栏'),
                          ),
                        ),
                      if (columns >= 2) const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.blue.shade50,
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '主要内容',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Expanded(
                                child: GridView.count(
                                  crossAxisCount: columns,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  children: List.generate(
                                    6,
                                    (i) => Container(
                                      color: Colors.indigo.shade100,
                                      alignment: Alignment.center,
                                      child: Text('卡片 ${i + 1}'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (columns >= 3) const SizedBox(width: 8),
                      if (columns >= 3)
                        Expanded(
                          child: Container(
                            color: Colors.orange.shade100,
                            alignment: Alignment.center,
                            child: const Text('辅助信息'),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        SectionTitle('② OrientationBuilder：方向适配'),
        SizedBox(
          height: 110,
          child: OrientationBuilder(
            builder: (context, orientation) => Container(
              color: Colors.pink.shade50,
              alignment: Alignment.center,
              child: Text(
                orientation == Orientation.portrait ? '竖屏：上下排列' : '横屏：左右排列',
              ),
            ),
          ),
        ),
        const SectionTitle('③ 选择正确的信息来源'),
        const LearnNote(
          'MediaQuery.size 是整个应用窗口尺寸；LayoutBuilder.constraints 是当前父组件分配给此处的尺寸。嵌在侧栏里的组件应优先看局部约束。',
        ),
        const KnowledgeCard('练习', '尝试把断点改成 500 / 800，并让卡片在窄屏单列、中屏双列、宽屏三列。'),
      ],
    );
  }
}
