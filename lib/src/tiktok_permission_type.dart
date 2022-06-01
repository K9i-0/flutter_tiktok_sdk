part of '../flutter_tiktok_sdk.dart';

enum TikTokPermissionType {
  userInfoBasic,
  shareSoundCreate,
  videoList,
  videoUpload;

  String get scopeName {
    switch (this) {
      case TikTokPermissionType.userInfoBasic:
        return 'user.info.basic';
      case TikTokPermissionType.shareSoundCreate:
        return 'share.sound.create';
      case TikTokPermissionType.videoList:
        return 'video.list';
      case TikTokPermissionType.videoUpload:
        return 'video.upload';
    }
  }
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
