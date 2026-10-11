// ============================================================
// 知识点 12:Flex —— 布局之根(必看)
//   Row = 横着摆的 Flex,Column = 竖着摆的 Flex。
//   看懂 Flex,前面 Expanded / Flexible / Spacer / 对齐就全通。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class FlexPage extends StatelessWidget {
  const FlexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: 'Flex 布局之根',
      children: [
        KnowledgeCard(
          'Flex',
          'Row 和 Column 都是 Flex 的子类。Flex(direction: …) 的 direction 决定方向:horizontal=横(≈Row)、vertical=竖(≈Column)。它负责把主轴剩余空间分给 Expanded/Flexible/Spacer。',
        ),

        SectionTitle('① Row / Column 本质就是 Flex'),
        LearnNote('看这行:Flex 当 Row 用(direction: horizontal),和 Row 一模一样。'),
        Container(
          color: Colors.grey.shade50,
          child: const Flex(
            direction: Axis.horizontal,
            children: [
              Box('A', size: 40),
              SizedBox(width: 8),
              Box('B', color: Colors.teal, size: 40),
            ],
          ),
        ),

        SizedBox(height: 10),

        LearnNote('如果想让方块超出后自动换行，应该用 Wrap 而不是 Flex/Row'),
        Container(
          color: Colors.white54,
          child: Wrap(
            spacing: 15, // 横向间距
            runSpacing: 10, // 换行后的行间距
            children: [
              Container(width: 40, height: 40, color: Colors.red),
              Container(width: 40, height: 40, color: Colors.red),
              Container(width: 40, height: 40, color: Colors.red),
              Container(width: 40, height: 40, color: Colors.red),
              Container(width: 40, height: 40, color: Colors.red),
              Container(width: 40, height: 40, color: Colors.red),
              Container(width: 40, height: 40, color: Colors.red),
              Container(width: 40, height: 40, color: Colors.red),
            ],
          ),
        ),

        SizedBox(height: 10),

        LearnNote('对比：Flex 超出屏幕时会溢出（会出现黄黑警告条纹）'),
        Container(
          color: Colors.white54,
          child: Flex(
            direction: Axis.horizontal,

            children: [
              Container(width: 40, height: 40, color: Colors.red),
              SizedBox(width: 15),
              Container(width: 40, height: 40, color: Colors.red),
              SizedBox(width: 15),
              Container(width: 40, height: 40, color: Colors.red),
              SizedBox(width: 15),
              Container(width: 40, height: 40, color: Colors.red),
              SizedBox(width: 15),
              Container(width: 40, height: 40, color: Colors.red),
              SizedBox(width: 15),
              Container(width: 40, height: 40, color: Colors.red),
            ],
          ),
        ),

        SectionTitle('② Flex + Expanded:弹性比例分配'),
        LearnNote('同一个 Flex 里,Expanded 按 flex 比例分剩余空间。下面的 2:1。'),
        Container(
          color: Colors.grey.shade50,
          child: const Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(flex: 2, child: Box('2份', color: Colors.blue, size: 40)),
              SizedBox(width: 6),
              Expanded(
                flex: 1,
                child: Box('1份', color: Colors.indigo, size: 40),
              ),
            ],
          ),
        ),

        SectionTitle('③ Flex + Spacer:留空档'),
        LearnNote('Spacer 就是“不吃内容、专门占位”的 Expanded。'),
        const Row(
          children: [
            Box('A'),
            Spacer(flex: 2),
            Box('B'),
            Spacer(flex: 1),
            Box('C'),
          ],
        ),

        SectionTitle('④ mainAxisAlignment:主轴对齐方式'),
        LearnNote(
          '控制子元素在主轴上如何分布。常用的有 center / spaceBetween / spaceAround / spaceEvenly。',
        ),

        const SizedBox(height: 8),
        Container(
          color: Colors.grey.shade50,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const Text('center - 居中', style: TextStyle(fontSize: 11)),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Box('A', size: 30, color: Colors.blue),
                  SizedBox(width: 4),
                  Box('B', size: 30, color: Colors.blue),
                  SizedBox(width: 4),
                  Box('C', size: 30, color: Colors.blue),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),
        Container(
          color: Colors.grey.shade50,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const Text('spaceBetween - 两端对齐,中间均分', style: TextStyle(fontSize: 11)),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Box('A', size: 30, color: Colors.teal),
                  Box('B', size: 30, color: Colors.teal),
                  Box('C', size: 30, color: Colors.teal),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),
        Container(
          color: Colors.grey.shade50,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const Text('spaceAround - 每个元素两侧留空', style: TextStyle(fontSize: 11)),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Box('A', size: 30, color: Colors.orange),
                  Box('B', size: 30, color: Colors.orange),
                  Box('C', size: 30, color: Colors.orange),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),
        Container(
          color: Colors.grey.shade50,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const Text('spaceEvenly - 所有间距相等', style: TextStyle(fontSize: 11)),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Box('A', size: 30, color: Colors.purple),
                  Box('B', size: 30, color: Colors.purple),
                  Box('C', size: 30, color: Colors.purple),
                ],
              ),
            ],
          ),
        ),

        SectionTitle('⑤ crossAxisAlignment:交叉轴对齐'),
        LearnNote(
          'Row 的交叉轴是垂直,Column 的交叉轴是水平。stretch 会拉伸子元素填满交叉轴。',
        ),

        const SizedBox(height: 8),
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: Container(
                height: 100,
                color: Colors.grey.shade50,
                child: Column(
                  children: [
                    const Text('start', style: TextStyle(fontSize: 11)),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Box('A', size: 30),
                        SizedBox(width: 4),
                        Box('B', size: 50, color: Colors.teal),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                color: Colors.grey.shade50,
                child: Column(
                  children: [
                    const Text('center', style: TextStyle(fontSize: 11)),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Box('A', size: 30),
                        SizedBox(width: 4),
                        Box('B', size: 50, color: Colors.teal),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                color: Colors.grey.shade50,
                child: Column(
                  children: [
                    const Text('end', style: TextStyle(fontSize: 11)),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Box('A', size: 30),
                        SizedBox(width: 4),
                        Box('B', size: 50, color: Colors.teal),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),
        Container(
          height: 80,
          color: Colors.grey.shade50,
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('stretch - 拉伸填满交叉轴', style: TextStyle(fontSize: 11)),
              const SizedBox(height: 4),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(width: 40, color: Colors.indigo),
                    const SizedBox(width: 4),
                    Container(width: 40, color: Colors.indigo),
                  ],
                ),
              ),
            ],
          ),
        ),

        SectionTitle('⑥ mainAxisSize:主轴尺寸'),
        LearnNote(
          'max=占满父级(默认),min=只占子元素需要的空间。用 min 可以做紧凑布局。',
        ),

        const SizedBox(height: 8),
        Container(
          color: Colors.grey.shade50,
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('mainAxisSize.max - 占满(默认)', style: TextStyle(fontSize: 11)),
              const SizedBox(height: 4),
              Container(
                color: Colors.amber.shade100,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Box('A', size: 30),
                    SizedBox(width: 4),
                    Box('B', size: 30),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text('mainAxisSize.min - 紧凑', style: TextStyle(fontSize: 11)),
              const SizedBox(height: 4),
              Container(
                color: Colors.amber.shade100,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Box('A', size: 30),
                    SizedBox(width: 4),
                    Box('B', size: 30),
                  ],
                ),
              ),
            ],
          ),
        ),

        SectionTitle('⑦ Flexible vs Expanded'),
        LearnNote(
          'Flexible(loose)=可以小于分配空间,Expanded(tight)=必须占满。实际上 Expanded 就是 Flexible(fit: tight) 的简写。',
        ),

        const SizedBox(height: 8),
        Container(
          color: Colors.grey.shade50,
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Flexible(loose) - 可以收缩', style: TextStyle(fontSize: 11)),
              const SizedBox(height: 4),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      height: 40,
                      color: Colors.green,
                      child: const Center(
                        child: Text('我只占内容宽', style: TextStyle(fontSize: 10)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Box('固定', size: 40, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 12),
              const Text('Expanded(tight) - 必须占满', style: TextStyle(fontSize: 11)),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      color: Colors.blue,
                      child: const Center(
                        child: Text('我占满剩余空间', style: TextStyle(fontSize: 10, color: Colors.white)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Box('固定', size: 40, color: Colors.grey),
                ],
              ),
            ],
          ),
        ),

        SectionTitle('⑧ TextBaseline:基线对齐'),
        LearnNote('让不同大小的文字按基线对齐,少用但知道存在。'),

        const SizedBox(height: 8),
        Container(
          color: Colors.grey.shade50,
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: const [
              Text('小', style: TextStyle(fontSize: 12)),
              SizedBox(width: 8),
              Text('中等', style: TextStyle(fontSize: 20)),
              SizedBox(width: 8),
              Text('大号', style: TextStyle(fontSize: 32, color: Colors.blue)),
            ],
          ),
        ),
      ],
    );
  }
}
