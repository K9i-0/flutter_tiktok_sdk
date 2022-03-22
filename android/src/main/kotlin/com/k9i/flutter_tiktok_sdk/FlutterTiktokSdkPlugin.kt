package com.k9i.flutter_tiktok_sdk

import android.app.Activity
import android.content.Intent
import android.util.Log
import androidx.annotation.NonNull
import com.bytedance.sdk.open.tiktok.TikTokOpenApiFactory
import com.bytedance.sdk.open.tiktok.TikTokOpenConfig
import com.bytedance.sdk.open.tiktok.api.TikTokOpenApi
import com.bytedance.sdk.open.tiktok.authorize.model.Authorization
import com.bytedance.sdk.open.tiktok.common.handler.IApiEventHandler
import com.bytedance.sdk.open.tiktok.common.model.BaseReq
import com.bytedance.sdk.open.tiktok.common.model.BaseResp

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry

/** FlutterTiktokSdkPlugin */
class FlutterTiktokSdkPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.NewIntentListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var tikTokOpenApi: TikTokOpenApi

  var activity: Activity? = null
  private var activityPluginBinding: ActivityPluginBinding? = null
  private var loginResult: Result? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.k9i/flutter_tiktok_sdk")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "setup" -> {
        val activity = activity
        if  (activity == null) {
          result.error(
                  "no_activity_found",
                  "There is no valid Activity found to present TikTok SDK Login screen.",
                  null
          )
          return
        }

        val clientKey = call.argument<String?>("clientKey")
        TikTokOpenApiFactory.init(TikTokOpenConfig(clientKey))
        tikTokOpenApi = TikTokOpenApiFactory.create(activity)
      }
      "login" -> {
        val request = Authorization.Request()

        val scope = call.argument<String>("scope")
        request.scope = scope
        val state = call.argument<String>("state")
        state?.let {
          request.state = it
        }

        request.callerLocalEntry = "com.k9i.flutter_tiktok_sdk.TikTokEntryActivity"

        tikTokOpenApi.authorize(request)
        loginResult = result
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    bindActivityBinding(binding)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    unbindActivityBinding()
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    bindActivityBinding(binding)
  }

  override fun onDetachedFromActivity() {
    unbindActivityBinding()
  }

  private fun bindActivityBinding(binding: ActivityPluginBinding) {
    activity = binding.activity
    activityPluginBinding = binding
    binding.addOnNewIntentListener(this);
  }

  private fun unbindActivityBinding() {
    activityPluginBinding?.removeOnNewIntentListener(this)
    activity = null
    activityPluginBinding = null
  }

  override fun onNewIntent(intent: Intent): Boolean {
    val isSuccess = intent.getBooleanExtra(TikTokEntryActivity.TIKTOK_LOGIN_RESULT_SUCCESS, false)
    if (isSuccess) {
      // 認証成功時は認証コードを返す
      val authorizationCode = intent.getStringExtra(TikTokEntryActivity.TIKTOK_LOGIN_RESULT_AUTH_CODE)
      loginResult?.success(authorizationCode)
    } else {
      // 認証失敗時はエラーを返す
      val errorCode = intent.getIntExtra(TikTokEntryActivity.TIKTOK_LOGIN_RESULT_ERROR_CODE, -999)
      val errorMessage = intent.getStringExtra(TikTokEntryActivity.TIKTOK_LOGIN_RESULT_ERROR_MSG);
      loginResult?.error(
              errorCode.toString(),
              errorMessage,
        null,
      )
    }
    loginResult = null
    return true
  }
}
