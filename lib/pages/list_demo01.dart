import 'package:flutter/cupertino.dart';

class ArrayListDemo extends StatefulWidget {
  const ArrayListDemo({super.key});

  @override
  State<ArrayListDemo> createState() => _ArrayListDemoState();
}

class _ArrayListDemoState extends State<ArrayListDemo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
