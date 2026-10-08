# Flutter 学习路线与章节规划

> 这套笔记仿照 go-learn 的思路：**由浅入深，一章一个主题**。每章正文里的结论都来自当前项目实际编译运行的结果，不背书、不眼高手低。
>
> 代码示例放在 `lib/learn/` 下，按 `flNN_主题` 命名（如第 1 章在 `lib/learn/fl01_widgets_layout/`），配套测试放在 `test/learn/`。每一章都是一个能独立跑起来看到效果的小部件或完整页面。
>
> 你不是在背 API，而是在"亲手搭"一个越来越完整的 Flutter 技能栈。

## 先建立全局认知：Flutter 完整知识体系

Flutter 官方把知识分成 **六大块**，我们逐块吃透：

```
┌─────────────────────────────────────────────────────────────┐
│  ① Dart 语言          —— 所有代码的地基（不是可选）                   │
│  ② Widget 体系        —— 一切皆 Widget，UI 的积木                     │
│  ③ 布局与渲染          —— 控件怎么摆、尺寸怎么算                        │
│  ④ 状态管理            —— 数据变化 → 界面自动更新                     │
│  ⑤ 交互与动画          —— 手势、转场、动效                           │
│  ⑥ 工程与平台          —— 网络、存储、测试、打包                       │
└─────────────────────────────────────────────────────────────┘
```

**你现在的困惑点（Row / Column / ListView / SizedBox / 边框 / 颜色）全部属于 ②③ 块**，是打地基的第一铲。下面 28 章就按这六大块展开，第 1–3 章优先完成。

## 阅读建议

1. 先读章节正文，把例子**亲手敲一遍**，在模拟器/真机看到效果再继续。别只"看懂"——Flutter 是动手的艺术。
2. 每章末有练习，先自己实现，卡住再看答案或问。
3. 报错先读错误信息：Flutter 会指出**哪个 widget、哪个值**出了问题，通常还带修复建议。溢出会显示黄黑条纹。
4. 你有热重载：改代码 → 终端按 `r` 立刻刷新，按 `R` 全量重跑。改成什么样、看什么样。
5. 想只看某一章，把 `lib/main.dart` 顶部 `home:` 指向目标示例即可。

## 章节规划

标记「规划中」的章节正文尚未落地。**路线带 ★ 的表示和你的 Birdle 项目直接挂钩**——学完立刻迁移到真实项目里，学以致用。

---

### 基础篇（第 1–8 章）：Flutter 入门、Widget 与布局

#### 第 1 章 · Widget 与基础布局 ⭐ 已完成示例
**代码**:`lib/learn/fl01_widgets_layout/`　**正文**:`docs/guide/fl01-widgets-layout.md`（规划中）
构建 Flutter UI 的第一铲土——理解"一切皆 Widget"，并掌握最常用的几个布局控件。

- **学完能做什么**：能徒手搭出一个"输入框+按钮、文字、图片"排布整齐的简单页面。
- **知识点**
  - Widget 是什么、Widget 树 / Element 树的概念
  - `StatelessWidget` vs `StatefulWidget`（能不能"动"）
  - 布局控件：`Row`（横排）、`Column`（竖排）、`Expanded`（占满剩余）、`Stack`（叠加）
  - 尺寸与留白：`SizedBox`（固定大小/当空隙）、`Padding`、`EdgeInsets`（`all`/`symmetric`/`only`）
  - 容器与装饰：`Container` + `BoxDecoration`（**background 颜色、`Border.all` 边框、`borderRadius` 圆角**）
  - 颜色写法：`Colors.xxx`、`Colors.grey.shade600`、`Color(0xFFRRGGBB)`
  - `Text` 与 `TextStyle`、`Center` / `Align`
- **示例练习**：做一个"模拟登录卡片"——居中一个输入框、一个按钮、四周留白、带圆角边框。
- **常见坑**
  - 把 `Expanded` 放在 `Row`/`Column` 直接子里才有效，否则报错。
  - "RenderFlex overflowed" 溢出报错：内容超出了可用空间，用 `Flexible` 或缩小内容解决。
  - `Colors.grey.shade600` 这类 `.shadeXXX` **不是常量**，放不进 `const` 子句中（本课示例就踩过）。

#### 第 2 章 · Dart 语言速成（够用就好）
**代码**：`lib/learn/fl02_dart_essentials/`
很多新手死磕 Dart 语法才碰 Flutter，本课只讲**写 UI 真正需要的部分**，边写边会。

- **学完能做什么**：能独立读懂 Flutter 里的 Dart 代码，并正确写出变量、函数、类。
- **知识点**
  - 变量与类型：`var` / `final` / `const` 的区别、`int`/`double`/`String`/`bool`
  - **可空性**：`String?`、`!`、`??`、`?.`（Flutter 里到处都是可空类型）
  - 函数：命名参数 `{this.x}`、可选参数 `[x]`、`=>` 简化、闭包与回调
  - 类与构造：`class`、`this.` 字段、`super.key`、工厂构造 `factory`
  - **Record 与解构**：`(a, b)`、`typedef`（Birdle 的 `typedef Letter = ({String char, HitType type})` 就是）
  - 集合：`List` / `Map` / `Set`、`map` / `where` / `forEach`
  - `async` / `await` / `Future`（后面网络课的基础）
- **示例练习**：写一个 `Student` 类 + 一个把列表过滤排序的函数。
- **常见坑**：在主线程上直接用 `await` 前分清它是不是 `async` 函数；`final` 能改对象内容、不能重新赋值。

#### 第 3 章 · StatefulWidget 与 setState ⭐
**代码**：`lib/learn/fl03_stateful_setstate/`
让页面"活"起来——状态一变，界面自动重画。

- **学完能做什么**：做一个能记录点击次数、实时更新数字的计数器页面。
- **知识点**
  - 为什么需要 `State`、`createState`
  - `setState(() {})` 触发重建、`build` 重跑但不会重建整个 App
  - 生命周期：`initState` / `dispose` / `didUpdateWidget`
  - `TextEditingController`（输入框的文本）、`FocusNode`（控制焦点/键盘）、底部 `dispose` 释放
  - `TextFormField` / `Form` 的简单校验
- **示例练习**：把 Birdle 的输入条改成"按下回车/按钮清空输入框"（这本来就在用它）。
- **常见坑**：`setState` 在 `dispose` 之后调用会报错；Controller 忘了 `dispose()` 会内存泄漏。

#### 第 4 章 · 基础组件：文本、输入、按钮
**代码**：`lib/learn/fl04_basic_components/`
拼装输入条、按钮、图标——你页面上 90% 的"零件"都在这。

- **知识点**：`Text` 与 `TextStyle`、`TextField` / `InputDecoration`（hint、边框、`counterText`）、`TextButton` / `FilledButton` / `IconButton` / `OutlinedButton`、`Icon`、`SnackBar`、`CircularProgressIndicator`
- **示例练习**：做一个带图标的搜索框 + 一个按下会弹提示的按钮。
- **常见坑**：`InputDecoration` 设边框要同时配好 `border` 和 `focusedBorder`，否则聚焦样式突兀。

#### 第 5 章 · 布局深入：弹性、约束与渲染原理
**代码**：`lib/learn/fl05_layout_flex/`
从"会摆"升级到"懂为什么这么摆"。**第 ③ 块的核心。**

- **知识点**
  - 核心原理：**Constraints（约束）向下传导 → Size（尺寸）向上汇报**。所有布局咽气的根。
  - `Flexible` vs `Expanded`：不撑满时不报错的差别
  - `Spacer`、`Align`、`ConstrainedBox`、`AspectRatio`
  - 主/交叉轴：`mainAxisAlignment` / `crossAxisAlignment` / `MainAxisSize`
  - 溢出到底怎么发生、`overflow` 属性
- **示例练习**：把 Birdle 的 5×N 网格格子用 `AspectRatio` 做成屏幕自适应。
- **常见坑**：`Row` 里塞了一长串文本会溢出——用 `Expanded` 包 `Text` 并给 `maxLines`。

#### 第 6 章 · 列表与滚动
**代码**：`lib/learn/fl06_list_scroll/`
一屏装不下的内容怎么优雅展示。

- **知识点**：`ListView`（`children` / `.builder` / `.separated`）、懒加载原理、`GridView` + `SliverGridDelegate`、`CustomScrollView` 与 `Sliver`、滚动监听、`ScrollController`
- **示例练习**：做一个"猜过的词"历史滚动列表。
- **常见坑**：用 `ListView(children:[...])` 塞几千条会卡——**大数据必须用 `.builder` 懒加载**。

#### 第 7 章 · 主题、颜色与排版
**代码**：`lib/learn/fl07_theme_colors/`
让整体视觉统一、有质感，而不是东一榔头西一棒。

- **知识点**：`ThemeData` / `ColorScheme`、Material 3、`Color` 系列写法、深色模式 `darkTheme`、字体 `Typography`、把常用配色抽成常量
- **示例练习**：给 Birdle 的 Tile 配色统一成一套 `ColorScheme`（绿=命中、黄=部分、灰=错）。
- **常见坑**：硬编码颜色散落各处 → 后来改主题崩。**颜色先行抽到常量/主题**。

#### 第 8 章 · Widget 组合与抽取
**代码**：`lib/learn/fl08_widget_composition/`
Flutter"组合优于继承"——把重复 UI 抽成独立小部件。

- **知识点**：把小部件抽成独立 class、参数化 + 回调通信（Birdle 的 `Tile` 和 `GuessInput` 就是现成例子）、`const` 构造优化、布局组合套路
- **常见坑**：一个 1000 行的巨型 `build` 是坏味道，学会把相似 UI 收敛成一个参数化组件。

---

### 状态与交互篇（第 9–16 章）：让页面真正"动"起来 ⭐ 你重点关心
这部分是"状态管理"的正片——从最朴素的 `setState` 一直走到主流库。

#### 第 9 章 · 布局常见坑与调试
**代码**：`lib/learn/fl09_layout_debugging/`
先学会"救火"，再学"防火"。

- **知识点**：`RenderFlex overflow`、`Expanded` 用错、约束传导问题、`debugPrint`、读错误堆栈、黄黑条纹含义、`Flutter inspector`
- **常见坑**：见知识点，每一条都亲自触发一次再修一次。

#### 第 10 章 · 状态管理入门：层层提升 ⭐
**代码**：`lib/learn/fl10_lift_state_up/`
理解"状态到底该放哪"——这比学任何库都重要。

- **知识点**：什么是"状态提升"、为什么父组件持有数据、子组件通过**回调**通知父级、`onChanged`/`onPressed` 这类回调的本质、`ValueNotifier` + `ValueListenableBuilder`
- **示例练习**：Birdle 里 `Game` 放在哪、`GuessInput` 怎么把词告诉父级——拆开讲透。
- **常见坑**：把状态写在错误层级，导致兄弟组件不同步——先想"谁需要这份数据"再定位置。

#### 第 11 章 · Provider：最实用的现代状态管理 ⭐
**代码**：`lib/learn/fl11_provider/`
`setState` 传参爆炸时的第一条出路。

- **知识点**：为什么需要全局状态、`ChangeNotifier` + `ChangeNotifierProvider`、`context.watch`（监听变化）/ `context.read`（不监听）、`Consumer`、把 Birdle 猜词状态接入 Provider
- **示例练习**：让"剩余次数 / 输入过程"在多个页面共享。
- **常见坑**：在 `build` 外用 `context.watch`、或 `build` 里做耗时操作。`read` 和 `watch` 用错导致不刷新或刷新过多。

#### 第 12 章 · Riverpod 与 BLoC：进阶选型 ⭐
**代码**：`lib/learn/fl12_state_mgmt_advanced/`
面试与大型项目最常出现，了解 pattern 会让你"看得懂别人写的 Flutter"。

- **知识点**：Riverpod 的 `Provider` / `NotifierProvider`、编译期安全；BLoC 的事件流（`flutter_bloc`）；何时该升级到库、如何权衡；用其中一种重构 Birdle 的钱包逻辑
- **常见坑**：为了用状态管理而用——**小而简用 `setState`+Provider，很乱再上 Riverpod/BLoC**。

#### 第 13 章 · 动画
**代码**：`lib/learn/fl13_animations/`
让你的界面"活"起来。

- **知识点**：隐式动画 `AnimatedContainer` / `AnimatedOpacity` / `TweenAnimationBuilder`、显式 `AnimationController` + `Tween` + `Curve`、`Hero` 转场、给 Birdle 的 Tile 加"翻开"缩放动画
- **常见坑**：动画丢 `vsync`、或忘 `dispose` 掉 controller。

#### 第 14 章 · 手势与交互
**代码**：`lib/learn/fl14_gestures/`
点击、拖动、滑动反馈。

- **知识点**：`GestureDetector`（tap / onTap / drag）、`InkWell` 水波纹、键盘交互、给猜词的字母格加点击反馈
- **常见坑**：`GestureDetector` 里嵌套可滚动导致手势冲突——按需用 `ListView` 手势端口的技巧。

#### 第 15 章 · 导航与页面跳转 ⭐
**代码**：`lib/learn/fl15_navigation/`
几个页面之间的进出。

- **知识点**：`Navigator.push` / `pop`、`MaterialPageRoute`、命名路由、`go_router`（声明式、浏览器般体验）、给 Birdle 加开始页和结算页
- **常见坑**：未注意 `context` 在异步之后不可用（`use_build_context_synchronously`）。

#### 第 16 章 · 异步、网络与 JSON
**代码**：`lib/learn/fl16_async_network/`
连上真实世界的数据。

- **知识点**：`Future` / `FutureBuilder`、`http` 发 GET/POST、`jsonDecode` / `jsonEncode`、状态三态（加载中/成功/失败）UI、超时处理、给 Birdle 接一个真实猜词接口
- **常见坑**：UI 不刷新因为没 `setState`；解析 JSON 少了字段直接崩；**记得处理错误态**展示友好提示。

---

### 工程与进阶篇（第 17–24 章)：把它当真正的项目做

#### 第 17 章 · 本地存储
安装 `shared_preferences`，保存胜负数、设置项到本地，下次启动还在。给 Birdle 加战绩与设置页。
**坑**：存储需异步加载，别在首次 `build` 里同步读。

#### 第 18 章 · 测试
`test` 单元测试（Birdle 的 `Game` 猜词逻辑非常适合作表驱动测试）、`flutter widget test` 验证 UI、`integration_test`。让代码"敢改不怕坏"。
**坑**：测试里用 `find.text` 找不到，多半是文字异步渲染或 `Text` 被拆分。

#### 第 19 章 · 调试与性能
`dart analyze` / `flutter analyze` 尽早跑、DevTools 的 Inspector / 性能面板 / Memory、避免在 `build` 里做重活、`const` 大量降低重建成本、`ListView.builder` 懒加载。
**坑**：`print` 散落生产代码，用 `debugPrint` 或日志库。

#### 第 20 章 · 自适应与响应式
`MediaQuery`（屏幕信息）、`LayoutBuilder`（拿到约束再决定布局）、`SafeArea`（避开刘海/底部栏）、横屏适配、`OrientationBuilder`。多设备体验一致。

#### 第 21 章 · 设计系统与主题深入
自定义完整 `ThemeData`、`ColorScheme`、`textTheme`、`elevation`。做出一套有品牌感的暗色/亮色主题并在 App 里可切换。

#### 第 22 章 · 国际化与无障碍
`intl` 与 `flutter_localizations`、文案抽到 `arb`、`MediaQuery.textScaler` 支持字体放大、颜色对比度、语义化标签。让盲人和长期尝鲜者都能用。

#### 第 23 章 · 原生集成
`MethodChannel` 调用 Android / iOS 原生代码、理解插件架构（`plugin` 模板）、调用相机/定位等原生能力、`platform` 分支判断。

#### 第 24 章 · 打包发布
`flutter build apk / appbundle`、签名与 keystore、`version` / `versionCode`、Android 各打包规范、上架 Google Play / 应用宝 / 华为的流程概览、崩溃日志收集（Crashlytics）。

---

### 综合实战篇（第 25–28 章)：在真实项目里融会贯通

#### 第 25 章 · Birdle 完整重构 ⭐
按真实工程分层：`GameService`（纯 Dart 逻辑）与 UI 彻底解耦；接入选定状态管理；动画、导航、存储、深色模式全部整合；补单元 + widget 测试。**把你的作品真正打磨成可上架的样子。**

#### 第 26 章 · 完整 App 实战
从零做一个全新小项目（通讯录 / 记账本 / 看图猜词），一套流程走完整：建模 → 状态 → 列表 → 详情 → 存储 → 测试。

#### 第 27 章 · 综合能力集成
网络 + 状态 + 动画 + 导航的组合应用，处理真实数据流、分页、错误重试、空态 / 加载态 / 错误态三件套。

#### 第 28 章 · 性能优化与上线
剖析实战项目的卡顿、用 DevTools 定位、优化后重新压测、打包、走发布流程。**至此，你已经能独立从需求到上架走通一个 Flutter App。**

---

## 学习里程碑（自查用）

| 阶段 | 达到什么程度 | 对应章节 |
|---|---|---|
| 入门 | 会摆布局、写简单交互、读得懂 Dart | 第 1–8 章 |
| 进阶 | 掌握一种状态管理、接网络、做动画 | 第 9–16 章 |
| 工程 | 会测试、调试、主题、打包 | 第 17–24 章 |
| 精通 | 能独立分层开发并上架完整 App | 第 25–28 章 |

## 本地预览文档站

文档当前以 Markdown 阅读。后续如需像 go-learn 那样的 VitePress 站点，再补 `.vitepress` 配置即可。