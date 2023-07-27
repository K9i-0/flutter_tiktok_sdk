part of '../flutter_tiktok_sdk.dart';

enum TikTokPermissionType {
  /// Access to TikTok public data for research purposes
  researchDataBasic('research.data.basic'),

  /// Read a user's profile info (open id, avatar, display name ...)
  userInfoBasic('user.info.basic'),

  /// Read access to profile_web_link, profile_deep_link, bio_description, is_verified.
  userInfoProfile('user.info.profile'),

  /// Read access to a user's statistical data, such as likes count, follower count, following count, and video count
  userInfoStats('user.info.stats'),

  /// Read a user's public videos on TikTok
  videoList('video.list'),

  /// Directly post videos to a user's TikTok profile.
  videoPublish('video.publish'),

  /// Share videos to the creator's account as a draft to further edit and post in TikTok.
  videoUpload('video.upload');

  final String scopeName;

  const TikTokPermissionType(this.scopeName);
}

TikTokPermissionType? _fromScopeName(String scopeName) {
  switch (scopeName) {
    case 'research.data.basic':
      return TikTokPermissionType.researchDataBasic;
    case 'user.info.basic':
      return TikTokPermissionType.userInfoBasic;
    case 'user.info.profile':
      return TikTokPermissionType.userInfoProfile;
    case 'user.info.stats':
      return TikTokPermissionType.userInfoStats;
    case 'video.list':
      return TikTokPermissionType.videoList;
    case 'video.publish':
      return TikTokPermissionType.videoPublish;
    case 'video.upload':
      return TikTokPermissionType.videoUpload;
    default:
      return null;
  }
}
