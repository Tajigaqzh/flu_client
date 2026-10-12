import 'package:flutter/material.dart';
import '../common.dart';

class CustomLayoutPage extends StatelessWidget {
  const CustomLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '自定义布局',
      children: [
        KnowledgeCard('自定义布局', '常规布局无法清晰表达位置关系时，可通过 Delegate 测量子组件并指定位置。先判断 Stack、Wrap、Align 是否已经足够。'),
        SectionTitle('① CustomSingleChildLayout'),
        LearnNote('Delegate 根据父级约束确定容器尺寸，再决定唯一子组件的位置。这里把内容放在容器右下方。'),
        Container(
          height: 130,
          color: Colors.teal.shade50,
          child: CustomSingleChildLayout(
            delegate: const _BottomRightDelegate(),
            child: const Box('单子', color: Colors.teal, size: 54),
          ),
        ),
        SectionTitle('② CustomMultiChildLayout'),
        LearnNote('用 id 标识多个子组件，Delegate 依序测量并放置。适合有明确相对关系的头像和角标。'),
        SizedBox(
          height: 170,
          child: CustomMultiChildLayout(
            delegate: _BadgeLayoutDelegate(),
            children: [
              LayoutId(id: _BadgeSlot.avatar, child: const Box('头像', color: Colors.indigo, size: 88)),
              LayoutId(id: _BadgeSlot.badge, child: const Box('3', color: Colors.red, size: 28)),
            ],
          ),
        ),
        SectionTitle('③ Flow：按绘制坐标排列'),
        LearnNote('Flow 适合子项数量有限、位置需要快速自定义的场景；位置由 FlowDelegate 在绘制阶段计算。'),
        SizedBox(
          height: 95,
          child: Flow(
            delegate: const _ChipFlowDelegate(),
            children: List.generate(5, (index) => Chip(label: Text('标签 ${index + 1}'), backgroundColor: Colors.amber.shade100)),
          ),
        ),
        const KnowledgeCard('性能与选择', '自定义 Delegate 要正确实现 shouldRelayout。大量、动态或需无障碍语义的复杂布局，优先使用成熟的标准 Widget。'),
      ],
    );
  }
}

class _BottomRightDelegate extends SingleChildLayoutDelegate {
  const _BottomRightDelegate();

  @override
  Size getSize(BoxConstraints constraints) => Size(constraints.maxWidth, constraints.maxHeight);

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) => const BoxConstraints(maxWidth: 54, maxHeight: 54);

  @override
  Offset getPositionForChild(Size size, Size childSize) => Offset(size.width - childSize.width, size.height - childSize.height);

  @override
  bool shouldRelayout(covariant _BottomRightDelegate oldDelegate) => false;
}

enum _BadgeSlot { avatar, badge }

class _BadgeLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    final avatarSize = layoutChild(_BadgeSlot.avatar, BoxConstraints.loose(size));
    positionChild(_BadgeSlot.avatar, Offset((size.width - avatarSize.width) / 2, 26));
    final badgeSize = layoutChild(_BadgeSlot.badge, BoxConstraints.tight(const Size(28, 28)));
    positionChild(_BadgeSlot.badge, Offset((size.width + avatarSize.width) / 2 - badgeSize.width / 2, 18));
  }

  @override
  bool shouldRelayout(covariant _BadgeLayoutDelegate oldDelegate) => false;
}

class _ChipFlowDelegate extends FlowDelegate {
  const _ChipFlowDelegate();

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = 0.0;
    for (var i = 0; i < context.childCount; i++) {
      final size = context.getChildSize(i)!;
      if (x + size.width > context.size.width && x > 0) x = 0;
      context.paintChild(i, transform: Matrix4.translationValues(x, i.isEven ? 0 : 38, 0));
      x += size.width + 4;
    }
  }

  @override
  bool shouldRepaint(covariant _ChipFlowDelegate oldDelegate) => false;
}
