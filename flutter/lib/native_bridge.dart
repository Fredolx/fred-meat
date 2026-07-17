import 'dart:async';
import 'dart:ffi';
import 'dart:io' show Platform;
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:fred_meat/generated/bindings.dart' as ffi;
import 'package:fred_meat/generated/generated_proto.pb.dart' as pb;
import 'package:fred_meat/proto_extensions.dart';
import 'package:protobuf/protobuf.dart' as $pb;

import 'models/settings.dart';

class NativeBridge {
  static NativeBridge? _instance;

  final ffi.RustLibBindings _bindings;
  int _nextTaskId = 0;
  final Map<int, Completer<pb.FFIResult>> _pendingRequests = {};
  late final NativeCallable<Void Function(Uint64, Pointer<Uint8>, Size)>
  _globalCallback;

  static NativeBridge get instance => _instance ??= NativeBridge._internal(
    ffi.RustLibBindings(_openDynamicLibrary()),
  );

  static DynamicLibrary _openDynamicLibrary() {
    if (Platform.isAndroid || Platform.isLinux) {
      return DynamicLibrary.open("libfred_meat_lib.so");
    }
    if (Platform.isIOS || Platform.isMacOS) {
      return DynamicLibrary.process();
    }
    if (Platform.isWindows) {
      return DynamicLibrary.open("fred_meat_lib.dll");
    }
    return DynamicLibrary.open("libfred_meat_lib.so");
  }

  NativeBridge._internal(this._bindings) {
    _globalCallback =
        NativeCallable<Void Function(Uint64, Pointer<Uint8>, Size)>.listener((
          int taskId,
          Pointer<Uint8> ptr,
          int len,
        ) {
          final completer = _pendingRequests.remove(taskId);
          if (completer == null) return;

          try {
            final Uint8List copiedBytes;
            try {
              final u8List = ptr.asTypedList(len);
              copiedBytes = Uint8List.fromList(u8List);
            } finally {
              _bindings.free_message(ptr, len);
            }
            final result = pb.FFIResult.fromBuffer(copiedBytes);
            completer.complete(result);
          } catch (e, stackTrace) {
            completer.completeError(e, stackTrace);
          }
        });
  }

  Future<pb.FFIResult> _executeAsync(
    void Function(int taskId, ffi.FfiCallback callback) ffiAction,
  ) async {
    final taskId = _nextTaskId++;
    final completer = Completer<pb.FFIResult>();
    _pendingRequests[taskId] = completer;
    ffiAction(taskId, _globalCallback.nativeFunction);
    final result = await completer.future;
    if (!result.success) {
      throw Exception(
        result.hasErrorMessage() ? result.errorMessage : "Unknown FFI error",
      );
    }
    return result;
  }

  Future<pb.FFIResult> _executeWithMsg<T extends $pb.GeneratedMessage>(
    T request,
    void Function(
      int taskId,
      Pointer<Uint8> ptr,
      int len,
      ffi.FfiCallback callback,
    )
    ffiAction,
  ) async {
    final pbBytes = request.writeToBuffer();
    final nativeBuffer = malloc.allocate<Uint8>(pbBytes.length);

    try {
      final pointerList = nativeBuffer.asTypedList(pbBytes.length);
      pointerList.setAll(0, pbBytes);

      return await _executeAsync((id, cb) {
        ffiAction(id, nativeBuffer, pbBytes.length, cb);
      });
    } finally {
      malloc.free(nativeBuffer);
    }
  }

  Future<Settings> getSettings() async {
    final result = await _executeAsync((id, cb) {
      _bindings.get_settings(id, cb);
    });
    return result.settings.toDomain();
  }

  Future<void> updateSettings(Settings settings) async {
    await _executeWithMsg(settings.toProto(), (id, ptr, len, cb) {
      _bindings.update_settings(id, cb, ptr, len);
    });
  }

  Future<void> initialize(pb.InitMessage init) async {
    await _executeWithMsg(init, (id, ptr, len, cb) {
      _bindings.initialize(id, cb, ptr, len);
    });
  }

  Future<bool> shouldShowWhatsNew(String? currentVersion) async {
    final result = await _executeWithMsg(
      pb.OptStrMessage(value: currentVersion),
      (id, ptr, len, cb) {
        _bindings.should_show_whats_new(id, cb, ptr, len);
      },
    );
    return result.boolMessage.value;
  }

  Future<void> updateLastSeenVersion(String version) async {
    await _executeWithMsg(pb.StrMessage(value: version), (id, ptr, len, cb) {
      _bindings.update_last_seen_version(id, cb, ptr, len);
    });
  }

  void dispose() {
    _globalCallback.close();
    for (final completer in _pendingRequests.values) {
      if (!completer.isCompleted) {
        completer.completeError(StateError("NativeBridge was disposed."));
      }
    }
    _pendingRequests.clear();
    _instance = null;
  }
}
