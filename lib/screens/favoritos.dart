import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favorites_youtube_bloc_pattern/blocs/favoritos_bloc.dart';
import 'package:favorites_youtube_bloc_pattern/models/video.dart';
import 'package:favorites_youtube_bloc_pattern/screens/player_video.dart';
import 'package:flutter/material.dart';

class Favoritos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _favoritosBloc = BlocProvider.getBloc<FavoritosBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        stream: _favoritosBloc.outFav,
        initialData: const {},
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.values.map((v) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => PlayerVideo(v))
                    );
                  },
                  onLongPress: () { _favoritosBloc.toggleFavorito(v); },
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 50,
                        child: Image.network(v.thumb),
                      ),
                      Expanded(child: Text(v.title, style: const TextStyle(color: Colors.white70), maxLines: 2,),),
                    ],
                  ),
                );
              }).toList(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
