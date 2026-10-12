# lib/learn —— 知识目录

每个「知识点」 = 一个独立 Dart 文件。你看懂了就照抄一个小文件,从此自己会写。

## 目录结构

```text
lib/learn/
├─ README.md                      ← 本说明
├─ common.dart                    ← 知识点页面复用组件(照抄即可)
├─ menu.dart                      ← 知识菜单:把所有知识点列出来,点进去看
│
├─ fl01_layout/                   ← 第 1 章 · 布局(按知识点一文件一拆)
│   ├─ layout01_single.dart       ← 单子布局 Center / Align / Padding
│   ├─ layout02_size.dart         ← 尺寸约束 SizedBox / ConstrainedBox / AspectRatio…
│   ├─ layout03_row_column.dart   ← 横竖排布 Column / Row
│   ├─ layout04_elastic.dart      ← 弹性分配 Expanded / Flexible / Spacer
│   ├─ layout05_axis.dart         ← 对齐概念 mainAxisAlignment / crossAxisAlignment
│   ├─ layout06_stack.dart        ← 叠放 Stack / Positioned
│   ├─ layout07_wrap.dart         ← 自动换行 Wrap
│   ├─ layout08_grid.dart         ← 网格 GridView
│   ├─ layout09_scroll.dart       ← 滚动 ListView / SingleChildScrollView
│   ├─ layout10_style.dart        ← 样式 颜色 / 圆角 / 边框 / 渐变·阴影
│   ├─ layout11_constraints.dart  ← 约束传导 BoxConstraints(打地基)
│   ├─ layout12_flex.dart         ← 布局之根 Flex(Row/Column 的本质)
│   ├─ layout13_overflow.dart     ← 溢出处理 OverflowBox / FittedBox / Clip
│   ├─ layout14_layout_builder.dart ← 响应式 LayoutBuilder
│   ├─ layout15_transform.dart    ← 变换 Transform 旋转/缩放/平移
│   ├─ layout16_safe_area_media_query.dart ← SafeArea / MediaQuery / 键盘 Insets
│   ├─ layout17_unconstrained_intrinsic.dart ← UnconstrainedBox / LimitedBox / Intrinsic
│   ├─ layout18_clip.dart          ← ClipRect / ClipRRect / ClipOval / ClipPath
│   ├─ layout19_table_page_view.dart ← Table / 合并单元格 / 滚动
│   ├─ layout20_carousel.dart     ← 走马灯 PageView 轮播图 / 自动播放 / 指示器
│   ├─ layout21_sliver.dart       ← CustomScrollView / Sliver 列表与网格
│   ├─ layout22_responsive.dart   ← LayoutBuilder / OrientationBuilder / 断点
│   └─ layout23_custom_layout.dart ← CustomSingleChildLayout / MultiChildLayout / Flow
│
└─ fl02_media/                    ← 第 2 章 · 素材(图片/字体/图标)
    ├─ image_page.dart            ← 知识点:如何加载图片
    ├─ font_page.dart             ← 知识点:如何应用字体
    ├─ icon_page.dart             ← 知识点:如何设置图标
    └─ custom_icon_page.dart      ← 知识点:如何自定义图标

fl03_animation/                   ← 第 3 章 · 动画(由浅入深)
    ├─ animation01_implicit.dart  ← 隐式动画 AnimatedContainer / Opacity / Switcher
    ├─ animation02_controller.dart← 显式动画 AnimationController 三件套
    ├─ animation03_curve.dart     ← 曲线 CurvedAnimation
    ├─ animation04_tween.dart     ← Tween 映射到尺寸/颜色/位移
    ├─ animation05_builder.dart   ← AnimatedBuilder 局部重建
    ├─ animation06_hero.dart      ← Hero 页面切换飞行动画
    └─ animation07_spring.dart    ← 弹簧 SpringSimulation 回弹物理

fl04_state/                       ← 第 4 章 · 状态管理(由浅入深)
    ├─ state01_setstate.dart      ← setState 单个控件改自己
    ├─ state02_lifting.dart       ← 状态提升 + 回调下发(共享)
    ├─ state03_value_notifier.dart← ValueNotifier 局部监听
    ├─ state04_inherited.dart     ← InheritedWidget 全局共享
    └─ state05_compare.dart       ← 选型小结 + 对照表
```

## 一个知识点文件长这样

```dart
import 'package:flutter/material.dart';
import '../common.dart';      // 复用下面这些小组件

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(                 // 自动给「顶栏 + 可滚动正文」
      title: '你的知识点标题',
      children: [
        KnowledgeCard('一句话总结', '这控件是干嘛的、什么时候用。'),  // 小结卡片
        SectionTitle('① 第一小节'),
        LearnNote('灰色说明文字……'),
        // ……在这里放你的实际示例 UI……
      ],
    );
  }
}
```

## 新增一个知识点,三步

1. 在 `fl0X_xxx/` 里新建一个 `xxx_page.dart`(照着上面的模板)。
2. 在 `menu.dart` 里 `import 'fl0X_xxx/xxx_page.dart';` 并给 `_items` 加一行。
3. `flutter analyze` 无错后热重载,肉眼检查效果。

## 由浅入深路线(复习)

见 `docs/guide/index.md` 的 28 章规划。第 1–3 章(布局/状态)是地基,优先吃透。

布局第 16–22 章的知识说明和代码对应关系见 `docs/guide/fl01-layout-supplement.md`。
