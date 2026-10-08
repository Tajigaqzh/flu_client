// ============================================================
// 知识点:如何自定义图标
// 内置图标不够用时,三种自定义思路:
//   1) ImageIcon:拿一张图片当图标(最省事)
//   2) IconData:自定义字体图标(需要 iconfont 工具,最专业)
//   3) 组合/换颜色:图标其实是个字,可以随意浮动颜色、大小
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class CustomIconPage extends StatelessWidget {
  const CustomIconPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '自定义图标',
      children: [
        KnowledgeCard('自定义图标', '最快速:用 ImageIcon 把一张图资源当图标;专业向:做一套 iconfont 再用 IconData 引用。两者都能随主题变色。'),

        SectionTitle('① ImageIcon:图片当图标(最快)'),
        LearnNote('把 assets/images/demo.png 当成一个图标用,默认取图片本身颜色;给 color 则整体着色。'),
        Row(
          spacing: 20,
          children: const [
            ImageIcon(
              AssetImage('assets/images/demo.png'),
              size: 60, // 图标尺寸
            ),
            SizedBox(
              width: 60, height: 60,
              child: DecoratedBox(
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.teal),
                child: ImageIcon(AssetImage('assets/images/demo.png'), size: 40, color: Colors.white),
              ),
            ),
          ],
        ),

        SectionTitle('② IconData:自定义字体图标(专业)'),
        LearnNote('用 iconfont 工具把矢量图标生成一个 .ttf 字体,再注册到 pubspec,之后就能用自定义 IconData 引用:\n'
                 '  Icon(IconData(0xe001, fontFamily: \'MyIcons\'))\n'
                 '图标码(0xe001)由 iconfont 工具给出。这里先用内置码演示作用方式。'),
        Text('彩色可改:图标本质是字,颜色随意变:', style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Row(
          spacing: 16,
          children: const [
            Icon(Icons.rocket_launch, size: 36, color: Colors.deepOrange),
            Icon(Icons.rocket_launch, size: 36, color: Colors.purple),
            Icon(Icons.rocket_launch, size: 36, color: Colors.teal),
          ],
        ),

        SectionTitle('③ 用 Badge/Stack 增强图标'),
        LearnNote('给图标加小角标、叠文字,是自定义“视觉效果”的常用手法。'),
        Stack(
          children: [
            const Icon(Icons.notifications, size: 48),
            Positioned(
              right: 0, top: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}