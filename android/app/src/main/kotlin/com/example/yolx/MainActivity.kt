package com.yoyo.yolx

import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.provider.Settings;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.yoyo.flutter_native_channel/native_methods"
    private var channelResult: MethodChannel.Result? =null;
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            channelResult=result;
            if(call.method == "nativeLibraryDir"){
                result.success(applicationInfo.nativeLibraryDir)
            }else if(call.method == "requestPermission"){
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) { //30
                    // 先判断有没有权限
                    if (!Environment.isExternalStorageManager()) {
                        //跳转到设置界面引导用户打开
                        val intent = Intent(Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION)
                        intent.data = Uri.parse("package:$packageName")
                        startActivityForResult(intent, 6666)
                    }else{
                        result.success(true)
                    }
                }

            } else {
                result.notImplemented()
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode==6666){
            if (Environment.isExternalStorageManager()){
                channelResult?.success(true)
            } else {
                channelResult?.success(false);
            }
        }
    }
}
