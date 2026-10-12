import 'package:flutter/material.dart';
import '../common.dart';

class ClipPage extends StatelessWidget {
  const ClipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: 'Clip 裁剪',
      children: [
        KnowledgeCard(
          'Clip',
          'Clip widget 会真正裁掉子组件绘制到边界外的部分。圆角背景不一定会裁剪其 child。',
        ),
        SectionTitle('① ClipRect：矩形裁剪'),
        SizedBox(
          height: 70,
          child: ClipRect(
            child: Align(
              alignment: Alignment.centerLeft,
              widthFactor: 0.55,
              child: Container(
                width: 300,
                height: 70,
                color: Colors.blue,
                alignment: Alignment.centerLeft,
                child: const Text(
                  '宽内容被矩形边界裁掉',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        SectionTitle('② ClipRRect：圆角矩形裁剪'),
        SizedBox(
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Container(
              color: Colors.teal.shade100,
              child: const Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -30,
                    right: -20,
                    child: Box('超出边缘', color: Colors.teal, size: 80),
                  ),
                ],
              ),
            ),
          ),
        ),
        SectionTitle('③ ClipOval：圆形或椭圆裁剪'),
        Row(
          children: [
            ClipOval(
              child: Container(
                width: 76,
                height: 76,
                color: Colors.pink.shade200,
                alignment: Alignment.center,
                child: const Text('头像'),
              ),
            ),
            const SizedBox(width: 12),
            ClipOval(
              child: Container(
                width: 120,
                height: 64,
                color: Colors.orange.shade200,
                alignment: Alignment.center,
                child: const Text('椭圆'),
              ),
            ),
          ],
        ),
        SectionTitle('④ ClipPath：自定义路径'),
        ClipPath(
          clipper: const _PentagonClipper(),
          child: Container(
            height: 120,
            color: Colors.indigo.shade300,
            alignment: Alignment.center,
            child: const Text('五边形裁剪', style: TextStyle(color: Colors.white)),
          ),
        ),
        LearnNote('裁剪有额外绘制成本。只需圆角背景时用 BoxDecoration；需要内容本身也被裁掉时再用 ClipRRect。'),
        const KnowledgeCard(
          '练习',
          '把 Stack 中超出容器的角标分别放在 Clip.none 和 Clip.hardEdge 下观察区别。',
        ),
      ],
    );
  }
}

class _PentagonClipper extends CustomClipper<Path> {
  const _PentagonClipper();

  @override
  Path getClip(Size size) => Path()
    ..moveTo(size.width * 0.5, 0)
    ..lineTo(size.width, size.height * 0.38)
    ..lineTo(size.width * 0.82, size.height)
    ..lineTo(size.width * 0.18, size.height)
    ..lineTo(0, size.height * 0.38)
    ..close();

  @override
  bool shouldReclip(covariant _PentagonClipper oldClipper) => false;
}
