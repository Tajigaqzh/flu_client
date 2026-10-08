// ============================================================
// 知识点:如何加载图片
// 三种常见来源:本地资源 / 网络 / 运行时内存
//   本地资源(最常用):把图片放进 assets,在 pubspec.yaml 声明
//   网络:          直接给 URL,Image.network 自动下载
//   内存:          decodeImageFromList 直接解码字节
// 配套:简介卡 + 三种实时示例
// ============================================================

import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../common.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeScaffold(
      title: '加载图片',
      children: [
        KnowledgeCard('加载图片', '本地资源得先声明到 pubspec.yaml;网络图给 URL 即可;任何来源都最好配 errorBuilder 兜底,免得加载失败白屏。'),

        SectionTitle('① 加载本地资源 Image.asset'),
        LearnNote('要先用 pubspec.yaml 声明(a已注册 assets/images/)。用 errorBuilder 兜底:图加载失败时显示一个占位图标。'),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/images/demo.png', // 路径要和 pubspec 声明一致
            width: 120,
            height: 120,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stack) => const _BrokenPlaceholder(),
          ),
        ),

        SectionTitle('② 加载网络图片 Image.network'),
        LearnNote('loadingBuilder 显示加载中;errorBuilder 处理没网/地址错。注意:模拟器需能联网才能看到。'),
        Image.network(
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg', // 示例图(Flutter 官方)
          width: 180,
          height: 120,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) =>
              progress == null ? child : const Center(child: CircularProgressIndicator()),
          errorBuilder: (context, error, stack) => const _BrokenPlaceholder(),
        ),

        SectionTitle('③ 加载内存字节 Image.memory'),
        LearnNote('数据已在内存(如刚下载完的字节)时用。例:Image.memory(bytes)。这里用本地 demo.png 的字节演示。'),
        FutureBuilder<Uint8List>(
          future: DefaultAssetBundle.of(context)
              .load('assets/images/demo.png')
              .then((data) => data.buffer.asUint8List()),
          builder: (context, snap) {
            if (!snap.hasData) return const SizedBox(height: 60);
            return Image.memory(snap.data!, width: 120, height: 120, fit: BoxFit.cover);
          },
        ),
      ],
    );
  }
}

/// 加载失败时显示的占位块。
class _BrokenPlaceholder extends StatelessWidget {
  const _BrokenPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      color: Colors.grey.shade300,
      child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
    );
  }
}