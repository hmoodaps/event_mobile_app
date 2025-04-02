package com.example.event_mobile_app

import android.content.Intent
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handlePaymentIntent(intent)
    }

    private fun handlePaymentIntent(intent: Intent) {
        if (intent.action == Intent.ACTION_VIEW && intent.data != null) {
            val data = intent.data!!
            if (data.scheme == "mollie" && data.host == "payment-return") {

                // التصحيح هنا: استخدام finish() مباشرة على النشاط الحالي
                this@MainActivity.finish()

                // إرسال الإشارة بدون بيانات
                MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, "mollie/payment")
                    .invokeMethod("paymentCompleted", null)
            }
        }
    }
}