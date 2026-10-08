// ============================================================
// 路由 3:命名路由 + onGenerateRoute
//   把“/detail”这类路径和页面绑定成一个表,代码里用
//   字符串跳转。适合页面多、要集中管理跳转路径的工程。
//   本页自带一个迷你 MaterialApp 演示完整配置。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class NamedPage extends StatelessWidget {
  const NamedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '路由·命名路由',
      children: [
        KnowledgeCard('named route', '在 MaterialApp 里用 routes: 把“路径字符串”和页面绑好(或 onGenerateRoute 动态生成),之后 `Navigator.pushNamed(context, "/detail")` 按名字跳。优点:跳转逻辑集中、直观。'),

        const PubspecCodeCard(),
        const SizedBox(height: 10),

        SectionTitle('① 迷你演示(自带一个 MaterialApp)'),
        LearnNote('下面嵌套了一个小的 MaterialApp,它有 routes: / 和 /detail。点按钮 `pushNamed("/detail", arguments: …)` 跳过去。命名路由的好处是:路径集中写在一处,改一处全生效。'),
        const _NamedDemoApp(),
      ],
    );
  }
}

/// 展示 MaterialApp 里 routes 怎么写。
class PubspecCodeCard extends StatelessWidget {
  const PubspecCodeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blueGrey.shade200),
      ),
      child: const Text(
        'MaterialApp(\n'
        '  initialRoute: \'/\',\n'
        '  routes: {\n'
        '    \'/\':      (c) => const HomePage(),\n'
        '    \'/detail\': (c) => const DetailPage(),\n'
        '  },\n'
        ')',
        style: TextStyle(fontFamily: 'monospace', fontSize: 13, height: 1.6),
      ),
    );
  }
}

/// 自带命名路由的迷你 App。
class _NamedDemoApp extends StatelessWidget {
  const _NamedDemoApp();

  @override
  Widget build(BuildContext context) {
    // 一个带命名路由 + 全局红的 MaterialApp,完全独立于外层。
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      initialRoute: '/',
      routes: {
        '/': (c) => const _Home(),
        '/detail': (c) => const _NamedDetail(),
      },
    );
  }
}

class _Home extends StatelessWidget {
  const _Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('迷你App·首页')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('命名路由演示', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => Navigator.pushNamed(context, '/detail'), // 按名字跳
              child: const Text('pushNamed → /detail'),
            ),
          ],
        ),
      ),
    );
  }
}

class _NamedDetail extends StatelessWidget {
  const _NamedDetail();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('详情页(被命名路由跳来)')),
      body: const Center(child: Text('我是 /detail 页面', style: TextStyle(fontSize: 18))),
    );
  }
}