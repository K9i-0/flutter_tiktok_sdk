part of '../flutter_tiktok_sdk.dart';

enum TikTokPermissionType {
  userInfoBasic,
  shareSoundCreate,
  videoList,
  videoUpload,
}

extension TikTokPermissionTypeEx on TikTokPermissionType {
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
