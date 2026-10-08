// ============================================================
// 状态管理 2:状态提升 + 回调
//   当一个状态要被“多个控件”读到或改到,就把它上升到
//   它们的共同祖先,再往下传“值 + 修改回调”。
//   Flutter 父子通信的标配姿势(没有第三方库也能用)。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class LiftingPage extends StatelessWidget {
  const LiftingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '状态提升',
      children: [
        KnowledgeCard('状态提升', '两个互不相识的兄弟都需要同一个数字:把数字放到它们的父级(公共祖先),父级把“值”传给要读的,把“改它的回调”传给要改的。数据向上放、变更向下传。'),

        SectionTitle('① 场景:一个按钮加,一个屏显示'),
        LearnNote('左按钮在子A里,右屏在子B里,它俩不认识。共同父级持有 _count:\n'
                 ' ● 传给 B 的是值 count\n'
                 ' ● 传给 A 的是回调 onAdd(改完里面 setState)。\n'
                 '子 A 点按钮只是调用父级给的 onAdd,自己不管状态。'),
        const _LiftDemox(),
      ],
    );
  }
}

/// 父级:持有状态 + 两个子控件分享。
class _LiftDemox extends StatefulWidget {
  const _LiftDemox();

  @override
  State<_LiftDemox> createState() => _LiftDemoxState();
}

class _LiftDemoxState extends State<_LiftDemox> {
  int _count = 0;

  void _add() => setState(() => _count++);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 子B:显示数值(父级把值传进来)
        _Display(count: _count),
        const SizedBox(height: 12),
        // 子A:按钮(父级把回调传进来)
        Row(
          children: [
            Expanded(child: _AddButton(onAdd: _add)),
            Expanded(
              child: Container(
                height: 44,
                alignment: Alignment.center,
                color: Colors.teal.shade50,
                child: const Text('总次数会显示在上方', style: TextStyle(fontSize: 12, color: Colors.black54)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const LearnNote('两个子控件代码很短、各自只管自己:一个只管“按“,一个只管“显示”。状态 _count 高高在上,谁都不直接拥有,只经过父级传递。'),
      ],
    );
  }
}

/// 子 B:只负责展示。它是 StatelessWidget,因为数据全来自父级。
class _Display extends StatelessWidget {
  const _Display({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$count', style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: Colors.indigo)),
        Text('(由父级传来的值画出)', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
      ],
    );
  }
}

/// 子 A:只负责触发。不知道状态,只调用回调。
class _AddButton extends StatelessWidget {
  const _AddButton({required this.onAdd});
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: onAdd, child: const Text('子A: +1'));
  }
}