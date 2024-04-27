import 'dart:io';

import 'package:flutter/services.dart';

class DataRetriever {
  final MethodChannel _androidChannel;
  final MethodChannel _iosChannel;

  DataRetriever(this._androidChannel, this._iosChannel);
  Future<String?> getData() async {
    try {
      if (Platform.isAndroid) {
        final json = await _androidChannel.invokeMethod('fetchMovies');
        return json;
      } else {
        final String? json = await _iosChannel.invokeMethod('fetchMovies');
        return json;
      }
    } catch (e) {
      rethrow;
    }
  }
}
