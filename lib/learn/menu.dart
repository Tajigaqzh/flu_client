// ============================================================
// 第 1 课 · 知识菜单
// 把所有「知识点」列成一页,点哪一个就跳到哪个页面,
// 方便你在模拟器上依次浏览 / 逐个复刻。
//
// 新增知识点时:在下面 _items 里加一行即可自动出现在菜单里。
// ============================================================

import 'package:flutter/material.dart';

import 'fl01_layout/layout01_single.dart';
import 'fl01_layout/layout02_size.dart';
import 'fl01_layout/layout03_row_column.dart';
import 'fl01_layout/layout04_elastic.dart';
import 'fl01_layout/layout05_axis.dart';
import 'fl01_layout/layout06_stack.dart';
import 'fl01_layout/layout07_wrap.dart';
import 'fl01_layout/layout08_grid.dart';
import 'fl01_layout/layout09_scroll.dart';
import 'fl01_layout/layout10_style.dart';
import 'fl01_layout/layout11_constraints.dart';
import 'fl01_layout/layout12_flex.dart';
import 'fl01_layout/layout13_overflow.dart';
import 'fl01_layout/layout14_layout_builder.dart';
import 'fl01_layout/layout15_transform.dart';
import 'fl01_layout/layout16_safe_area_media_query.dart';
import 'fl01_layout/layout17_unconstrained_intrinsic.dart';
import 'fl01_layout/layout18_clip.dart';
import 'fl01_layout/layout19_table_page_view.dart';
import 'fl01_layout/layout20_carousel.dart';
import 'fl01_layout/layout21_sliver.dart';
import 'fl01_layout/layout22_responsive.dart';
import 'fl01_layout/layout23_custom_layout.dart';
import 'fl02_media/image_page.dart';
import 'fl02_media/font_page.dart';
import 'fl02_media/icon_page.dart';
import 'fl02_media/custom_icon_page.dart';
import 'fl03_animation/animation01_implicit.dart';
import 'fl03_animation/animation02_controller.dart';
import 'fl03_animation/animation03_curve.dart';
import 'fl03_animation/animation04_tween.dart';
import 'fl03_animation/animation05_builder.dart';
import 'fl03_animation/animation06_hero.dart';
import 'fl03_animation/animation07_spring.dart';
import 'fl04_state/state01_setstate.dart';
import 'fl04_state/state02_lifting.dart';
import 'fl04_state/state03_value_notifier.dart';
import 'fl04_state/state04_inherited.dart';
import 'fl04_state/state05_compare.dart';

class KnowledgeMenu extends StatelessWidget {
  const KnowledgeMenu({super.key});

  static const _items = <_MenuItem>[
    _MenuItem(
      '布局·①单子',
      'Center / Align / Padding',
      SinglePage(),
      Icons.center_focus_strong,
    ),
    _MenuItem(
      '布局·②尺寸',
      'SizedBox / ConstrainedBox / AspectRatio…',
      SizePage(),
      Icons.straighten,
    ),
    _MenuItem(
      '布局·③横竖',
      'Column / Row',
      RowColumnPage(),
      Icons.view_column_outlined,
    ),
    _MenuItem(
      '布局·④弹性',
      'Expanded / Flexible / Spacer',
      ElasticPage(),
      Icons.view_day_outlined,
    ),
    _MenuItem(
      '布局·⑤对齐',
      '主轴分布 / crossAxisAlignment / 撑满',
      AxisPage(),
      Icons.align_horizontal_center,
    ),
    _MenuItem(
      '布局·⑥叠放',
      'Stack / Positioned',
      StackPage(),
      Icons.layers_outlined,
    ),
    _MenuItem('布局·⑦换行', 'Wrap 自动折行', WrapPage(), Icons.wrap_text),
    _MenuItem(
      '布局·⑧网格',
      'GridView / GridView.count',
      GridPage(),
      Icons.grid_view,
    ),
    _MenuItem(
      '布局·⑨滚动',
      'ListView / SingleChildScrollView',
      ScrollPage(),
      Icons.list_alt_outlined,
    ),
    _MenuItem(
      '布局·⑩样式',
      '颜色 / 圆角 / 边框 / 渐变·阴影',
      StylePage(),
      Icons.brush_outlined,
    ),
    _MenuItem(
      '布局·⑪约束',
      'BoxConstraints 约束传导(打地基)',
      ConstraintPage(),
      Icons.fitness_center,
    ),
    _MenuItem(
      '布局·⑫Flex',
      '布局之根 Row/Column 的本质',
      FlexPage(),
      Icons.view_quilt_outlined,
    ),
    _MenuItem(
      '布局·⑬溢出',
      'OverflowBox / FittedBox / Clip 处理溢出',
      OverflowPage(),
      Icons.warning_amber_outlined,
    ),
    _MenuItem(
      '布局·⑭LayoutBuilder',
      '拿到约束动态布局(响应式)',
      LayoutBuilderPage(),
      Icons.architecture,
    ),
    _MenuItem(
      '布局·⑮Transform',
      '旋转 / 缩放 / 平移(动画地基)',
      TransformPage(),
      Icons.transform,
    ),
    _MenuItem('布局·⑯安全区', 'SafeArea / MediaQuery / 键盘 Insets', SafeAreaMediaQueryPage(), Icons.phonelink_setup),
    _MenuItem('布局·⑰约束进阶', 'UnconstrainedBox / LimitedBox / Intrinsic', UnconstrainedIntrinsicPage(), Icons.open_in_full),
    _MenuItem('布局·⑱裁剪', 'ClipRect / ClipRRect / ClipOval / ClipPath', ClipPage(), Icons.crop),
    _MenuItem('布局·⑲表格', 'Table / 合并单元格 / 滚动', TablePageViewPage(), Icons.table_chart_outlined),
    _MenuItem('布局·⑳走马灯', 'PageView 轮播图 / 自动播放 / 指示器', CarouselPage(), Icons.view_carousel),
    _MenuItem('布局·㉑Sliver', 'CustomScrollView / SliverList / SliverGrid', SliverPage(), Icons.view_agenda_outlined),
    _MenuItem('布局·㉒响应式', 'LayoutBuilder / OrientationBuilder / 断点', ResponsiveLayoutPage(), Icons.devices),
    _MenuItem('布局·㉓自定义布局', 'CustomSingleChildLayout / MultiChildLayout / Flow', CustomLayoutPage(), Icons.dashboard_customize_outlined),
    _MenuItem(
      '加载图片',
      '本地资源 / 网络图 / 内存字节,三种姿势',
      ImagePage(),
      Icons.image_outlined,
    ),
    _MenuItem(
      '应用字体',
      '系统字体 / TextStyle / 自定义字体三步',
      FontPage(),
      Icons.text_fields,
    ),
    _MenuItem(
      '设置图标',
      'Icon / IconButton / 内置 Material 图标',
      IconPage(),
      Icons.emoji_emotions_outlined,
    ),
    _MenuItem(
      '自定义图标',
      'ImageIcon / IconData 字体图标 / 角标增强',
      CustomIconPage(),
      Icons.brush_outlined,
    ),

    _MenuItem(
      '动画·①隐式',
      'AnimatedContainer / Opacity / Switcher',
      ImplicitPage(),
      Icons.motion_photos_on,
    ),
    _MenuItem(
      '动画·②控制器',
      'AnimationController 显式动画三件套',
      ControllerPage(),
      Icons.settings_remote,
    ),
    _MenuItem(
      '动画·③曲线',
      'CurvedAnimation 节奏 / 回弹',
      CurvePage(),
      Icons.show_chart,
    ),
    _MenuItem(
      '动画·④Tween',
      'Tween 把进度映射到尺寸/颜色/位移',
      TweenPage(),
      Icons.monetization_on_outlined,
    ),
    _MenuItem(
      '动画·⑤Builder',
      'AnimatedBuilder 只重建会动的部分',
      BuilderPage(),
      Icons.motion_photos_on_outlined,
    ),
    _MenuItem('动画·⑥Hero', '页面切换元素飞过去', HeroPage(), Icons.flight_takeoff),
    _MenuItem('动画·⑦弹簧', 'SpringSimulation 回弹物理感', SpringPage(), Icons.blur_on),

    _MenuItem(
      '状态·①setState',
      '单个控件改自己(setState)',
      SetStatePage(),
      Icons.touch_app,
    ),
    _MenuItem('状态·②提升', '父持状态 + 回调下发(共享)', LiftingPage(), Icons.alt_route),
    _MenuItem(
      '状态·③ValueNotifier',
      '局部监听,值变只重画那一块',
      ValueNotifierPage(),
      Icons.visibility,
    ),
    _MenuItem(
      '状态·④InheritedWidget',
      '祖先给任意后代(全局共享)',
      InheritedPage(),
      Icons.hub_outlined,
    ),
    _MenuItem(
      '状态·⑤选型',
      '四种方案对照 + 什么时候用哪个',
      ComparePage(),
      Icons.fact_check_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
      itemCount: _items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final item = _items[index];
        return Card(
          clipBehavior: Clip.antiAlias,
          child: ListTile(
            leading: Icon(item.icon, color: Colors.teal),
            title: Text(
              item.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(item.subtitle, style: const TextStyle(fontSize: 12)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => item.page),
            ),
          ),
        );
      },
    );
  }
}

class _MenuItem {
  const _MenuItem(this.title, this.subtitle, this.page, this.icon);

  final String title;
  final String subtitle;
  final Widget page;
  final IconData icon;
}
