import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favorites_youtube_bloc_pattern/blocs/favoritos_bloc.dart';
import 'package:favorites_youtube_bloc_pattern/models/video.dart';
import 'package:favorites_youtube_bloc_pattern/screens/player_video.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {
  final Video _video;

  const VideoTile(this._video);

  @override
  Widget build(BuildContext context) {
    final _favoritoBloc = BlocProvider.getBloc<FavoritosBloc>();

    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16.0/9.0,
              child: Image.network(_video.thumb, fit: BoxFit.cover,),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text(_video.title, style: const TextStyle(color: Colors.white, fontSize: 16), maxLines: 2,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(_video.channel, style: const TextStyle(color: Colors.white, fontSize: 14),),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<Map<String, Video>>(
                    stream: _favoritoBloc.outFav,
                    initialData: const {},
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return IconButton(
                          icon: Icon(
                              snapshot.data!.containsKey(_video.id) == true ? Icons.star : Icons.star_border
                          ),
                          color: Colors.white,
                          iconSize: 30,
                          onPressed: () { _favoritoBloc.toggleFavorito(_video); },
                        );
                      }
                      return const CircularProgressIndicator();
                    }
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => PlayerVideo(_video))
        );
      },
    );
  }
}
