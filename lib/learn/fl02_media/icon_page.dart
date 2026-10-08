// ============================================================
// 知识点:如何设置图标
//   Icon:       摆一个图标,可设大小 / 颜色
//   IconButton: 能点击的图标按钮
//   内置的 Material Icons 有上千个,足够日常用
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class IconPage extends StatelessWidget {
  const IconPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '设置图标',
      children: [
        KnowledgeCard('设置图标', 'Icon(图标) 定大小/颜色;IconButton 加点击;图标要在 pubspec 里 enable uses-material-design(本项目已开)。'),

        SectionTitle('① 基本用法:大小 + 颜色'),
        LearnNote('Icons.xxx 是内置图标库,后面接图标名(Icons.home / Icons.star…)。点这文件夹里想看的就输名字。'),
        Row(
          spacing: 16,
          children: const [
            Icon(Icons.home, size: 32, color: Colors.teal),
            Icon(Icons.favorite, size: 32, color: Colors.red),
            Icon(Icons.star, size: 32, color: Colors.amber),
            Icon(Icons.settings, size: 32, color: Colors.blueGrey),
          ],
        ),

        SectionTitle('② 可点击的图标按钮 IconButton'),
        LearnNote('IconButton 自带一圈点击水波纹,onPressed 里写点下后要干嘛。'),
        Builder(builder: (context) {
          return IconButton(
            iconSize: 40,
            tooltip: '点我',
            icon: const Icon(Icons.thumb_up_alt_outlined, color: Colors.blue),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('你点了 👍'), duration: Duration(seconds: 1)),
              );
            },
          );
        }),

        SectionTitle('③ 常见 Material 图标一览'),
        LearnNote('常用的一批:导航(class/menu)、状态(check/error)、社交(share/favorite)、媒体(play)。'),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: const [
            Icon(Icons.home), Icon(Icons.menu), Icon(Icons.search),
            Icon(Icons.person), Icon(Icons.check_circle, color: Colors.green),
            Icon(Icons.cancel, color: Colors.red),
            Icon(Icons.warning_amber, color: Colors.orange),
            Icon(Icons.share), Icon(Icons.play_circle_outline),
            Icon(Icons.email), Icon(Icons.phone), Icon(Icons.lock),
          ],
        ),
      ],
    );
  }
}