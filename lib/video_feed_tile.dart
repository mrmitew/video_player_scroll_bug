import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoFeedTileModel {
  final String asset;

  VideoFeedTileModel({this.asset});
}

class VideoFeedTile extends StatefulWidget {
  final VideoFeedTileModel model;
  VideoFeedTile(this.model);

  @override
  VideoFeedTileState createState() {
    return new VideoFeedTileState();
  }
}

class VideoFeedTileState extends State<VideoFeedTile> {
  VideoPlayerController _controller;

  VoidCallback _listener;
  bool initialized = false;

  VideoFeedTileState() {
    _listener = () {
      if (_controller.value.hasError) {
        print(_controller.value.errorDescription);
      }

      if (!mounted) {
        return;
      }
      if (initialized != _controller.value.initialized) {
        initialized = _controller.value.initialized;
        setState(() {});
      }
    };
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.model.asset)..initialize();
    _controller.addListener(_listener);
  }

  @override
  void deactivate() {
    _controller.setVolume(0.0);
    _controller.removeListener(_listener);
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isVideo() => widget.model.asset.contains(".mp4");

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: size.height - 300),
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: _isVideo()
                    ? Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          _controller.value.initialized
                              ? AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: VideoPlayer(_controller),
                                )
                              : Container(),
                          !_controller.value.isPlaying
                              ? Container(
                                  color: Colors.black45,
                                )
                              : SizedBox(),
                          !_controller.value.isPlaying
                              ? Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.play_circle_outline,
                                    color: Colors.white,
                                    size: 42,
                                  ),
                                )
                              : SizedBox()
                        ],
                      )
                    : Image.asset(
                        widget.model.asset,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
