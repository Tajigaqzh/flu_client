import 'package:flutter/material.dart';
import '../common.dart';

class TablePageViewPage extends StatefulWidget {
  const TablePageViewPage({super.key});

  @override
  State<TablePageViewPage> createState() => _TablePageViewPageState();
}

class _TablePageViewPageState extends State<TablePageViewPage> {
  final _controller = PageController();
  final _hController = ScrollController(); // 横向滚动表格的滚动条用
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    _hController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: 'Table / PageView',
      children: [
        KnowledgeCard(
          'Table / PageView',
          'Table 按行列对齐单元格；PageView 把同一视口切成可滑动页面。',
        ),
        SectionTitle('① Table：行列对齐'),
        Table(
          border: TableBorder.all(color: Colors.blueGrey.shade200),
          columnWidths: const {
            0: FixedColumnWidth(72),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            _row(['时间', '课程', '教室'], header: true),
            _row(['周一', 'Flutter 布局', 'A-201']),
            _row(['周二', 'Dart 基础', 'B-103']),
            _row(['周三', '动画实践', 'A-105']),
          ],
        ),

        SizedBox(height: 10),

        Table(
          // border: TableBorder.all(color: Colors.red.shade400),
          columnWidths: const {
            0: FixedColumnWidth(72),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2),
          },

          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.lightBlue.shade400),
              children: [Text('姓名'), Text('年龄'), Text('性别')],
            ),

            TableRow(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: BoxBorder.all(color: Colors.red),
                  ),
                  child: Text('姓名', style: TextStyle()),
                ),
                // 占位格：Table 要求每行的格数必须等于列数，
                // 想要“合并”的视觉效果只能放空格，不能删掉格子。
                Container(),
                Text('性别'),
              ],
            ),
          ],
        ),

        LearnNote(
          'FixedColumnWidth 固定列宽，FlexColumnWidth 按剩余空间分配；IntrinsicColumnWidth 会测量内容，数据量大时需谨慎。',
        ),

        SectionTitle('① 补充：横向合并单元格'),
        Table(
          columnWidths: const {
            0: FixedColumnWidth(72),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            // 合并行：TableRow 统一 decoration 上色，文本放第一格并让它越过格边界绘制，
            // 其余格只放空 Container 凑满列数（Table 要求每行列数一致）。
            TableRow(
              decoration: BoxDecoration(color: Colors.lightBlue.shade400),
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    '2024 春季课表（占满整行）',
                    softWrap: false,
                    overflow: TextOverflow.visible,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(),
                Container(),
              ],
            ),
            _row(['时间', '课程', '教室'], header: true),
            _row(['周一', 'Flutter 布局', 'A-201']),
          ],
        ),
        const LearnNote(
          'Table 不支持 colspan/rowspan（SDK 源码里就没有这个概念）。横向合并只能模拟：'
          '整行用统一 decoration 上色，文本放第一格并设 softWrap: false + overflow: TextOverflow.visible，'
          '让它画出自己的格子；占位格不能再画边框，否则会暴露格子边界。'
          '需要真正的合并单元格得用第三方表格库。',
        ),

        SectionTitle('① 补充：纵向合并单元格'),
        const LearnNote(
          'rowspan 同样不支持。纯 Table 占位格只能模拟，且“上午”物理上只是第一行的格子，无法真正跨行居中。'
          '要真居中就把合并列整个拆到 Table 外面：合并块内部本来没有线，行高对不上也无妨，'
          '右边 Table 只管剩下的列。外框画在 Container 上，Table 用 TableBorder.symmetric 只画内部线，'
          '每处线条只有一条，不会像逐格画 Border.all 那样重叠变粗。',
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey.shade200),
          ),
          // IntrinsicHeight：页面是滚动列表，传下来的高度无限，
          // Row 的 crossAxisAlignment: stretch 需要有界高度才能拉伸子项，
          // 先让 Row 取“表格内容自身的高度”变成有界，stretch 才能工作。
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 左块：真正的“合并单元格”，跨全部数据行，内容真垂直居中
                Container(
                  width: 72,
                  color: Colors.orange.shade100,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  child: const Text('上午'),
                ),
                // 左右分界的竖线
                Container(width: 1, color: Colors.blueGrey.shade200),
                Expanded(
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                    },
                    border: TableBorder.symmetric(
                      inside: BorderSide(color: Colors.blueGrey.shade200),
                    ),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(children: [_cell('课程'), _cell('教室')]),
                      TableRow(children: [_cell('Flutter 布局'), _cell('A-201')]),
                      TableRow(children: [_cell('Dart 基础'), _cell('B-103')]),
                      TableRow(children: [_cell('动画实践'), _cell('A-105')]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        SectionTitle('① 补充：横向滚动'),
        const LearnNote(
          '横向滚动：外层套 SingleChildScrollView(scrollDirection: Axis.horizontal)。'
          '此时 Table 的宽度约束是无限的，FlexColumnWidth 没法分配剩余空间会直接报错，'
          '所以列宽必须全部用 FixedColumnWidth（或 IntrinsicColumnWidth）。'
          'SingleChildScrollView 自己不画滚动条，Android 上也不会自动加，'
          '要显示就套 Scrollbar 并共用一个 ScrollController（thumbVisibility: true 常驻显示）。',
        ),
        // Scrollbar 的滑块贴着可视区底边、画在内容上层，会盖住表格最后一行；
        // 在滚动区下面留一条空隙，滑块就落到表格外面了。
        // 另外 iOS 上 Scrollbar 实际是 CupertinoScrollbar，它会把 MediaQuery
        // 的底部安全区间距（Home 指示条约 34px）当成滑块内边距，
        // 把滑块顶进表格里，所以这里先把 bottom 安全区去掉。
        MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          child: Scrollbar(
            controller: _hController,
            thumbVisibility: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SingleChildScrollView(
                  controller: _hController,
                  scrollDirection: Axis.horizontal,
                  child: Table(
                    border: TableBorder.all(color: Colors.blueGrey.shade200),
                    columnWidths: const {
                      0: FixedColumnWidth(120),
                      1: FixedColumnWidth(160),
                      2: FixedColumnWidth(160),
                      3: FixedColumnWidth(200),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      _row(['日期', '课程', '教室', '任课老师'], header: true),
                      _row(['周一', 'Flutter 布局', 'A-201', '王老师']),
                      _row(['周二', 'Dart 基础', 'B-103', '李老师']),
                    ],
                  ),
                ),
                // 给滚动条留的位置
                const SizedBox(height: 2),
              ],
            ),
          ),
        ),

        SectionTitle('① 补充：纵向滚动'),
        const LearnNote(
          '纵向滚动：外层套普通 SingleChildScrollView（默认垂直），'
          '并用 SizedBox 限制可视高度；宽度仍有界，FlexColumnWidth 可以正常用。',
        ),
        SizedBox(
          height: 120,
          child: SingleChildScrollView(
            child: Table(
              border: TableBorder.all(color: Colors.blueGrey.shade200),
              columnWidths: const {
                0: FixedColumnWidth(72),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(1),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                _row(['时间', '课程', '教室'], header: true),
                _row(['周一', 'Flutter 布局', 'A-201']),
                _row(['周二', 'Dart 基础', 'B-103']),
                _row(['周三', '动画实践', 'A-105']),
                _row(['周四', '状态管理', 'C-301']),
                _row(['周五', '路由导航', 'C-302']),
              ],
            ),
          ),
        ),

        SectionTitle('② PageView：分页滑动'),
        SizedBox(
          height: 150,
          child: PageView(
            controller: _controller,
            onPageChanged: (value) => setState(() => _page = value),
            children: const [
              _PagePanel(
                color: Colors.teal,
                title: '第一页',
                subtitle: 'PageController 可控制初始页和跳转',
              ),
              _PagePanel(
                color: Colors.indigo,
                title: '第二页',
                subtitle: '滑动方向可设为 Axis.vertical',
              ),
              _PagePanel(
                color: Colors.deepOrange,
                title: '第三页',
                subtitle: 'PageView 适合分页内容，不是长列表替代品',
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => GestureDetector(
              // 点击指示器跳到对应页；animateToPage 带滑动动画，jumpToPage 直接切
              onTap: () => _controller.animateToPage(
                index,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
              ),
              // 8px 的圆点太小点不中，用透明的 32px 容器扩大点击热区
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                child: Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _page == index ? Colors.teal : Colors.black26,
                  ),
                ),
              ),
            ),
          ),
        ),
        const KnowledgeCard(
          '对比',
          'ListView 按需连续滚动许多项目；PageView 一次聚焦一个页面，通常用于引导页、图库或分页内容。',
        ),
      ],
    );
  }

  TableRow _row(List<String> values, {bool header = false}) => TableRow(
    decoration: BoxDecoration(color: header ? Colors.teal.shade50 : null),
    children: values
        .map(
          (value) => Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              value,
              style: TextStyle(
                fontWeight: header ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        )
        .toList(),
  );

  // 纵向合并示例中的普通格：只负责内边距和内容居中，
  // 线条统一交给 TableBorder.symmetric 画，逐格画 Border.all 会重叠变粗。
  Widget _cell(String text) => Container(
    padding: const EdgeInsets.all(8),
    alignment: Alignment.center,
    child: Text(text),
  );
}

class _PagePanel extends StatelessWidget {
  const _PagePanel({
    required this.color,
    required this.title,
    required this.subtitle,
  });

  final Color color;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Container(
    color: color,
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}
