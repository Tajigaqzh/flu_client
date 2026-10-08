// ============================================================
// 动画 6:Hero —— 页面切换时,一个元素“飞过去”
//   让图片/卡片跨页面平滑过渡:起点页面一个 Hero,
//   终点页面一个同 tag 的 Hero,系统自动补出飞行动画。
//   最常见:列表里的卡片点进去成大图。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class HeroPage extends StatelessWidget {
  const HeroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: 'Hero 飞行动画',
      children: [
        KnowledgeCard('Hero', '页面 A 的图片 + 页面 B 的同名 tag 图片,切换时自动“飞”过去。写法:两边都包 Hero(tag: 「同名」 , child: 图片)。'),

        SectionTitle('① 点下面的卡片,看它飞到详情页'),
        LearnNote('点卡片 → 图片平滑飞成全屏大图,再按返回飞回来。两个页面必须给同一个 tag(这里叫 "rocket")。'),
        Center(
          child: Hero(
            tag: 'rocket',
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const _HeroTarget()),
                );
              },
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Colors.indigo, Colors.purple]),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))],
                  ),
                  child: const Icon(Icons.rocket_launch, color: Colors.white, size: 60),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const LearnNote('返回时,大图会反向飞回这个小卡片,很丝滑。'),
      ],
    );
  }
}

/// 目标页:同一个 tag 的大号 Hero。
class _HeroTarget extends StatelessWidget {
  const _HeroTarget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      appBar: AppBar(title: const Text('详情页')),
      body: Center(
        child: Hero(
          tag: 'rocket', // 必须和起点页的 tag 一样
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Colors.indigo, Colors.purple]),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(Icons.rocket_launch, color: Colors.white, size: 90),
          ),
        ),
      ),
    );
  }
}