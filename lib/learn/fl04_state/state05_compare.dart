// ============================================================
// 状态管理 5:选型小结 —— 什么时候用哪种
//   前面四种是“由小到大”的梯度。这页给一张对照表，
//   让你知道手头场景该上哪个,不至于一上来就杀鸡用牛刀。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class ComparePage extends StatelessWidget {
  const ComparePage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '状态管理选型',
      children: [
        KnowledgeCard('选型', '状态越多、越要跨页面共享,手段就越高层。基础永远是你打不散的功底。'),

        SectionTitle('① 一句话记法'),
        const ConclusionCard(),

        SectionTitle('② 四种对照表'),
        const TableCard(),

        SectionTitle('③ 下一步:第三方库'),
        LearnNote('当 App 很大、一个全局量被几十处读写、还要能调试时间旅行时,就该上 Provider(包了 InheritedWidget,约 1 个依赖)或 Riverpod(更稳、编译期安全)。它们的 API 基于这套思想,学完上面你再碰它们会很顺。'),
      ],
    );
  }
}

class ConclusionCard extends StatelessWidget {
  const ConclusionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(10)),
      child: const Text(
        '一个控件自己改自己 → setState\n'
        '几个兄弟要共享 → 状态提升\n'
        '整块区域随一个值走 → ValueNotifier\n'
        '全局一份、到处能读 → InheritedWidget\n'
        '很大很复杂 → Provider / Riverpod\n'
        '\n不要为了用而用:能 setState 解决的,别上完整状态库。',
        style: TextStyle(fontSize: 13, height: 1.7),
      ),
    );
  }
}

class TableCard extends StatelessWidget {
  const TableCard({super.key});

  @override
  Widget build(BuildContext context) {
    const data = <List<String>>[
      ['setState', '最简单', '局部小改'],
      ['状态提升', '父子/兄弟共享', '跨 2-3 层传参'],
      ['ValueNotifier', '局部监听', '一个大模块'],
      ['InheritedWidget', '全局共享', '全 App 一套主题/登录态'],
    ];
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          const _Row(['方案', '特点', '适合'], header: true),
          for (final r in data) _Row(r),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.cells, {this.header = false});
  final List<String> cells;
  final bool header;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: header ? Colors.teal.shade50 : null,
        border: const Border(top: BorderSide(color: Colors.grey, width: 0.3)),
      ),
      child: Row(
        children: [
          SizedBox(width: 110, child: Text(cells[0], style: TextStyle(fontWeight: header ? FontWeight.bold : FontWeight.w600))),
          Expanded(flex: 1, child: Text(cells[1], style: const TextStyle(fontSize: 12))),
          Expanded(flex: 2, child: Text(cells[2], style: TextStyle(fontSize: 12, color: Colors.grey.shade800))),
        ],
      ),
    );
  }
}