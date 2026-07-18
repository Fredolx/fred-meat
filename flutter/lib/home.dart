import 'dart:async';

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

  static const _stopDebounce = Duration(seconds: 6);

  bool _permissionsGranted = false;
  bool _loading = true;

  Timer? _stopTimer;
  DateTime? _pausedAt;

  Future<void> _bleOp = Future.value();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _requestBlePermissions();
  }

  @override
  void dispose() {
    _stopTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (!_permissionsGranted) await _refreshPermissionStatus();
      if (!mounted ||
          !_permissionsGranted ||
          WidgetsBinding.instance.lifecycleState != AppLifecycleState.resumed) {
        return;
      }
      final scanIsStale =
          _stopTimer == null ||
          DateTime.now().difference(_pausedAt!) >= _stopDebounce;
      _stopTimer?.cancel();
      _stopTimer = null;
      _pausedAt = null;
      if (scanIsStale) {
        print("restarted");
        _startScan();
      }
    }
    if (state == AppLifecycleState.paused) {
      _pausedAt = DateTime.now();
      _stopTimer?.cancel();
      _stopTimer = Timer(_stopDebounce, () {
        print("stopped");
        _stopTimer = null;
        _stopScan();
      });
    }
  }

  void _startScan() => _enqueueBleOp(NativeBridge.instance.start_scan);

  void _stopScan() => _enqueueBleOp(NativeBridge.instance.stop_scan);

  void _enqueueBleOp(Future<void> Function() op) {
    _bleOp = _bleOp.then((_) => op()).catchError((_) {});
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
    if (_permissionsGranted) _startScan();
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
