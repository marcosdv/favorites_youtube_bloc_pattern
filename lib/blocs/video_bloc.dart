import 'dart:async';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favorites_youtube_bloc_pattern/api.dart';
import 'package:favorites_youtube_bloc_pattern/models/video.dart';

class VideoBloc implements BlocBase {
  late Api api;
  late List<Video> videos;

  final StreamController<List<Video>> _videosController = StreamController<List<Video>>();
  Stream<List<Video>> get outVideos => _videosController.stream;

  final StreamController<String?> _searchController = StreamController<String?>();
  Sink get inSearch => _searchController.sink;

  VideoBloc() {
    api = Api();

    _searchController.stream.listen(_search);
  }

  void _search(String? busca) async {
    if (busca != null) {
      _videosController.sink.add([]);
      videos = await api.search(busca);
    }
    else {
      videos += await api.nextPage();
    }
    _videosController.sink.add(videos);
  }

  @override
  void addListener(VoidCallback listener) {

  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {

  }

  @override
  void removeListener(VoidCallback listener) {

  }
}