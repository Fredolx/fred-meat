import 'package:flutter/material.dart';
import 'package:fred_meat/native_bridge.dart';
import 'package:permission_handler/permission_handler.dart';
import 'ble_denied.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  static const _blePermissions = [
    Permission.bluetoothScan,
    Permission.bluetoothConnect,
  ];

  bool _permissionsGranted = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _requestBlePermissions();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !_permissionsGranted) {
      _refreshPermissionStatus();
    }
  }

  Future<void> _requestBlePermissions() async {
    final statuses = await [for (final p in _blePermissions) p].request();
    if (!mounted) {
      return;
    }
    setState(() {
      _permissionsGranted = statuses.values.every((s) => s.isGranted);
      _loading = false;
    });
    try {
      await NativeBridge.instance.scan();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _refreshPermissionStatus() async {
    var granted = true;
    for (final p in _blePermissions) {
      if (!await p.isGranted) {
        granted = false;
        break;
      }
    }
    if (!mounted) {
      return;
    }
    setState(() => _permissionsGranted = granted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _permissionsGranted
          ? const Center(child: Text("Works!"))
          : BleDenied(),
    );
  }
}
