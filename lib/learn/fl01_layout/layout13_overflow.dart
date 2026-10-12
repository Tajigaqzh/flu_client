// ============================================================
// 知识点 13:溢出处理 OverflowBox
//   孩子超出父框时,默认会“黄黑相间”报错(RenderFlex overflow)。
//   OverflowBox 允许孩子溢出父框而不报错。
//   还讲两个配套:ClipRect(裁剪)/ FittedBox(缩放)。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class OverflowPage extends StatelessWidget {
  const OverflowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '溢出处理',
      children: [
        KnowledgeCard('溢出处理', '孩子太大会触发 overflow 红黄条报错。三种解法:OverflowBox 允许溢出、FittedBox 缩小到放得下、ClipRRect/ClipRect 裁掉超出部分。'),

        SectionTitle('① OverflowBox:允许孩子溢出'),
        LearnNote('下面父框高 50,孩子是 90 高的方块。普通 Column/Stack 会爆,OverflowBox 让它放心伸出去。'),
        Container(
          height: 50,
          color: Colors.grey.shade100,
          alignment: Alignment.centerLeft,
          child: OverflowBox(
            maxWidth: double.infinity,
            maxHeight: 100,
            alignment: Alignment.centerLeft,
            child: const Box('溢出', color: Colors.redAccent, size: 80),
          ),
        ),

        SectionTitle('② FittedBox:缩到放得下'),
        LearnNote('一个超长文本,包上 FittedBox 后自动缩到父框内。'),
        Container(
          height: 60,
          width: double.infinity,
          color: Colors.grey.shade100,
          child: const FittedBox(
            fit: BoxFit.contain,
            child: Text('这段超长文字本来会溢出,现在被缩小了'),
          ),
        ),

        SectionTitle('③ ClipRRect:裁掉超出部分'),
        LearnNote('一个方形图片,用 ClipOval/ClipRRect 裁成圆形头像,这正是“圆角 + 裁剪”组合。'),
        const ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          child: ImageIcon(AssetImage('assets/images/demo.png'), size: 80),
        ),
      ],
    );
  }
}