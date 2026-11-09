import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../l10n/l10n.dart';
import '../../sounds/data/youtube_library.dart';
import '../data/alarm_audio.dart';
import '../data/embedded_music.dart';

/// The official player remains visible, with its own controls and branding.
/// Hidden/background playback yields to the dependable local alarm.
class EmbeddedMusicPlayer extends StatefulWidget {
  const EmbeddedMusicPlayer({
    super.key,
    required this.source,
    this.alarmId,
    required this.deadline,
    required this.active,
  });
  final EmbeddedMusic source;
  final int? alarmId;
  final DateTime deadline;
  final bool active;

  @override
  State<EmbeddedMusicPlayer> createState() => _EmbeddedMusicPlayerState();
}

class _EmbeddedMusicPlayerState extends State<EmbeddedMusicPlayer> with WidgetsBindingObserver {
  WebViewController? _controller;
  Timer? _visibility;
  bool _foreground = true, _visible = true, _audible = false, _failed = false;
  DateTime? _lastProgress;
  bool get _allowed => mounted && widget.active && _foreground && _visible && DateTime.now().isBefore(widget.deadline);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _foreground =
        WidgetsBinding.instance.lifecycleState == null ||
        WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed;
    unawaited(_load());
    _visibility = Timer.periodic(const Duration(milliseconds: 250), (_) => _checkVisibility());
  }

  Future<void> _load() async {
    try {
      List<String>? videos;
      final playlist = widget.source.playlist;
      if (playlist != null) {
        final token = await YouTubeAccount.token(prompt: false);
        if (token != null) {
          final library = YouTubeLibrary(token);
          try {
            videos = await library.playlistVideos(playlist);
          } finally {
            library.close();
          }
          if (videos.isEmpty) throw StateError('Empty playlist');
        }
      }
      if (!mounted || DateTime.now().isAfter(widget.deadline)) return;
      final params = WebViewPlatform.instance is WebKitWebViewPlatform
          ? WebKitWebViewControllerCreationParams(
              allowsInlineMediaPlayback: true,
              mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
            )
          : const PlatformWebViewControllerCreationParams();
      final controller = WebViewController.fromPlatformCreationParams(params);
      _controller = controller;
      await controller.setJavaScriptMode(JavaScriptMode.unrestricted);
      await controller.addJavaScriptChannel(
        'QuandoPlayer',
        onMessageReceived: (message) {
          if (!mounted) return;
          if (message.message == 'playing') _lastProgress = DateTime.now();
          if (message.message == 'error') setState(() => _failed = true);
          if (message.message == 'playing' && !_allowed) {
            unawaited(_pause());
            return;
          }
          unawaited(_setAudible(message.message == 'playing' && _allowed));
        },
      );
      await controller.setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (error) {
            if (error.isForMainFrame == true && mounted) {
              setState(() => _failed = true);
              unawaited(_setAudible(false));
            }
          },
          // Authentication belongs in the system Google flow, never this player.
          onNavigationRequest: (request) =>
              request.isMainFrame && !request.url.startsWith(widget.source.origin) && request.url != 'about:blank'
              ? NavigationDecision.prevent
              : NavigationDecision.navigate,
        ),
      );
      if (controller.platform is AndroidWebViewController) {
        await (controller.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
      }
      if (!mounted) {
        await controller.loadRequest(Uri.parse('about:blank'));
        return;
      }
      setState(() {});
      await WidgetsBinding.instance.endOfFrame;
      if (!mounted) return;
      _checkVisibility();
      await controller.loadHtmlString(
        widget.source.html(remaining: widget.deadline.difference(DateTime.now()), videos: videos, autoplay: _allowed),
        baseUrl: widget.source.origin,
      );
      if (!mounted) {
        await controller.loadRequest(Uri.parse('about:blank'));
        return;
      }
      setState(() {});
      if (!_allowed) await _pause();
    } catch (_) {
      if (mounted) {
        setState(() => _failed = true);
        await _setAudible(false);
      }
    }
  }

  Future<void> _setAudible(bool value) async {
    if (_audible == value) return;
    _audible = value;
    final id = widget.alarmId;
    final muted = id == null || await AlarmAudio.mute(id, value);
    if (value && !muted) await _pause();
    if (value && !_allowed) await _pause();
  }

  Future<void> _pause() async {
    try {
      await _controller?.runJavaScript('quandoPause()');
    } catch (_) {}
    await _setAudible(false);
  }

  void _checkVisibility() {
    if (!mounted) return;
    if (widget.source.provider == 'SoundCloud' &&
        _audible &&
        _lastProgress != null &&
        DateTime.now().difference(_lastProgress!) > const Duration(seconds: 3)) {
      unawaited(_setAudible(false));
    }
    final box = context.findRenderObject();
    if (box is! RenderBox || !box.hasSize) return;
    final bounds = box.localToGlobal(Offset.zero) & box.size;
    final viewport = Offset.zero & MediaQuery.sizeOf(context);
    final overlap = bounds.intersect(viewport);
    final visible = !overlap.isEmpty && overlap.width * overlap.height >= bounds.width * bounds.height * .5;
    if (_visible == visible) return;
    _visible = visible;
    _updateAllowed();
  }

  void _updateAllowed() {
    if (!_allowed) {
      unawaited(_pause());
      return;
    }
    unawaited(_controller?.runJavaScript('quandoAllow()').catchError((_) {}) ?? Future<void>.value());
  }

  @override
  void didUpdateWidget(covariant EmbeddedMusicPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.active != widget.active) _updateAllowed();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _foreground = state == AppLifecycleState.resumed;
    _updateAllowed();
  }

  @override
  void dispose() {
    _visibility?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    // about:blank destroys the official player even if its API is still loading.
    final controller = _controller;
    if (controller != null) unawaited(controller.loadRequest(Uri.parse('about:blank')).catchError((_) {}));
    if (_audible && widget.alarmId != null) unawaited(AlarmAudio.mute(widget.alarmId!, false));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.centerLeft,
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 640),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_failed)
            Text(
              widget.alarmId == null ? l10n.musicPreviewFailed : l10n.musicBackupPlaying,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          SizedBox(
            height: math.max(200, math.min(640, MediaQuery.sizeOf(context).width - 56) * 9 / 16),
            child: _controller == null
                ? Center(child: _failed ? Text(widget.source.provider) : const CircularProgressIndicator())
                : WebViewWidget(controller: _controller!),
          ),
        ],
      ),
    ),
  );
}
