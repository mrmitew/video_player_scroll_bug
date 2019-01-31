import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player_bug/video_feed_tile.dart';

final tiles = [
  VideoFeedTileModel(asset: "assets/videos/video1.mp4"),
  VideoFeedTileModel(asset: "assets/videos/video2.mp4"),
  VideoFeedTileModel(asset: "assets/images/photo.png"),
  VideoFeedTileModel(asset: "assets/images/photo2.jpg"),
  VideoFeedTileModel(asset: "assets/images/photo.png"),
  VideoFeedTileModel(asset: "assets/images/photo2.jpg"),
];

class VideoFeedPage extends StatelessWidget {
  static createRoute() {
    return CupertinoPageRoute<void>(
      builder: (BuildContext context) => VideoFeedPage(),
    );
  }

  const VideoFeedPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Colors.black,
        child: SafeArea(
          child: ListView.builder(
              itemCount: tiles.length,
              itemBuilder: (ctx, index) => Padding(
                    padding: EdgeInsets.all(16.0),
                    child: VideoFeedTile(
                      VideoFeedTileModel(asset: tiles[index].asset),
                    ),
                  )),
        ));
  }
}
