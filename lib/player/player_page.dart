// ============================================================
// 高度可控音频播放器 · 界面
// 入口:AudioPlayerPage()
// 演示点:
//   播放/暂停/停止,快进倒退,进度条拖拽 seek
//   变速(0.5x~2x),音量滑杆,循环模式切换
//   多曲目播放列表(上一首/下一首/点击高亮)
//   播放源:网络 URL + assets 资源,均支持
// ============================================================

import 'package:flutter/material.dart';

import 'controller.dart';

/// 内置的演示曲目(替换成你自己的音频即可;url 用网络,assetPath 用本地资源)
const _kTracks = <Track>[
  // 一个公开可访问的示例音源(无版权演示用)。正式使用请换成你自己的链接或资源。
  Track(id: 't1', title: '示例曲·A (网络)', url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'),
  Track(id: 't2', title: '示例曲·B (网络)', url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3'),
];

class AudioPlayerPage extends StatefulWidget {
  const AudioPlayerPage({super.key, this.tracks = _kTracks});
  final List<Track> tracks;

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  late AudioPlayerController ctrl;
  double _speed = 1.0;
  double _volume = 1.0;

  @override
  void initState() {
    super.initState();
    ctrl = AudioPlayerController();
    ctrl.setQueue(widget.tracks);
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('音频播放器 · 高度可控')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _NowPlaying(ctrl: ctrl),
            const SizedBox(height: 16),
            _ProgressSeekBar(ctrl: ctrl),
            const SizedBox(height: 12),
            _TransportControls(ctrl: ctrl, pageState: this),
            const SizedBox(height: 12),
            _SpeedAndVolume(
              speed: _speed,
              volume: _volume,
              onChangeSpeed: (s) {
                setState(() => _speed = s);
                ctrl.setSpeed(s);
              },
              onChangeVolume: (v) {
                setState(() => _volume = v);
                ctrl.setVolume(v);
              },
            ),
            const SizedBox(height: 12),
            _LoopRow(ctrl: ctrl),
            const SizedBox(height: 20),
            const Text('播放列表', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _Playlist(ctrl: ctrl),
          ],
        ),
      ),
    );
  }
}

/// 正在播那首 / loading / 状态
class _NowPlaying extends StatelessWidget {
  final AudioPlayerController ctrl;
  const _NowPlaying({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.music_note, size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: ValueListenableBuilder<String>(
              valueListenable: ctrl.currentTitle,
              builder: (_, title, _) => Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // 播放/暂停按钮(核心控制)
          ValueListenableBuilder<bool>(
            valueListenable: ctrl.loading,
            builder: (_, loading, _) {
              if (loading) {
                return const Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              }
              final playing = ctrl.player.playing;
              return IconButton(
                iconSize: 40,
                icon: Icon(playing ? Icons.pause_circle : Icons.play_circle),
                onPressed: () => ctrl.togglePlayPause(),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// 进度条 + 当前/总时长 + 快进快退
class _ProgressSeekBar extends StatelessWidget {
  final AudioPlayerController ctrl;
  const _ProgressSeekBar({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: ctrl.positionStream,
      builder: (context, snap) {
        final pos = snap.data ?? Duration.zero;
        return StreamBuilder<Duration?>(
          stream: ctrl.player.durationStream,
          builder: (context, dSnap) {
            final dur = dSnap.data ?? Duration.zero;
            final total = dur.inMilliseconds.toDouble();
            final cur = pos.inMilliseconds.clamp(0, dur.inMilliseconds).toDouble();
            return Column(
              children: [
                Slider(
                  value: total > 0 ? cur : 0,
                  max: total > 0 ? total : 1,
                  onChanged: (v) => ctrl.seekTo(Duration(milliseconds: v.round())),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_fmt(pos), style: const TextStyle(fontSize: 12)),
                    Text('${_fmt(pos)} / ${_fmt(dur)}', style: const TextStyle(fontSize: 12)),
                    Text(_fmt(dur), style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _fmt(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    return h > 0 ? '${two(h)}:${two(m)}:${two(s)}' : '${two(m)}:${two(s)}';
  }
}

/// 播放控制按钮组:上一条 / 播放暂停 / 下一条 / 停止 / 快进快退
class _TransportControls extends StatelessWidget {
  final AudioPlayerController ctrl;
  final _AudioPlayerPageState pageState;
  const _TransportControls({required this.ctrl, required this.pageState});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(icon: const Icon(Icons.replay_30), onPressed: () => ctrl.skip(const Duration(seconds: -30)), tooltip: '后退30秒'),
        IconButton(icon: const Icon(Icons.skip_previous), iconSize: 34, onPressed: () => ctrl.previous(), tooltip: '上一首'),
        ValueListenableBuilder<bool>(
          valueListenable: ctrl.loading,
          builder: (_, loading, _) {
            if (loading) return const CircularProgressIndicator(strokeWidth: 3);
            final playing = ctrl.player.playing;
            return IconButton.filled(
              iconSize: 44,
              icon: Icon(playing ? Icons.pause : Icons.play_arrow),
              onPressed: () => ctrl.togglePlayPause(),
              tooltip: playing ? '暂停' : '播放',
            );
          },
        ),
        IconButton(icon: const Icon(Icons.skip_next), iconSize: 34, onPressed: () => ctrl.next(), tooltip: '下一首'),
        IconButton(icon: const Icon(Icons.forward_30), onPressed: () => ctrl.skip(const Duration(seconds: 30)), tooltip: '前进30秒'),
        IconButton(icon: const Icon(Icons.stop), onPressed: () => ctrl.stop(), tooltip: '停止'),
      ],
    );
  }
}

/// 速度 + 音量两个滑杆
class _SpeedAndVolume extends StatelessWidget {
  final double speed;
  final double volume;
  final ValueChanged<double> onChangeSpeed;
  final ValueChanged<double> onChangeVolume;
  const _SpeedAndVolume({
    required this.speed,
    required this.volume,
    required this.onChangeSpeed,
    required this.onChangeVolume,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.speed, size: 18),
            const SizedBox(width: 8),
            const Text('速度'),
            Expanded(
              child: Slider(
                value: speed,
                min: 0.5,
                max: 2.0,
                divisions: 6,
                label: '${speed}x',
                onChanged: onChangeSpeed,
              ),
            ),
            Text('${speed.toStringAsFixed(1)}x', style: const TextStyle(fontSize: 12)),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.volume_down, size: 18),
            const SizedBox(width: 8),
            const Text('音量'),
            Expanded(
              child: Slider(
                value: volume,
                onChanged: onChangeVolume,
              ),
            ),
            const Icon(Icons.volume_up, size: 18),
          ],
        ),
      ],
    );
  }
}

/// 循环模式切换
class _LoopRow extends StatefulWidget {
  final AudioPlayerController ctrl;
  const _LoopRow({required this.ctrl});

  @override
  State<_LoopRow> createState() => _LoopRowState();
}

class _LoopRowState extends State<_LoopRow> {
  @override
  Widget build(BuildContext context) {
    final ctrl = widget.ctrl;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('循环:'),
        const SizedBox(width: 8),
        OutlinedButton.icon(
          onPressed: () async {
            await ctrl.cycleLoop();
            setState(() {}); // 刷新标签
          },
          icon: Icon(switch (ctrl.loop) {
            LoopModeSetting.none => Icons.repeat,
            LoopModeSetting.single => Icons.repeat_one,
            LoopModeSetting.all => Icons.repeat,
          }),
          label: Text(switch (ctrl.loop) {
            LoopModeSetting.none => '不循环',
            LoopModeSetting.single => '单曲',
            LoopModeSetting.all => '列表',
          }),
        ),
      ],
    );
  }
}

/// 播放列表(点击某行直接播放,正在播那首高亮/标记)
class _Playlist extends StatelessWidget {
  final AudioPlayerController ctrl;
  const _Playlist({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: ctrl.currentIndex,
      builder: (_, current, _) {
        return Column(
          children: [
            for (var i = 0; i < ctrl.trackCount; i++)
              ListTile(
                leading: Icon(
                  i == current ? Icons.graphic_eq : Icons.music_video,
                  color: i == current ? Theme.of(context).colorScheme.primary : null,
                ),
                title: Text(
                  ctrl.titleAt(i),
                  style: TextStyle(
                    fontWeight: i == current ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                trailing: i == current ? const Text('▶') : null,
                selected: i == current,
                onTap: () => ctrl.playIndex(i),
              ),
          ],
        );
      },
    );
  }
}