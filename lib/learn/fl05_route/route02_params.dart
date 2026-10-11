// ============================================================
// 路由 2:传参 + 收返回值
//   进:用路由构造器把“参数”带过去(构造参数)。
//   出:pop 时把一个 result 塞回去,调用端用 await 接住。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class ParamPage extends StatelessWidget {
  const ParamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '路由·传参与返回',
      children: [
        KnowledgeCard('传参 / 收结果', '跳转时通过新页构造器传参数进去;新页要“跳回时带个值”,就 `Navigator.pop(context, 值)`,调用端 `final result = await Navigator.push(...)` 会接住。'),

        SectionTitle('① 传一个名字进去,选个结果带回来'),
        LearnNote('下面按钮跳去“选水果”页:它拿到你传的标题(name),你点一个水果,那个水果名会被 pop 带回来,显示在下方。'),
        const _PickDemo(),
      ],
    );
  }
}

class _PickDemo extends StatelessWidget {
  const _PickDemo();

  Future<void> _go(BuildContext context) async {
    // push 返回的 Future 里,带着新页 pop 塞回的结果
    final picked = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const _PickerPage(question: '想吃哪个?')),
    );
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(picked == null ? '没选(点了返回)' : '你选了:$picked')));
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () => _go(context),
      icon: const Icon(Icons.food_bank_outlined),
      label: const Text('去选水果'),
    );
  }
}

/// 目标页:接收参数,点一项就把值 pop 回去。
class _PickerPage extends StatelessWidget {
  const _PickerPage({required this.question});
  final String question; // 从调用端传入的参数

  @override
  Widget build(BuildContext context) {
    const fruits = ['🍎 苹果', '🍌 香蕉', '🍇 葡萄', '🍓 草莓'];
    return Scaffold(
      appBar: AppBar(
        title: Text(question),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.separated(
        itemCount: fruits.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, i) {
          return ListTile(
            leading: const Icon(Icons.circle, size: 12, color: Colors.teal),
            title: Text(fruits[i]),
            onTap: () => Navigator.pop(context, fruits[i]), // 把选择的带回去
          );
        },
      ),
    );
  }
}