import 'package:flutter_test/flutter_test.dart';
import 'package:instabug_task/core/data/data_retriever.dart';

import '../../fake_method_channel.dart';

void main() {
  group('DataRetriever', () {
    late DataRetriever dataRetriever;
    late FakeMethodChannel androidChannel;
    late FakeMethodChannel iosChannel;

    setUp(() {
      androidChannel = FakeMethodChannel('android');
      iosChannel = FakeMethodChannel('ios');
      dataRetriever = DataRetriever(androidChannel, iosChannel);
    });

    test('should return Android data on Android platform', () async {
      // Act
      final result = await dataRetriever.getData();
      // Assert
      expect(
          result, '{"movies": ["The Shawshank Redemption", "The Godfather", "The Dark Knight"]}');
    });

    test('should return iOS data on iOS platform', () async {
      // Act
      final result = await dataRetriever.getData();
      // Assert
      expect(
          result, '{"movies": ["The Shawshank Redemption", "The Godfather", "The Dark Knight"]}');
    });
  });
}
