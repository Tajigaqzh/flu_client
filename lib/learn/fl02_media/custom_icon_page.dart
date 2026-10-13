// ============================================================
// 知识点:如何自定义图标
// 内置图标不够用时,三种自定义思路:
//   1) ImageIcon:拿一张图片当图标(最省事)
//   2) IconData:自定义字体图标(需要 iconfont 工具,最专业)
//   3) 组合/换颜色:图标其实是个字,可以随意浮动颜色、大小
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';
import 'custom_icons.dart';

const _customIcons = <(String, IconData)>[
  ('播放', CustomIcons.play),
  ('地址', CustomIcons.address),
  ('更多', CustomIcons.more),
  ('点赞', CustomIcons.like),
  ('进入', CustomIcons.enter),
  ('关闭', CustomIcons.close),
  ('发送', CustomIcons.send),
  ('密码', CustomIcons.password),
  ('警告', CustomIcons.warning),
  ('客服', CustomIcons.customerService),
  ('删除', CustomIcons.delete),
  ('拍照', CustomIcons.camera),
  ('反馈', CustomIcons.feedback),
  ('关闭-1', CustomIcons.closeAlt),
  ('积分', CustomIcons.points),
  ('全屏', CustomIcons.fullscreen),
  ('设置', CustomIcons.settings),
  ('搜索', CustomIcons.search),
  ('互换', CustomIcons.exchange),
  ('首页', CustomIcons.home),
  ('完成', CustomIcons.done),
  ('添加', CustomIcons.add),
  ('时刻表', CustomIcons.timetable),
  ('完成任务', CustomIcons.taskDone),
  ('投票', CustomIcons.vote),
  ('邮箱', CustomIcons.email),
  ('文件', CustomIcons.file),
];

class CustomIconPage extends StatelessWidget {
  const CustomIconPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '自定义图标',
      children: [
        KnowledgeCard(
          '自定义图标',
          '最快速:用 ImageIcon 把一张图资源当图标;专业向:做一套 iconfont 再用 IconData 引用。两者都能随主题变色。',
        ),

        SectionTitle('① ImageIcon:图片当图标(最快)'),
        LearnNote('把 assets/images/demo.png 当成一个图标用,默认取图片本身颜色;给 color 则整体着色。'),
        Row(
          spacing: 20,
          children: const [
            ImageIcon(
              AssetImage('assets/images/demo.png'),
              size: 60, // 图标尺寸
            ),

            SizedBox(height: 50),
            SizedBox(
              width: 60,
              height: 60,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.teal,
                ),
                child: ImageIcon(
                  AssetImage('assets/images/demo.png'),
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),

        SectionTitle('② IconData:自定义字体图标(专业)'),
        LearnNote(
          '字体文件已在 pubspec.yaml 注册为 iconfont。每个图标用 iconfont 导出的 Unicode 编码创建 IconData。',
        ),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final (name, iconData) in _customIcons)
              SizedBox(
                width: 76,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(iconData, size: 30, color: Colors.teal),
                    const SizedBox(height: 4),
                    Text(name, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
          ],
        ),

        GridView.builder(
          shrinkWrap: true,
          // 让他自己不滚动，让外层复制滚动
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _customIcons.length,
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          // GridView 的网格布局规则，用来决定每个格子的尺寸、列数以及格子间距。
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final (name, iconData) = _customIcons[index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(iconData, size: 30, color: Colors.blueAccent),
                const SizedBox(height: 4),
                Text(name, style: const TextStyle(fontSize: 12)),
              ],
            );
          },
        ),

        SizedBox(height: 20),

        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          crossAxisCount: 4,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: [
            for (final (name, iconData) in _customIcons)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(iconData, size: 30, color: Colors.red),
                  SizedBox(height: 4),
                  Text(name, style: const TextStyle(fontSize: 12)),
                ],
              ),
          ],
        ),

        SizedBox(height: 20),



        SectionTitle('③ 用 Badge/Stack 增强图标'),
        LearnNote('给图标加小角标、叠文字,是自定义“视觉效果”的常用手法。'),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 48,
            height: 48,
            child: Stack(
              children: [
                const Icon(Icons.notifications, size: 48),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
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
      ],
    );
  }
}
