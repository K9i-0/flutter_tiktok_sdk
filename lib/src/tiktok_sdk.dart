part of '../flutter_tiktok_sdk.dart';

/// manager for TikTok SDK all features
class TikTokSDK {
  static const MethodChannel _channel =
      MethodChannel('com.k9i/flutter_tiktok_sdk');

  /// singleton object of TikTokSDK
  static final TikTokSDK instance = TikTokSDK._();

  TikTokSDK._();

  /// setup TikTokSDK
  /// Must be called only on Android.
  ///
  /// [clientKey] It is issued when you register your app on TikTok for developers.
  /// https://developers.tiktok.com/
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

  /// login TikTok
  ///
  /// [permissionType] You must apply for permissions at the time of app registration.
  Future<TikTokLoginResult> login({
    required Set<TikTokPermissionType> permissions,
    String? state,
  }) async {
    try {
      final scope =
          permissions.map((permission) => permission.scopeName).join(',');
      final result = await _channel.invokeMapMethod<String, Object>(
        'login',
        <String, dynamic>{
          'scope': scope,
          'state': state,
        },
      );

      if (result != null) {
        final grantedPermissionsStringList =
            (result['grantedPermissions'] as String).split(',');
        final grantedPermissions = grantedPermissionsStringList
            .map((permission) => _fromScopeName(permission))
            .whereType<TikTokPermissionType>()
            .toSet();

        return TikTokLoginResult(
          status: TikTokLoginStatus.success,
          authCode: result["authCode"] as String,
          state: result["state"] as String,
          grantedPermissions: grantedPermissions,
        );
      } else {
        return const TikTokLoginResult(
          status: TikTokLoginStatus.error,
        );
      }
    } on PlatformException catch (e) {
      final status = e.code == "-2"
          ? TikTokLoginStatus.cancelled
          : TikTokLoginStatus.error;

      return TikTokLoginResult(
        status: status,
        errorCode: e.code,
        errorMessage: e.message,
      );
    }
  }
}
