package com.example.fred_meat

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    init {
        System.loadLibrary("fred_meat_lib")
    }
}
