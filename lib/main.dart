import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favorites_youtube_bloc_pattern/blocs/favoritos_bloc.dart';
import 'package:favorites_youtube_bloc_pattern/blocs/video_bloc.dart';
import 'package:favorites_youtube_bloc_pattern/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [Bloc((i) => VideoBloc()), Bloc((i) => FavoritosBloc())],
      dependencies: [],
      child: MaterialApp(
        title: 'FlutterTube',
        theme: ThemeData(primarySwatch: Colors.blue,),
        debugShowCheckedModeBanner: false,
        home: const Home(),
      ),
    );
  }
}