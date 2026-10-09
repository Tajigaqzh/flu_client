// ============================================================
// 知识点 10:样式与装饰
//   颜色 / 圆角 / 边框 / 渐变·阴影
//   都写在 BoxDecoration 装饰盒里(除了颜色能直接写在
//   Container 的 color: 上)。
// ============================================================

import 'package:flutter/material.dart';
import '../common.dart';

class StylePage extends StatelessWidget {
  const StylePage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '样式与装饰',
      children: [
        KnowledgeCard(
          '样式 / 圆角 / 边框',
          '颜色、圆角、边框、渐变、阴影全住在 BoxDecoration 里。圆角 borderRadius 调“圆到什么程度”,边框 border 用的是 Border.all 或细调每一条边。',
        ),

        SectionTitle('① 颜色 Color 的三种写法'),
        LearnNote(
          '系统色 Colors.blue / 深浅 Colors.grey.shade600 / 十六进制 Color(0xFF……)。',
        ),
        const Row(
          spacing: 8,
          children: [
            Box('Colors.blue', color: Colors.blue, size: 72),
            Box('shade600', color: Colors.blueGrey, size: 72),
            Box('#00BFA5', color: Color(0xFF00BFA5), size: 72),
          ],
        ),

        SectionTitle('② 圆角 borderRadius(重点★)'),
        LearnNote(
          '①四个角一起圆:BorderRadius.circular(值),值越大越圆,圆到“一边边长一半”就是正圆。②只圆一个角用 BorderRadius.only。',
        ),
        Row(
          spacing: 8,
          children: [
            _corner(radius: 8, label: '圆8'),
            _corner(radius: 25, label: '圆25'),
            _corner(radius: 60, label: '圆60≈正圆', size: 120),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: 120,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(30)),
          ),
          child: const Text('只圆左上', style: TextStyle(color: Colors.white)),
        ),

        SectionTitle('③ 边框 border'),
        LearnNote(
          'Border.all(颜色, 粗细) 四边一样。只能放进 BoxDecoration。红色那个是“红边 + 圆角”组合。',
        ),
        Row(
          spacing: 8,
          children: [
            Container(
              width: 70,
              height: 70,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent, width: 2),
              ),
              child: const Text('透2', style: TextStyle(color: Colors.white)),
            ),
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red, width: 3),
              ),
              child: const Center(child: Text('红3')),
            ),
          ],
        ),

        SectionTitle('④ 渐变 + 阴影'),
        LearnNote('gradient 渐变背景、boxShadow 阴影。这是做出“高级感”最快的一招。'),
        Row(
          spacing: 8,
          children: [
            Container(
              width: 150,
              height: 70,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.teal, Colors.indigo],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('渐变', style: TextStyle(color: Colors.white)),
            ),
            Container(
              width: 150,
              height: 70,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                border: Border.all(color: Colors.amber, width: 2),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: const Text('阴影+边框+圆角', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _corner({
    required double radius,
    required String label,
    double size = 60,
  }) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 11),
      ),
    );
  }
}
