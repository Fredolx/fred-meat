// This is a generated file - do not edit.
//
// Generated from generated_proto.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use initMessageDescriptor instead')
const InitMessage$json = {
  '1': 'InitMessage',
  '2': [
    {'1': 'db_path', '3': 1, '4': 1, '5': 9, '10': 'dbPath'},
    {'1': 'temp_path', '3': 2, '4': 1, '5': 9, '10': 'tempPath'},
  ],
};

/// Descriptor for `InitMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initMessageDescriptor = $convert.base64Decode(
    'CgtJbml0TWVzc2FnZRIXCgdkYl9wYXRoGAEgASgJUgZkYlBhdGgSGwoJdGVtcF9wYXRoGAIgAS'
    'gJUgh0ZW1wUGF0aA==');

@$core.Deprecated('Use strMessageDescriptor instead')
const StrMessage$json = {
  '1': 'StrMessage',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `StrMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List strMessageDescriptor =
    $convert.base64Decode('CgpTdHJNZXNzYWdlEhQKBXZhbHVlGAEgASgJUgV2YWx1ZQ==');

@$core.Deprecated('Use optStrMessageDescriptor instead')
const OptStrMessage$json = {
  '1': 'OptStrMessage',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'value', '17': true},
  ],
  '8': [
    {'1': '_value'},
  ],
};

/// Descriptor for `OptStrMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List optStrMessageDescriptor = $convert.base64Decode(
    'Cg1PcHRTdHJNZXNzYWdlEhkKBXZhbHVlGAEgASgJSABSBXZhbHVliAEBQggKBl92YWx1ZQ==');

@$core.Deprecated('Use boolMessageDescriptor instead')
const BoolMessage$json = {
  '1': 'BoolMessage',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 8, '10': 'value'},
  ],
};

/// Descriptor for `BoolMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List boolMessageDescriptor =
    $convert.base64Decode('CgtCb29sTWVzc2FnZRIUCgV2YWx1ZRgBIAEoCFIFdmFsdWU=');

@$core.Deprecated('Use settingsDescriptor instead')
const Settings$json = {
  '1': 'Settings',
  '2': [
    {'1': 'test', '3': 1, '4': 1, '5': 8, '9': 0, '10': 'test', '17': true},
  ],
  '8': [
    {'1': '_test'},
  ],
};

/// Descriptor for `Settings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settingsDescriptor = $convert.base64Decode(
    'CghTZXR0aW5ncxIXCgR0ZXN0GAEgASgISABSBHRlc3SIAQFCBwoFX3Rlc3Q=');

@$core.Deprecated('Use fFIResultDescriptor instead')
const FFIResult$json = {
  '1': 'FFIResult',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {
      '1': 'error_message',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'errorMessage',
      '17': true
    },
    {
      '1': 'bool_message',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.generated_proto.BoolMessage',
      '9': 0,
      '10': 'boolMessage'
    },
    {
      '1': 'settings',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.generated_proto.Settings',
      '9': 0,
      '10': 'settings'
    },
  ],
  '8': [
    {'1': 'data'},
    {'1': '_error_message'},
  ],
};

/// Descriptor for `FFIResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fFIResultDescriptor = $convert.base64Decode(
    'CglGRklSZXN1bHQSGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIoCg1lcnJvcl9tZXNzYWdlGA'
    'IgASgJSAFSDGVycm9yTWVzc2FnZYgBARJBCgxib29sX21lc3NhZ2UYAyABKAsyHC5nZW5lcmF0'
    'ZWRfcHJvdG8uQm9vbE1lc3NhZ2VIAFILYm9vbE1lc3NhZ2USNwoIc2V0dGluZ3MYBCABKAsyGS'
    '5nZW5lcmF0ZWRfcHJvdG8uU2V0dGluZ3NIAFIIc2V0dGluZ3NCBgoEZGF0YUIQCg5fZXJyb3Jf'
    'bWVzc2FnZQ==');
