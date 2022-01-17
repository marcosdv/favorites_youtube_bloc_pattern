import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favorites_youtube_bloc_pattern/blocs/favoritos_bloc.dart';
import 'package:favorites_youtube_bloc_pattern/blocs/video_bloc.dart';
import 'package:favorites_youtube_bloc_pattern/delegates/data_search.dart';
import 'package:favorites_youtube_bloc_pattern/models/video.dart';
import 'package:favorites_youtube_bloc_pattern/screens/favoritos.dart';
import 'package:favorites_youtube_bloc_pattern/widgets/video_tile.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _videoBloc = BlocProvider.getBloc<VideoBloc>();
    final _favoritoBloc = BlocProvider.getBloc<FavoritosBloc>();

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("images/youtube_dark.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: [
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
              stream: _favoritoBloc.outFav,
              initialData: const {},
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text("${snapshot.data!.length}");
                }
                return Container();
              },
            ),
          ),
          IconButton(
              icon: const Icon(Icons.star),
              onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Favoritos())
                );
              }
          ),
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                String? resultado = await showSearch<String?>(context: context, delegate: DataSearch());
                if (resultado != null) {
                  _videoBloc.inSearch.add(resultado);
                }
              }
          ),
        ],
      ),
      body: StreamBuilder<List<Video>>(
        stream: _videoBloc.outVideos,
        initialData: const [],
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length + 1,
              itemBuilder: (context, index) {
                if (index < snapshot.data!.length) {
                  return VideoTile(snapshot.data![index]);
                }
                else if (index > 1) {
                  _videoBloc.inSearch.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),),
                  );
                }
                return Container();
              }
            );
          }
          else {
            return Container();
          }
        },
      ),
    );
  }
}
