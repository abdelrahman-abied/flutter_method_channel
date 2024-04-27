import 'package:flutter/services.dart';

class FakeMethodChannel implements MethodChannel {
  final String _channelName;

  FakeMethodChannel(this._channelName);

  Future<T?> invokeMethod<T>(String method, [dynamic arguments]) async {
    switch (_channelName) {
      case 'android':
        if (method == 'fetchMovies') {
          return Future.value(
              '{"movies": ["The Shawshank Redemption", "The Godfather", "The Dark Knight"]}' as T);
        }
        break;
      case 'ios':
        if (method == 'fetchMovies') {
          return Future.value(
              '{"movies": ["The Shawshank Redemption", "The Godfather", "The Dark Knight"]}' as T);
        }
        break;
    }
    return null;
  }

  @override
  // TODO: implement binaryMessenger
  BinaryMessenger get binaryMessenger => throw UnimplementedError();

  @override
  // TODO: implement codec
  MethodCodec get codec => throw UnimplementedError();

  @override
  Future<List<T>?> invokeListMethod<T>(String method, [arguments]) {
    // TODO: implement invokeListMethod
    throw UnimplementedError();
  }

  @override
  Future<Map<K, V>?> invokeMapMethod<K, V>(String method, [arguments]) {
    // TODO: implement invokeMapMethod
    throw UnimplementedError();
  }

  @override
  // TODO: implement name
  String get name => throw UnimplementedError();

  @override
  void setMethodCallHandler(Future Function(MethodCall call)? handler) {
    // TODO: implement setMethodCallHandler
  }
}
