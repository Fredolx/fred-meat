import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:fred_meat/generated/generated_proto.pb.dart' as gen;
import 'package:fred_meat/home.dart';
import 'package:fred_meat/native_bridge.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  final appDir = await getApplicationSupportDirectory();
  final tempDir = await getApplicationCacheDirectory();
  try {
    await NativeBridge.instance.initialize(
      gen.InitMessage(dbPath: appDir.path, tempPath: tempDir.path),
    );
  } catch (e, stack) {
    if (!e.toString().contains(appDir.path)) {
      developer.log(
        "Failed to initialize NativeBridge",
        error: e,
        stackTrace: stack,
        name: "dev.fredol.open-tv",
      );
    }
  }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const Home(),
    );
  }
}
