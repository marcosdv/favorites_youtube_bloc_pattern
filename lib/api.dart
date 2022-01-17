import 'dart:convert';

import 'package:favorites_youtube_bloc_pattern/models/video.dart';
import 'package:http/http.dart' as http;

const API_KEY = "YOUTUBE_API_KEY";

class Api {
  String _search = "";
  String _nextToken = "";

  Future<List<Video>> search(String busca) async {
    _search = busca;

    http.Response response = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$busca&type=video&key=$API_KEY&maxResults=10"
    ));

    return _decode(response);
  }

  Future<List<Video>> nextPage() async {
    http.Response response = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"
    ));

    return _decode(response);
  }

  List<Video> _decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      _nextToken = decoded["nextPageToken"];

      List<Video> videos = decoded["items"].map<Video>((map) {
        return Video.fromJson(map);
      }).toList();

      return videos;
    }

    throw Exception("Erro ao carregar os vídeos");
  }
}