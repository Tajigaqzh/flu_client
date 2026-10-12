import 'dart:async';

import 'package:flutter/material.dart';
import '../common.dart';

/// 布局·㉓ 走马灯
/// 轮播图 = PageView + 自定义面板 + 可点击指示器（+ Timer 自动翻页）。
class CarouselPage extends StatefulWidget {
  const CarouselPage({super.key});

  @override
  State<CarouselPage> createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  static const _pageCount = 3;
  static const _autoDuration = Duration(milliseconds: 350);

  final _controller = PageController();
  final _autoController = PageController();
  Timer? _timer;
  int _page = 0;
  int _autoPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      // 页面还没挂载好（或已销毁中）时控制器没有 attached 的 ScrollPosition
      if (!_autoController.hasClients) return;
      final next = (_autoPage + 1) % _pageCount; // 到尾页取模回到 0
      _autoController.animateToPage(
        next,
        duration: _autoDuration,
        curve: Curves.easeOut,
      );
    });
  }

  // 手指按住时暂停，松手（或取消）重新从 3 秒开始计
  void _pauseAutoPlay() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    // Timer 不会随页面销毁自动停止，必须自己取消，否则后台一直跑还报异常
    _timer?.cancel();
    _controller.dispose();
    _autoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '走马灯',
      children: [
        KnowledgeCard(
          '走马灯',
          '轮播图的完整套路：PageView 切页 + 自定义面板 + 圆点指示器，外面再套个 Timer 自动翻页。',
        ),

        SectionTitle('① 自定义面板 + 可点击指示器'),
        const LearnNote(
          '页面内容抽成可配置的 _PanelItem：背景色、标题、副标题间距（rowGap）、'
          '副标题倾斜程度（skewRatio，配合 Matrix4.skewX 伪斜体）。'
          '圆点只有 10px 点不中，外面套透明 20px 容器 + HitTestBehavior.opaque 扩大热区。',
        ),
        SizedBox(
          height: 150,
          child: PageView(
            controller: _controller,
            onPageChanged: (value) => setState(() => _page = value),
            children: [
              _PanelItem(
                color: Colors.red.shade700,
                title: '第一页',
                subTitle: '这是第一页',
                rowGap: 20,
              ),
              _PanelItem(
                color: Colors.amber,
                title: '第二页',
                subTitle: '这是第二页',
                skewRatio: 0.3,
              ),
              _PanelItem(
                color: Colors.blue,
                title: '第三页',
                subTitle: '这是第三页',
                skewRatio: -0.5,
              ),
            ],
          ),
        ),
        _Dots(
          count: _pageCount,
          current: _page,
          onTap: (index) => _controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.bounceInOut,
          ),
        ),

        SectionTitle('② 自动轮播：Timer.periodic 定时翻页'),
        const LearnNote(
          '自动版 = 手动版 + Timer.periodic 每 3 秒翻到下一页，到尾页取模回 0。'
          '两个注意点：Timer 不随页面销毁自动停止，dispose 里必须 cancel；'
          '翻页前用 hasClients 判断，避免页面未挂载时操作控制器。',
        ),
        // Listener 拿最原始的指针事件：按下就停表，抬起/取消就重新开始计。
        // 长按不动不会触发任何滚动回调，所以这类“按住暂停”要用 Listener 而不是滚动通知。
        Listener(
          onPointerDown: (_) => _pauseAutoPlay(),
          onPointerUp: (_) => _startAutoPlay(),
          onPointerCancel: (_) => _startAutoPlay(),
          child: SizedBox(
            height: 120,
            child: PageView(
              controller: _autoController,
              onPageChanged: (value) => setState(() => _autoPage = value),
              children: const [
                _PanelItem(color: Colors.teal, title: '促销', subTitle: '全场 8 折'),
                _PanelItem(color: Colors.indigo, title: '新品', subTitle: '秋季系列上新'),
                _PanelItem(color: Colors.deepOrange, title: '公告', subTitle: '周末延长营业'),
              ],
            ),
          ),
        ),
        _Dots(count: _pageCount, current: _autoPage, onTap: null), // 自动版只展示，不可点

        const KnowledgeCard(
          '进阶',
          '更精细的做法是用 NotificationListener 监听 ScrollStartNotification（dragDetails != null 表示用户拖动），'
          '只对真实拖动暂停、程序自动翻页不暂停；图片轮播把面板换成 Image.network + 缓存即可。',
        ),
      ],
    );
  }
}

/// 圆点指示器：onTap 为 null 时纯展示
class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.current, required this.onTap});

  final int count;
  final int current;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        return GestureDetector(
          onTap: onTap == null ? null : () => onTap!(index),
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: current == index ? Colors.teal : Colors.black26,
              ),
            ),
          ),
        );
      }),
    );
  }
}

/// 轮播面板：可配置背景色、标题、副标题间距与倾斜
class _PanelItem extends StatelessWidget {
  const _PanelItem({
    required this.color,
    required this.title,
    required this.subTitle,
    this.rowGap = 4,
    this.skewRatio = -0.25,
  });

  final Color color;
  final String title;
  final String subTitle;
  final double rowGap;
  final double skewRatio;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: rowGap),
          Transform(
            transform: Matrix4.skewX(skewRatio),
            alignment: Alignment.center,
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
