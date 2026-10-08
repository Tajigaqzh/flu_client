// ============================================================
// 状态管理 4:InheritedWidget —— 祖先给“任意后代”递值
//   想“全 App 共享一份数据”,又不想一层层手动传参,
//   就用 InheritedWidget 把它挂在祖先上,后代用
//   context.dependOnInheritedWidgetOfExactType<T>() 直接取。
//   全部是 Flutter 内置,Provider 就是它的增强版封装。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class InheritedPage extends StatelessWidget {
  const InheritedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: 'InheritedWidget',
      children: [
        KnowledgeCard('InheritedWidget', '往祖先放一份“全局数据”,后代不拿参数、用一行取。改它时依赖它的后代自动重建。这是把 Provider / Riverpod 的底层原理。'),

        // 演示区的顶层自己会创建 MainBox,这里直接放演示
        const _SharedDemo(),

        SectionTitle('① 怎么用(三步写在自己项目里)'),
        LearnNote('1. 建一个类 extends InheritedWidget,构造里存数据,并 override updateShouldNotify(旧新不同才通知)。\n'
                 '2. 用 widget: 把这个类放到要共享的范围顶部。\n'
                 '3. 后代里 `MyData.of(context)` 就能读(它内部调 dependOnInheritedWidgetOfExactType)。\n'
                 '下面就是 live 示例,一个全局开关被两个地方共用。'),
      ],
    );
  }
}

// ---------- 定义:一个全局“字体是否加粗”开关的 InheritedWidget ----------

class MainBox extends InheritedWidget {
  const MainBox({required this.bold, required super.child, super.key});
  final bool bold; // 全局数据

  // 提供给后代读取的便捷方法(内部用 dependOn… 注册依赖)
  static MainBox? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MainBox>();

  // 数据变了才通知依赖的后代重建
  @override
  bool updateShouldNotify(MainBox old) => old.bold != bold;
}

// ---------- 顶层:持有一个 bool,负责更新 MainBox ----------

class _SharedDemo extends StatefulWidget {
  const _SharedDemo();

  @override
  State<_SharedDemo> createState() => _SharedDemoState();
}

class _SharedDemoState extends State<_SharedDemo> {
  bool _bold = false;

  @override
  Widget build(BuildContext context) {
    return MainBox(
      bold: _bold, // 每次 setState 换新值,通知到所有后代
      child: Column(
        children: [
          _SwitchRow(bold: _bold, onChanged: (v) => setState(() => _bold = v)),
          const Divider(height: 12),
          // 两个“不相干”的后代,都靠 MainBox.of 拿到同一个 bold,而不是传参
          const _TextA(),
          const SizedBox(height: 6),
          const _TextB(),
        ],
      ),
    );
  }
}

/// 一个开关,改 MainBox 的全局值。
class _SwitchRow extends StatelessWidget {
  const _SwitchRow({required this.bold, required this.onChanged});
  final bool bold;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('全局粗体开关:'),
        Switch(value: bold, onChanged: onChanged),
      ],
    );
  }
}

/// 后代A:不接收参数,直接读全局。
class _TextA extends StatelessWidget {
  const _TextA();

  @override
  Widget build(BuildContext context) {
    final bold = MainBox.of(context)?.bold ?? false; // 一行读全局
    return Text('(A) 这个"A"的粗细跟着全局走', style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal, fontSize: 16));
  }
}

/// 后代B:同样不传参,也能读到同一份。
class _TextB extends StatelessWidget {
  const _TextB();

  @override
  Widget build(BuildContext context) {
    final bold = MainBox.of(context)?.bold ?? false;
    return Text('(B) 开关一开,我(A 和 B)一起变粗', style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal, fontSize: 16));
  }
}