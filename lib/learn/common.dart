// ============================================================
// 知识点页面「复用组件」。
// 每个知识点页都用这套小组件,保证样式统一、代码精简。
// 你复刻时可以照抄这个文件。
// ============================================================

import 'package:flutter/material.dart';

/// 知识点页面脚手架:自动带标题栏 + 中间可滚动的正文。
/// 例:return KnowledgeScaffold(title: '加载图片', children: [ ... ]);
class KnowledgeScaffold extends StatelessWidget {
  const KnowledgeScaffold({required this.title, required this.children, super.key});
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: children,
      ),
    );
  }
}

/// 小结卡片:一个知识点给你「一句话总结」。
class KnowledgeCard extends StatelessWidget {
  const KnowledgeCard(this.title, this.line, {super.key});
  final String title;
  final String line;

  @override
  Widget build(BuildContext context) {
    return Container(
      // 铺满宽度
      width: double.infinity,
      // margin和padding
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),

      // 盒子装饰
      decoration: BoxDecoration(
        // 背景色
        color: Colors.green.shade50,
        // 圆角
        borderRadius: BorderRadius.circular(8),
        // 边框
        border: const Border(left: BorderSide(color: Colors.green, width: 3)),
      ),
      child: Text.rich(
        TextSpan(children: [
          TextSpan(text: '$title  ', style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: line),
        ]),
        style: const TextStyle(color: Colors.black87, height: 1.3),
      ),
    );
  }
}

/// 小节标题。
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 8),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal)),
    );
  }
}

/// 灰色说明文字。
class LearnNote extends StatelessWidget {
  const LearnNote(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(fontSize: 12, color: Colors.grey, height: 1.4)),
    );
  }
}

/// 彩色方块“积木”:让布局效果看得见。
/// 例:Box('A') / Box('B', color: Colors.red, size: 40)
class Box extends StatelessWidget {
  const Box(this.label, {this.color = Colors.blue, this.size = 50, super.key});
  final String label;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: color,
      alignment: Alignment.center,
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
    );
  }
}