import 'package:flutter/services.dart';

class Constant {
  static const String baseUrl = "https://api.themoviedb.org/3/";
  static const String imageUrl = "https://image.tmdb.org/t/p/w500";

  static const String moviesKey = "movies";

  static const String androidChannelId = 'movie_api';
  static const String iosChannelId = 'com.movieapi/native_module';
  static const MethodChannel androidChannel = MethodChannel(androidChannelId);
  static const MethodChannel iosChannel = MethodChannel(iosChannelId);
}
