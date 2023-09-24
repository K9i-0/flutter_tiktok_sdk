# flutter_tiktok_sdk

A Flutter plugin that lets developers access TikTok's native SDKs in Flutter apps with Dart

Native SDK documentation 👉 https://developers.tiktok.com/doc/getting-started-create-an-app/

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
### Step 3: Edit AppDelegate.swift
Add the following code to your AppDelegate.swift file.
```
import UIKit
import Flutter

// Add this line
import TikTokOpenSDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // Add this line
    TikTokOpenSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

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

# Maintenance Status of this Repository
This package was originally developed when I needed TikTok authentication for an application at my previous job. However, since I've changed jobs, I no longer have a use for the TikTok SDK. As such, my motivation to proactively add new features has decreased. That said, I'm open to reviewing pull requests if anyone wishes to contribute.

Additionally, if someone with high motivation wishes to fork this repository and develop a successor package (e.g., flutter_tiktok_sdk_plus), you are more than welcome. Should that happen, I will take measures to ensure that users are aware of the successor package.

