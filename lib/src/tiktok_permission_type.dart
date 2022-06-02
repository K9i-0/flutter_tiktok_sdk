part of '../flutter_tiktok_sdk.dart';

enum TikTokPermissionType {
  userInfoBasic('user.info.basic'),
  shareSoundCreate('share.sound.create'),
  videoList('video.list'),
  videoUpload('video.upload');

  final String scopeName;

  const TikTokPermissionType(this.scopeName);
}

TikTokPermissionType? _fromScopeName(String scopeName) {
  switch (scopeName) {
    case 'user.info.basic':
      return TikTokPermissionType.userInfoBasic;
    case 'share.sound.create':
      return TikTokPermissionType.shareSoundCreate;
    case 'video.list':
      return TikTokPermissionType.videoList;
    case 'video.upload':
      return TikTokPermissionType.videoUpload;
    default:
      return null;
  }
}
