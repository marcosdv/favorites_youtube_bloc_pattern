import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favorites_youtube_bloc_pattern/models/video.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritosBloc implements BlocBase {
  Map<String, Video> _favoritos = {};

  final BehaviorSubject<Map<String, Video>> _favController = BehaviorSubject<Map<String, Video>>();
  Stream<Map<String, Video>> get outFav => _favController.stream;

  FavoritosBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains("favoritos")) {
        _favoritos = json.decode(prefs.getString("favoritos")!).map((key, value) {
          return MapEntry(key, Video.fromJson(value));
        }).cast<String, Video>();

        _favController.add(_favoritos);
      }
    });
  }

  void toggleFavorito(Video video) {
    if (_favoritos.containsKey(video.id)) {
      _favoritos.remove(video.id);
    }
    else {
      _favoritos[video.id] = video;
    }

    _favController.sink.add(_favoritos);

    _salvarFav();
  }

  void _salvarFav() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("favoritos", json.encode(_favoritos));
    });
  }

  @override
  void addListener(VoidCallback listener) {
  }

  @override
  void dispose() {
    _favController.close();
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