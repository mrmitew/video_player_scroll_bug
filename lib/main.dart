import 'package:flutter/material.dart';
import 'package:video_player_bug/video_feed_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video player scroll bug',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VideoFeedPage(),
    );
  }
}
