import 'package:favorites_youtube_bloc_pattern/models/video.dart';
import 'package:favorites_youtube_bloc_pattern/widgets/player_youtube.dart';
import 'package:flutter/material.dart';

class PlayerVideo extends StatelessWidget {
  final Video _video;

  const PlayerVideo(this._video, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_video.title, maxLines: 1,),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: PlayerYoutube(_video.id),
            ),
          ),
        ],
      ),
    );
  }
}