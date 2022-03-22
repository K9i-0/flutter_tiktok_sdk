package com.k9i.flutter_tiktok_sdk

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import com.bytedance.sdk.open.tiktok.TikTokOpenApiFactory
import com.bytedance.sdk.open.tiktok.api.TikTokOpenApi
import com.bytedance.sdk.open.tiktok.authorize.model.Authorization
import com.bytedance.sdk.open.tiktok.common.handler.IApiEventHandler
import com.bytedance.sdk.open.tiktok.common.model.BaseReq
import com.bytedance.sdk.open.tiktok.common.model.BaseResp

// Activity receiving callbacks from TikTok Sdk
class TikTokEntryActivity : Activity(), IApiEventHandler {
    private lateinit var tikTokOpenApi: TikTokOpenApi

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        tikTokOpenApi = TikTokOpenApiFactory.create(this)
        tikTokOpenApi.handleIntent(intent, this)
    }

    override fun onReq(req: BaseReq) {
    }

    override fun onResp(resp: BaseResp) {
        if (resp is Authorization.Response) {
            val launchIntent = packageManager.getLaunchIntentForPackage(packageName)
            if (launchIntent == null) {
                finish()
                return
            }
            launchIntent.putExtra(TIKTOK_LOGIN_RESULT_SUCCESS, resp.isSuccess)
            launchIntent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP
            if (resp.isSuccess) {
                launchIntent.putExtra(TIKTOK_LOGIN_RESULT_AUTH_CODE, resp.authCode)
            } else {
                launchIntent.putExtra(TIKTOK_LOGIN_RESULT_CANCEL, resp.isCancel)
                launchIntent.putExtra(TIKTOK_LOGIN_RESULT_ERROR_CODE, resp.errorCode)
                launchIntent.putExtra(TIKTOK_LOGIN_RESULT_ERROR_MSG, resp.errorMsg)
            }
            startActivity(launchIntent)
            finish()
        } else {
            // TODO Video Kit Implementation
            finish()
        }
    }

    override fun onErrorIntent(intent: Intent) {
        finish()
    }

    companion object {
        const val TIKTOK_LOGIN_RESULT_SUCCESS = "TIKTOK_LOGIN_RESULT_SUCCESS"
        const val TIKTOK_LOGIN_RESULT_CANCEL = "TIKTOK_LOGIN_RESULT_CANCEL"
        const val TIKTOK_LOGIN_RESULT_AUTH_CODE = "TIKTOK_LOGIN_RESULT_AUTH_CODE"
        const val TIKTOK_LOGIN_RESULT_ERROR_CODE = "TIKTOK_LOGIN_RESULT_ERROR_CODE"
        const val TIKTOK_LOGIN_RESULT_ERROR_MSG = "TIKTOK_LOGIN_RESULT_ERROR_MSG"
    }
}