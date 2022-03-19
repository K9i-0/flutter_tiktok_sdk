part of '../flutter_tiktok_sdk.dart';

class TikTokAuthResult {
  const TikTokAuthResult({
    required this.status,
    this.authCode,
    this.errorCode,
    this.errorMessage,
  });
  final TikTokAuthStatus status;
  final String? authCode;
  final String? errorCode;
  final String? errorMessage;

  @override
  String toString() {
    return 'TikTokAuthResult{status: $status, authCode: $authCode, errorCode: $errorCode, errorMessage: $errorMessage}';
  }
}

enum TikTokAuthStatus {
  success,
  cancelled,
  error,
}
