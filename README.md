# flutter_tiktok_sdk

A Flutter plugin that lets developers access TikTok's native SDKs in Flutter apps with Dart

Native SDK documentation 👉 https://developers.tiktok.com/doc

# iOS Configuration
Go to https://developers.tiktok.com/doc/getting-started-ios-quickstart-swift
### Step 1: Configure TikTok App Settings for iOS
Go to TikTok Developer App Registration Page to create your app. After approval, you will get the Client Key and Client Secret.

### Step 2: Configure Xcode Project
Configure Info.plist
```
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>tiktokopensdk</string>
    <string>tiktoksharesdk</string>
    <string>snssdk1180</string>
    <string>snssdk1233</string>
</array>
<key>TikTokAppID</key>
<string>$TikTokAppID</string>
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>$TikTokAppID</string>
    </array>
  </dict>
</array>
```

# Android Configuration
Go to https://developers.tiktok.com/doc/getting-started-android-quickstart
### Step 1: Configure TikTok App Settings for Android
Use the Developer Portal to apply for Android client_key and client_secret access. Upon application approval, the Developer Portal will provide access to these keys.

### Step 2: Edit Your Manifest
Register TikTokEntryActivity for receiving callbacks in Manifest.
```
<activity
            android:name="com.k9i.flutter_tiktok_sdk.TikTokEntryActivity"
            android:exported="true" />
```
Due to changes in Android 11 regarding package visibility, when impementing Tiktok SDK for devices targeting Android 11 and higher, add the following to the Android Manifest file:
```
<queries>
    <package android:name="com.zhiliaoapp.musically" />
    <package android:name="com.ss.android.ugc.trill" />
</queries>
```
# Example code
See the example directory for a complete sample app using flutter_tiktok_sdk.

[example](https://github.com/K9i-0/flutter_tiktok_sdk/tree/main/example)

