import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerYoutube extends StatelessWidget {
  final String _sVideoID;

  const PlayerYoutube(this._sVideoID, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: _sVideoID,
          flags: const YoutubePlayerFlags(autoPlay: true, loop: true,),
        ),
        liveUIColor: Colors.red,
      ),
    );
  }
}
