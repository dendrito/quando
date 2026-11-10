import 'dart:io';
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../../app/edition.dart';
import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/platform.dart';
import '../../home/domain/sky.dart';
import '../../home/ui/sky_panel.dart';
import '../../quotes/ui/quote_line.dart';
import '../share_channel.dart';

import 'package:quando/l10n/l10n.dart';

/// Where people can get Quando?, printed small on every card.
const storeLink = 'play.google.com/store/apps/details?id=com.dendrito.alarmapp';

/// The morning card: today's sky (the real sky card) and today's quote, or
/// your own photo and words, ready for Instagram Stories, WhatsApp status
/// or anywhere else. Quando? opens the app with it loaded; you post it.
class ShareCardScreen extends ConsumerStatefulWidget {
  const ShareCardScreen({super.key});

  @override
  ConsumerState<ShareCardScreen> createState() => _ShareCardScreenState();
}

class _ShareCardScreenState extends ConsumerState<ShareCardScreen> {
  final _card = GlobalKey();
  final _words = TextEditingController();
  bool _story = true;
  File? _photo;

  /// A video, or a photo shared as it is: no card around it.
  File? _asIs;
  bool _busy = false;

  @override
  void dispose() {
    _words.dispose();
    super.dispose();
  }

  Future<void> _pick({required bool video}) async {
    final files = await FilePicker.pickFiles(type: video ? FileType.video : FileType.image);
    final path = files.isEmpty ? null : files.single.path;
    if (path == null || !mounted) return;
    setState(() {
      if (video) {
        _asIs = File(path);
      } else {
        _photo = File(path);
        _asIs = null;
      }
    });
  }

  /// The card as a PNG in Quando?'s share folder.
  Future<String> _render() async {
    final boundary = _card.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final width = boundary.size.width;
    final image = await boundary.toImage(pixelRatio: 1080 / width);
    final png = await image.toByteData(format: ui.ImageByteFormat.png);
    final dir = Directory('${(await getTemporaryDirectory()).path}/share')..createSync(recursive: true);
    final file = File('${dir.path}/quando-${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(png!.buffer.asUint8List());
    return file.path;
  }

  Future<void> _share(Future<bool> Function(String path) to) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final path = _asIs?.path ?? await _render();
      final ok = await to(path);
      if (!ok && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.shareAppMissing)));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final now = ref.watch(clockProvider)();
    final place = ref.watch(skyPlaceProvider);
    final sky = place == null ? SkyDay(now: now) : SkyDay.of(place, now);
    final words = _words.text.trim();

    final card = RepaintBoundary(
      key: _card,
      child: AspectRatio(
        aspectRatio: _story ? 9 / 16 : 1,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1B1035), Color(0xFF3B1F4A), Color(0xFFB4566B)],
            ),
            image: _photo == null
                ? null
                : DecorationImage(
                    image: FileImage(_photo!),
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(Color(0x55000000), BlendMode.darken),
                  ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_photo == null) ...[
                  // The real sky card, as on the home screen.
                  IgnorePointer(child: SkyPanel(sky: sky)),
                  const SizedBox(height: 16),
                ],
                const Spacer(),
                if (words.isNotEmpty)
                  Text(
                    words,
                    style: text.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                  )
                else
                  QuoteLine(now: now, idle: false, color: Colors.white),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      appTitle,
                      style: text.titleMedium?.copyWith(
                        color: QuandoColors.amber,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        storeLink,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: text.labelSmall?.copyWith(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.shareCard), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 48),
        children: [
          if (_asIs != null)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.movie_outlined, color: QuandoColors.amber),
              title: Text(l10n.shareAsIs),
              subtitle: Text(_asIs!.path.split('/').last, style: text.bodySmall),
              trailing: IconButton(
                tooltip: l10n.delete,
                icon: const Icon(Icons.close),
                onPressed: () => setState(() => _asIs = null),
              ),
            )
          else ...[
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: _story ? 300 : 360),
                child: card,
              ),
            ),
            const SizedBox(height: 8),
            Text(l10n.shareTapQuote, style: text.bodySmall, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            SegmentedButton<bool>(
              segments: [
                ButtonSegment(value: true, label: Text(l10n.shareStory)),
                ButtonSegment(value: false, label: Text(l10n.shareSquare)),
              ],
              selected: {_story},
              onSelectionChanged: (s) => setState(() => _story = s.first),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _words,
              maxLines: 3,
              minLines: 1,
              decoration: InputDecoration(labelText: l10n.shareYourWords, hintText: l10n.shareYourWordsHint),
              onChanged: (_) => setState(() {}),
            ),
          ],
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              ActionChip(
                avatar: const Icon(Icons.photo_outlined, size: 18),
                label: Text(_photo == null ? l10n.shareYourPhoto : l10n.shareOtherPhoto),
                onPressed: () => _pick(video: false),
              ),
              if (_photo != null) ...[
                ActionChip(
                  avatar: const Icon(Icons.wb_twilight, size: 18),
                  label: Text(l10n.shareSkyBack),
                  onPressed: () => setState(() => _photo = null),
                ),
                ActionChip(
                  avatar: const Icon(Icons.image_outlined, size: 18),
                  label: Text(l10n.shareAsIs),
                  onPressed: () => setState(() => _asIs = _photo),
                ),
              ],
              ActionChip(
                avatar: const Icon(Icons.videocam_outlined, size: 18),
                label: Text(l10n.shareYourVideo),
                onPressed: () => _pick(video: true),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (isAndroid) ...[
            FilledButton.icon(
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
              onPressed: _busy ? null : () => _share(ShareChannel.story),
              icon: const Icon(Icons.camera_alt_outlined),
              label: Text(l10n.shareInstagramStory),
            ),
            const SizedBox(height: 8),
            FilledButton.tonalIcon(
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
              onPressed: _busy ? null : () => _share(_whatsapp),
              icon: const Icon(Icons.chat_outlined),
              label: Text(l10n.shareWhatsApp),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
              onPressed: _busy ? null : () => _share((p) => ShareChannel.send(p)),
              icon: const Icon(Icons.share_outlined),
              label: Text(l10n.shareMore),
            ),
            const SizedBox(height: 8),
            Text(l10n.shareYouPost, style: text.bodySmall),
          ] else
            Text(l10n.shareAndroidFirst, style: text.bodySmall),
        ],
      ),
    );
  }

  /// WhatsApp, or WhatsApp Business when that's the one on the phone. In
  /// WhatsApp, pick "My status" or a chat.
  Future<bool> _whatsapp(String path) async {
    final pkg = await ShareChannel.installed(ShareChannel.whatsapp)
        ? ShareChannel.whatsapp
        : ShareChannel.whatsappBusiness;
    return ShareChannel.send(path, package: pkg);
  }
}
