part of '../flutter_tiktok_sdk.dart';

class TikTokLoginResult {
  const TikTokLoginResult({
    required this.status,
    this.authCode,
    this.state,
    this.grantedPermissions,
    this.errorCode,
    this.errorMessage,
  });
  final TikTokLoginStatus status;
  final String? authCode;
  final String? state;
  final Set<TikTokPermissionType>? grantedPermissions;
  final String? errorCode;
  final String? errorMessage;

  @override
  String toString() {
    return 'TikTokLoginResult{status: $status, authCode: $authCode, state: $state, grantedPermissions: $grantedPermissions, errorCode: $errorCode, errorMessage: $errorMessage}';
  }
}

enum TikTokLoginStatus {
  success,
  cancelled,
  error,
}
