part of '../flutter_tiktok_sdk.dart';

class TikTokLoginResult {
  const TikTokLoginResult({
    required this.status,
    this.authCode,
    this.errorCode,
    this.errorMessage,
  });
  final TikTokLoginStatus status;
  final String? authCode;
  final String? errorCode;
  final String? errorMessage;

  @override
  String toString() {
    return 'TikTokLoginResult{status: $status, authCode: $authCode, errorCode: $errorCode, errorMessage: $errorMessage}';
  }
}

enum TikTokLoginStatus {
  success,
  cancelled,
  error,
}
