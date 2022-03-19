part of '../flutter_tiktok_sdk.dart';

class TikTokSDK {
  static const MethodChannel _channel =
      MethodChannel('com.k9i/flutter_tiktok_sdk');

  static final TikTokSDK instance = TikTokSDK._();

  TikTokSDK._();

  Future<void> setup({required String clientKey}) async {
    if (Platform.isIOS) {
      return;
    }

    await _channel.invokeMethod(
      'setup',
      <String, dynamic>{
        'clientKey': clientKey,
      },
    );
  }

  Future<TikTokAuthResult> login({
    required Set<TikTokPermissionType> permissions,
    String? state,
  }) async {
    try {
      final scope =
          permissions.map((permission) => permission.scopeName).join(',');
      final authCode = await _channel.invokeMethod<String>(
        'login',
        <String, dynamic>{
          'scope': scope,
          'state': state,
        },
      );

      if (authCode != null) {
        return TikTokAuthResult(
          status: TikTokAuthStatus.success,
          authCode: authCode,
        );
      } else {
        return const TikTokAuthResult(
          status: TikTokAuthStatus.error,
        );
      }
    } on PlatformException catch (e) {
      final status =
          e.code == "-2" ? TikTokAuthStatus.cancelled : TikTokAuthStatus.error;

      return TikTokAuthResult(
        status: status,
        errorCode: e.code,
        errorMessage: e.message,
      );
    }
  }
}
