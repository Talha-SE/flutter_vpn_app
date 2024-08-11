package com.example.vpn_app

import android.content.Intent
import android.net.VpnService
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.vpn_app/vpn"
    private val VPN_REQUEST_CODE = 0

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "startVpn" -> {
                    val intent = VpnService.prepare(this)
                    if (intent != null) {
                        startActivityForResult(intent, VPN_REQUEST_CODE)
                    } else {
                        onActivityResult(VPN_REQUEST_CODE, RESULT_OK, null)
                    }
                    result.success(null)
                }
                "stopVpn" -> {
                    stopVpnService()
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == VPN_REQUEST_CODE && resultCode == RESULT_OK) {
            startVpnService()
        }
    }

    private fun startVpnService() {
        val serviceIntent = Intent(this, VpnService::class.java).apply {
            action = "CONNECT"
        }
        startService(serviceIntent)
    }

    private fun stopVpnService() {
        val serviceIntent = Intent(this, VpnService::class.java).apply {
            action = "DISCONNECT"
        }
        startService(serviceIntent)
    }
}