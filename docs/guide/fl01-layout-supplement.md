# fl01_layout 布局进阶章节说明

本文档与 `lib/learn/fl01_layout/layout16_*.dart` 至 `layout22_*.dart` 配套。每章可从应用知识菜单打开，建议边操作边对照本页的概念和注意事项。

## 当前已经覆盖的内容

现有章节已经覆盖 Flutter 布局的主干：

- 单子布局：`Center`、`Align`、`Padding`
- 尺寸与比例：`SizedBox`、`ConstrainedBox`、`AspectRatio`、`FractionallySizedBox`、`FittedBox`
- 线性布局：`Row`、`Column`、`Flex`
- 弹性空间：`Expanded`、`Flexible`、`Spacer`
- 主轴和交叉轴：`mainAxisAlignment`、`crossAxisAlignment`、`mainAxisSize`
- 叠放和定位：`Stack`、`Positioned`
- 自动换行和网格：`Wrap`、`GridView`
- 滚动基础：`ListView`、`SingleChildScrollView`
- 约束系统：`BoxConstraints`、父子布局约束
- 溢出与变换：`OverflowBox`、`Transform`
- 根据约束响应式布局：`LayoutBuilder`

## 第 16 章：系统安全区和屏幕信息

代码：`layout16_safe_area_media_query.dart`

知识点：

- `SafeArea` 如何避开刘海、状态栏和底部手势区域
- `MediaQuery.of(context).size` 获取屏幕尺寸
- `MediaQuery.padding`、`viewInsets`、`devicePixelRatio`
- 键盘弹出时 `viewInsets.bottom` 的变化
- 不要把状态栏高度写死

示例：页面顶部展示安全区内容，屏幕信息显示当前 Insets，聚焦输入框观察键盘弹出时的底部 Insets。`Scaffold` 通常已经处理 AppBar 区域；全屏内容、底部操作区再按需使用 `SafeArea`。

## 第 17 章：解除和补充约束

代码：`layout17_unconstrained_intrinsic.dart`

知识点：

- `UnconstrainedBox`：解除父组件某个方向的约束
- `LimitedBox`：父级给出无限约束时提供最大尺寸
- `IntrinsicWidth`、`IntrinsicHeight`：按照子组件的实际尺寸布局
- 为什么 Intrinsic 布局可能触发多次测量并影响性能
- `UnconstrainedBox`、`OverflowBox`、`FittedBox` 的区别

区别速记：`UnconstrainedBox` 让子组件在放松后的约束下重新布局；`OverflowBox` 指定允许子组件使用的约束范围；`FittedBox` 先按子组件尺寸布局，再缩放绘制以适应空间。示例还演示了水平列表中 `LimitedBox` 对无限主轴宽度的限制。

Intrinsic 布局会为了查询子树的理想尺寸增加测量工作。优先考虑明确尺寸、`Expanded`、`Flexible` 和 `LayoutBuilder`；只在规模小、需求明确的布局中使用 `IntrinsicWidth/Height`。

## 第 18 章：裁剪和内容边界

代码：`layout18_clip.dart`

知识点：

- `ClipRect`：矩形裁剪
- `ClipRRect`：圆角矩形裁剪
- `ClipOval`：椭圆或圆形裁剪
- `ClipPath`：自定义路径裁剪
- `clipBehavior` 与性能的关系
- 裁剪和 `Container` 的 `borderRadius` 不是一回事

示例：矩形裁剪、圆角矩形、椭圆/圆形和自定义五边形路径。`BoxDecoration.borderRadius` 负责画圆角背景或边框；如果 child 绘制到圆角之外仍要被裁掉，需要 `ClipRRect`。裁剪需要额外绘制工作，避免无必要地层层套用。

## 第 19 章：表格布局

代码：`layout19_table_page_view.dart`

知识点：

- `Table`、`TableRow`、`TableCell`
- `FlexColumnWidth`、`FixedColumnWidth`、`IntrinsicColumnWidth`
- 单元格合并的模拟方式与限制（Table 不支持 colspan/rowspan）
- `SingleChildScrollView` 横向 / 纵向滚动包裹，以及滚动条 `Scrollbar` 的显示
- `FlexColumnWidth` 在无界宽度约束下不可用

示例：用固定首列和弹性列展示课程表，演示横向合并（占位格 + 溢出绘制）、纵向合并（合并列拆出 Table）与双向滚动。Table 面向规整的行列对齐数据。

## 第 20 章：走马灯（轮播图）

代码：`layout20_carousel.dart`

知识点：

- `PageView` 逐页滑动与 `PageController`
- 自定义页面面板 + 参数化（背景色、间距、倾斜）
- 圆点指示器与点击热区扩大（`HitTestBehavior.opaque`）
- `Timer.periodic` 自动轮播、到尾页取模回绕
- `Listener` 指针事件实现"按住暂停、松手重新计时"

示例包含手动轮播（可点击指示器跳页）和自动轮播（按住暂停）两节。注意 Timer 必须在 `dispose` 中取消，自动翻页前用 `hasClients` 防护。

## 第 21 章：CustomScrollView 和 Sliver

代码：`layout21_sliver.dart`

知识点：

- `CustomScrollView` 的滚动模型
- `SliverList`、`SliverGrid`
- `SliverToBoxAdapter` 把普通 Widget 放入 Sliver
- `SliverAppBar` 的吸顶、折叠和展开
- `NestedScrollView` 的使用场景
- `shrinkWrap` 的成本以及为什么不应滥用

示例包含吸顶折叠的 `SliverAppBar`、普通说明区、横向内容、懒加载列表和网格，全部共享一个 `CustomScrollView`。大量同向滚动内容优先合并到一个 Sliver 视口；`shrinkWrap` 会增加测量成本，尤其不适合大列表。

## 第 22 章：响应式布局方案

代码：`layout22_responsive.dart`

知识点：

- 使用 `LayoutBuilder` 设计宽度断点
- 使用 `OrientationBuilder` 区分横屏和竖屏
- 手机、平板、桌面三种布局策略
- 窗口宽度变化时避免固定尺寸溢出
- `MediaQuery` 与 `LayoutBuilder` 的职责区别
- 将断点和布局策略抽成可复用方法

示例在窄、中、宽窗口分别显示单列、侧栏加内容、三栏布局，并用 `OrientationBuilder` 显示横竖屏方向。断点应该依据内容所需空间设置，而不是依赖设备品牌或型号。

`MediaQuery` 描述整个应用窗口，`LayoutBuilder` 描述当前位置实际收到的父级约束。组件嵌在侧栏或卡片时，局部可用宽度可能远小于屏幕宽度，因此通常应按局部约束布局。

## 第 23 章：自定义布局

代码：`layout23_custom_layout.dart`

知识点：

- `CustomSingleChildLayout`
- `CustomMultiChildLayout`
- `SingleChildLayoutDelegate`
- `MultiChildLayoutDelegate`
- `Flow` 的绘制与布局特点
- 什么时候应该使用自定义布局，什么时候应该继续使用常规 Widget

示例：`CustomSingleChildLayout` 将单个方块放在右下角；`CustomMultiChildLayout` 先布局头像，再按头像尺寸定位角标；`Flow` 依据绘制上下文放置有限数量的标签。Delegate 的 `shouldRelayout/shouldRepaint` 决定参数变化时是否需要重新布局或绘制。

自定义布局适合位置关系本身就是核心需求、标准组件难以表达的场景。简单排列仍优先选 `Row`、`Column`、`Stack`、`Wrap` 等可读性更好的组件。

## 必须加入的对比知识点

这些内容容易混淆，建议在对应章节中单独放一个对比区域：

| 对比 | 应说明的核心区别 |
| --- | --- |
| `Expanded` vs `Flexible` | 前者强制填满剩余空间，后者允许子组件保持较小尺寸 |
| `OverflowBox` vs `UnconstrainedBox` | 前者允许子组件超出，后者解除约束后重新布局 |
| `FittedBox` vs `AspectRatio` | 前者缩放子组件，后者约束宽高比例 |
| `Transform` vs 普通布局 | 只改变绘制效果，不改变布局尺寸 |
| `ClipRRect` vs `borderRadius` | 前者裁剪内容，后者主要绘制圆角背景或边框 |
| `ListView` vs `SingleChildScrollView` | 前者适合大量同类子项并支持懒加载，后者适合少量单一内容 |
| `ListView` vs `CustomScrollView` | 后者可以组合多个 Sliver 和复杂滚动效果 |
| `MediaQuery` vs `LayoutBuilder` | 前者读取屏幕/窗口信息，后者读取当前父组件传下来的约束 |

## 推荐学习顺序

按使用频率和概念依赖，依次学习：

1. `layout16_safe_area_media_query.dart`
2. `layout17_unconstrained_intrinsic.dart`
3. `layout18_clip.dart`
4. `layout19_table_page_view.dart`
5. `layout20_carousel.dart`
6. `layout21_sliver.dart`
7. `layout22_responsive.dart`
8. `layout23_custom_layout.dart`

前五章覆盖常见业务页面、约束和滚动场景；响应式与自定义布局属于进阶主题。

## 示例页检查点

- 每页都已通过知识菜单注册，可独立打开
- 操作控件（输入框、翻页按钮）可交互，拥有的 controller 在页面销毁时释放
- 示例文字应结合父级约束观察最终尺寸；横竖屏、键盘或窗口变化时可重复观察
- 修改示例中的约束、断点、裁剪方式或滚动方向，验证概念而不只阅读代码
