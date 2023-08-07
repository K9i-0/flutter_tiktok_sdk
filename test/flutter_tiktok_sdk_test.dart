import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tiktok_sdk/flutter_tiktok_sdk.dart';

void main() {
  const MethodChannel channel = MethodChannel('com.k9i/flutter_tiktok_sdk');

  TestWidgetsFlutterBinding.ensureInitialized();

  final dummyTikTokLoginResult = {
    "authCode": "authCode",
    "grantedPermissions":
        TikTokPermissionType.values.map((e) => e.scopeName).join(','),
  };

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'setup':
          return null;
        case 'login':
          return dummyTikTokLoginResult;
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('setup', () async {
    await TikTokSDK.instance.setup(clientKey: 'clientKey');
  });

  test('login', () async {
    final result = await TikTokSDK.instance
        .login(permissions: TikTokPermissionType.values.toSet());
    expect(result.status, TikTokLoginStatus.success);
    expect(result.state, null);
    expect(result.authCode, 'authCode');
    expect(result.grantedPermissions, TikTokPermissionType.values.toSet());
  });
}
