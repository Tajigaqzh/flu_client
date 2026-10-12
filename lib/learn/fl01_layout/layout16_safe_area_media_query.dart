import 'package:flutter/material.dart';
import '../common.dart';

class SafeAreaMediaQueryPage extends StatefulWidget {
  const SafeAreaMediaQueryPage({super.key});

  @override
  State<SafeAreaMediaQueryPage> createState() => _SafeAreaMediaQueryPageState();
}

class _SafeAreaMediaQueryPageState extends State<SafeAreaMediaQueryPage> {
  final _input = TextEditingController();

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {



    final media = MediaQuery.of(context);


    return KnowledgeScaffold(
      title: 'SafeArea / MediaQuery',
      children: [
        KnowledgeCard(
          'SafeArea',
          '让页面内容避开刘海、状态栏和底部系统手势区域；MediaQuery 读取当前窗口环境数据。',
        ),
        SectionTitle('① SafeArea：避开系统区域'),
        LearnNote('Scaffold 通常已经处理顶部 AppBar。SafeArea 常用于正文或全屏内容，不要再手写固定状态栏高度。'),
        Container(
          height: 110,
          color: Colors.teal.shade50,
          child: const SafeArea(
            child: Align(alignment: Alignment.topLeft, child: Box('安全区域内')),
          ),
        ),
        SectionTitle('② MediaQuery：屏幕与系统 Insets'),
        Text(
          '窗口尺寸：${media.size.width.toStringAsFixed(0)} × ${media.size.height.toStringAsFixed(0)} logical px',
        ),
        Text('设备像素比：${media.devicePixelRatio.toStringAsFixed(2)}'),
        Text('系统边距 padding：${media.padding}'),
        Text(
          '键盘遮挡 viewInsets.bottom：${media.viewInsets.bottom.toStringAsFixed(0)}',
        ),
        SectionTitle('③ 键盘弹出时观察 viewInsets'),
        LearnNote('聚焦输入框后，viewInsets.bottom 通常会变大。可用它为底部操作区留位置；不要把键盘高度写死。'),
        TextField(
          controller: _input,
          decoration: const InputDecoration(
            labelText: '点此弹出键盘',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: media.viewInsets.bottom > 0 ? 8 : 24),
        const KnowledgeCard(
          '练习',
          '把一个底部按钮放进 SafeArea，并观察键盘弹出前后 viewInsets.bottom 的变化。',
        ),
      ],
    );
  }
}
