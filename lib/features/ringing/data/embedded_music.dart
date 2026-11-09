import 'dart:convert';

import '../../../app/edition.dart';
import '../../../core/util/platform.dart';

/// Only official, visible provider widgets. URLs and OAuth tokens are never
/// interpolated as executable JavaScript.
class EmbeddedMusic {
  const EmbeddedMusic._(this.provider, this.link, {this.video, this.playlist});
  final String provider;
  final String link;
  final String? video;
  final String? playlist;

  static bool get available => supportsLocalAlarms;
  static final _id = RegExp(r'^[A-Za-z0-9_-]+$');
  static String _js(Object? value) =>
      jsonEncode(value).replaceAll('<', r'\u003c').replaceAll('>', r'\u003e').replaceAll('&', r'\u0026');
  static EmbeddedMusic? parse(String? link) {
    final uri = Uri.tryParse(link ?? '');
    if (uri == null || uri.scheme != 'https' || uri.userInfo.isNotEmpty || uri.hasPort) return null;
    if ({'youtube.com', 'www.youtube.com', 'music.youtube.com', 'youtu.be'}.contains(uri.host)) {
      final video = uri.host == 'youtu.be' ? uri.pathSegments.firstOrNull : uri.queryParameters['v'];
      final playlist = uri.queryParameters['list'];
      final validVideo = video != null && video.length == 11 && _id.hasMatch(video) ? video : null;
      final validList = playlist != null && playlist.length <= 150 && _id.hasMatch(playlist)
          ? playlist
          : null;
      if (validVideo == null && validList == null) return null;
      return EmbeddedMusic._('YouTube', link!, video: validVideo, playlist: validList);
    }
    if ({'soundcloud.com', 'www.soundcloud.com'}.contains(uri.host) && uri.pathSegments.length >= 2) {
      return EmbeddedMusic._('SoundCloud', link!);
    }
    return null;
  }

  // YouTube requires the native app's identity as an HTTPS origin/referrer.
  String get origin =>
      'https://com.dendrito.quando${mine
          ? '.mine'
          : kodesh
          ? '.kodesh'
          : ''}';

  /// [remaining] is the alarm's remaining duration, never a per-song timer.
  /// The page also stops itself if the Flutter route is being torn down.
  String html({required Duration remaining, List<String>? videos, bool autoplay = true}) {
    final deadline = remaining.inMilliseconds.clamp(0, 86400000);
    final setup = provider == 'YouTube'
        ? '''
      function onYouTubeIframeAPIReady() {
        player = new YT.Player('player', {width:'100%', height:'100%',
          playerVars:{controls:1, playsinline:1, origin:${_js(origin)}},
          events:{onReady:function(e){
            ${videos != null
              ? 'e.target.cuePlaylist(${_js(videos)});'
              : playlist != null
              ? 'e.target.cuePlaylist({listType:"playlist",list:${_js(playlist)}});'
              : 'e.target.cueVideoById(${_js(video)});'}
            ready=true;quandoAllow(allowed);
          }, onStateChange:function(e){
            if (e.data === 1 && !allowed) { player.pauseVideo(); return; }
            if(e.data===1) started=true;send(e.data === 1 ? 'playing' : 'waiting');
          }, onError:function(e){ send('error'); }, onAutoplayBlocked:function(){send('waiting');}}
        });
      }
      var api=document.createElement('script');api.src='https://www.youtube.com/iframe_api';
      document.head.appendChild(api);
    '''
        : '''
      var frame=document.createElement('iframe');frame.id='soundcloud';frame.allow='autoplay';
      frame.src='https://w.soundcloud.com/player/?url='+encodeURIComponent(${_js(link)})+'&auto_play=false&visual=true';
      document.getElementById('player').appendChild(frame);
      var api=document.createElement('script');api.src='https://w.soundcloud.com/player/api.js';
      api.onload=function(){player=SC.Widget(frame);
        player.bind(SC.Widget.Events.READY,function(){ready=true;quandoAllow(allowed);});
        player.bind(SC.Widget.Events.PLAY,function(){if(!allowed){player.pause();return;}started=true;send('playing');});
        player.bind(SC.Widget.Events.PLAY_PROGRESS,function(){if(allowed)send('playing');else player.pause();});
        player.bind(SC.Widget.Events.PAUSE,function(){send('waiting');});
        player.bind(SC.Widget.Events.FINISH,function(){send('waiting');});
        player.bind(SC.Widget.Events.ERROR,function(){send('error');});
      };document.head.appendChild(api);
    ''';
    return '''<!doctype html><html><head>
      <meta name="viewport" content="width=device-width,initial-scale=1">
      <meta name="referrer" content="strict-origin-when-cross-origin">
      <style>html,body,#player,iframe{margin:0;width:100%;height:100%;border:0;background:#1b1023;overflow:hidden}</style>
      </head><body><div id="player"></div><script>
      var player, allowed=$autoplay, finished=false, ready=false, started=false;
      function send(state){if(window.QuandoPlayer) QuandoPlayer.postMessage(state);}
      function quandoPause(){allowed=false;if(player){${provider == 'YouTube' ? 'if(player.pauseVideo) player.pauseVideo();' : 'player.pause();'}}send('waiting');}
      function quandoAllow(value){if(!finished) {allowed=value!==false;if(allowed&&ready&&!started){${provider == 'YouTube' ? 'player.playVideo();' : 'player.play();'}}}}
      function quandoStop(){finished=true;quandoPause();}
      document.addEventListener('visibilitychange',function(){if(document.hidden)quandoPause();});
      window.addEventListener('pagehide',quandoStop);
      setTimeout(quandoStop,$deadline);
      $setup
      </script></body></html>''';
  }
}
