import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class BleDenied extends StatelessWidget {
  const BleDenied({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "You must enable bluetooth permissions for this app to work properly",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => openAppSettings(),
            child: const Text("Open settings"),
          ),
        ],
      ),
    );
  }
}
