package com.example.vpn_app

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.net.VpnService
import android.os.Build
import android.os.ParcelFileDescriptor
import androidx.core.app.NotificationCompat

class VpnService : VpnService() {
    private val NOTIFICATION_CHANNEL_ID = "VPN_NOTIFICATION_CHANNEL"
    private val NOTIFICATION_ID = 1
    private var vpnInterface: ParcelFileDescriptor? = null

    override fun onCreate() {
        super.onCreate()
        createNotificationChannel()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        return when (intent?.action) {
            "CONNECT" -> connect()
            "DISCONNECT" -> disconnect()
            else -> START_NOT_STICKY
        }
    }

    private fun connect(): Int {
        startForeground(NOTIFICATION_ID, createNotification())
        
        try {
            vpnInterface = Builder()
                .setSession("VPN App")
                .addAddress("10.0.0.2", 32)
                .addDnsServer("8.8.8.8")
                .addRoute("0.0.0.0", 0)
                .establish()

            // Start a new thread for handling the VPN connection
            Thread {
                // Implement your VPN connection logic here
            }.start()

        } catch (e: Exception) {
            e.printStackTrace()
            return START_NOT_STICKY
        }

        return START_STICKY
    }

    private fun disconnect(): Int {
        vpnInterface?.close()
        vpnInterface = null
        stopForeground(true)
        stopSelf()
        return START_NOT_STICKY
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                NOTIFICATION_CHANNEL_ID,
                "VPN Service",
                NotificationManager.IMPORTANCE_DEFAULT
            )
            val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }

    private fun createNotification(): Notification {
        val intent = Intent(this, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(
            this,
            0,
            intent,
            PendingIntent.FLAG_IMMUTABLE
        )

        return NotificationCompat.Builder(this, NOTIFICATION_CHANNEL_ID)
            .setContentTitle("VPN is running")
            .setContentText("Tap to open the app")
            .setSmallIcon(R.drawable.ic_notification)
            .setContentIntent(pendingIntent)
            .build()
    }
}