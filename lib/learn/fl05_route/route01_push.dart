// ============================================================
// 路由 1:Navigator.push / pop —— 最基本的跳转
//   页面 = 一摞“路由栈”。push 把新页压到最上面,pop 弹走最上面。
//   点“返回”或 Navigator.pop(context) 都能回到上一页。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class PushPage extends StatelessWidget {
  const PushPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '路由·基本跳转',
      children: [
        KnowledgeCard('Navigator.push', 'Navigator 是一摞页面的栈。`Navigator.push(context, MaterialPageRoute(builder: (c) => 新页))` 把新页压到顶上;新页里 `Navigator.pop(context)` 弹走它,回到上一页。'),

        SectionTitle('① 跳过去,再回来'),
        LearnNote('点下面按钮 → 跳到第二页(有标题栏和自动返回键)→ 点返回回来。注意:新页自己带个 AppBar 就有了“← 返回”键。'),
        FilledButton.icon(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const _SecondPage()),
          ),
          icon: const Icon(Icons.arrow_forward),
          label: const Text('跳到第二页'),
        ),

        SectionTitle('② 要点'),
        LearnNote('● MaterialPageRoute(builder:) 是最常用的路由,自带翻页动画。\n'
                 '● push 是“入栈”,pop 是“出栈”,后进先出。\n'
                 '● 上一页并没有被销毁,只是被压到底下,pop 回来它还活着。'),
      ],
    );
  }
}

/// 目标页:自己就是一个 Scaffold,自带返回键。
class _SecondPage extends StatelessWidget {
  const _SecondPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('第二页'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('我压在你上面', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => Navigator.pop(context), // 弹栈回上一页
              child: const Text('返回(等价于点左上角 ←)'),
            ),
          ],
        ),
      ),
    );
  }
}