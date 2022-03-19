import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tiktok_sdk/flutter_tiktok_sdk.dart';

void main() {
  const MethodChannel channel = MethodChannel('com.k9i/flutter_tiktok_sdk');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    // expect(await TikTokSDK.platformVersion, '42');
  });
}
