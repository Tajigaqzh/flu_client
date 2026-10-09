// ============================================================
// 知识点 2:尺寸与约束
//   SizedBox / ConstrainedBox / AspectRatio /
//   FractionallySizedBox / FittedBox
//   都用来“限制孩子的尺寸”,只是限制方式不同。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class SizePage extends StatelessWidget {
  const SizePage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '尺寸与约束',
      children: [
        KnowledgeCard(
          '尺寸与约束',
          '固定尺寸用 SizedBox;加“上下限”用 ConstrainedBox;锁定宽高比用 AspectRatio;按父级比例用 FractionallySizedBox;塞不下了自动缩放用 FittedBox。',
        ),

        SectionTitle('① SizedBox:固定精确宽高'),
        LearnNote('child 固定成 (80×80);不给 child 时就是一条“空隙”(右边那个 16 宽的缝)。'),
        Row(
          children: [
            const SizedBox(width: 80, height: 80, child: Box('80')),
            // const SizedBox(width: 16),
            // Expanded(
            //   child: Text('16 是 SizedBox(width:16) 空隙',
            //       style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
            // ),
          ],
        ),

        SectionTitle('② ConstrainedBox:只给“上下限”'),
        LearnNote('不限精确尺寸,只设最大/最小。这个想 100 的方块被 maxWidth/maxHeight 压到 60。'),
        Row(
          children: [
            const Box('自由', color: Colors.purple),
            const SizedBox(width: 16),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 60, maxHeight: 60),
              child: const Box('受限', color: Colors.deepPurple, size: 100),
            ),
          ],
        ),

        Row(
          children: [
            const Box('墨迹阿婆'),
            const SizedBox(width: 20),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 100, maxHeight: 100),
              child: const Box('测试', size: 100),
            ),
          ],
        ),

        SectionTitle('③ AspectRatio:锁定宽高比'),
        LearnNote('1:1 是正方形,2:1 是宽两倍的长方形。'),
        SizedBox(
          height: 90,
          child: Row(
            children: [
              Expanded(child: _ratio(1)),
              const SizedBox(width: 12),
              Expanded(child: _ratio(2)),
            ],
          ),
        ),

        SectionTitle('④ FractionallySizedBox:按父级比例'),
        LearnNote('widthFactor 0.5 = 占父级一半宽;heightFactor 0.5 = 一半高。'),
        Container(
          height: 90,
          width: double.infinity,
          color: Colors.grey.shade100,
          child: const FractionallySizedBox(
            widthFactor: 0.5,
            heightFactor: 0.5,
            alignment: Alignment.center,
            child: Box('50%', color: Colors.teal, size: 20),
          ),
        ),

        SectionTitle('⑤ FittedBox:塞不下自动缩放'),
        LearnNote('子内容超出父框时,自动缩小到“放得下”。'),
        Container(
          height: 60,
          width: double.infinity,
          color: Colors.grey.shade100,
          child: const FittedBox(
            fit: BoxFit.contain,
            child: Text('这是一段超长文字,会被自动缩小到放得下'),
          ),
        ),
      ],
    );
  }

  Widget _ratio(double ratio) {
    return Container(
      color: Colors.cyan.shade200,
      alignment: Alignment.center,
      child: AspectRatio(
        aspectRatio: ratio,
        child: Container(
          color: Colors.cyan.shade600,
          alignment: Alignment.center,
          child: Text('$ratio:1', style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
