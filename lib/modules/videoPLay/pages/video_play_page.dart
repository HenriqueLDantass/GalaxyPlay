import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String linkVideo;
  final String title;
  const VideoPlayerScreen(
      {Key? key, required this.linkVideo, required this.title})
      : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.linkVideo)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    )..addListener(() {
        if (_controller.value.isFullScreen != _isFullScreen) {
          setState(() {
            _isFullScreen = _controller.value.isFullScreen;
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isFullScreen
          ? null
          : AppBar(
              title: Text(widget.title),
            ),
      body: Column(
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: _isFullScreen
                  ? MediaQuery.of(context).size.width
                  : double.infinity,
              maxHeight:
                  _isFullScreen ? MediaQuery.of(context).size.height : 300.0,
            ),
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () {},
              onEnded: (data) {},
            ),
          ),
          Visibility(
            visible: !_isFullScreen,
            child: const Text("Seu Texto aqui"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
