package com.example.fred_meat

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    init {
        System.loadLibrary("libfred_meat_lib.so")
    }
}
