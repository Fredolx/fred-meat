// This is a generated file - do not edit.
//
// Generated from generated_proto.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class InitMessage extends $pb.GeneratedMessage {
  factory InitMessage({
    $core.String? dbPath,
    $core.String? tempPath,
  }) {
    final result = create();
    if (dbPath != null) result.dbPath = dbPath;
    if (tempPath != null) result.tempPath = tempPath;
    return result;
  }

  InitMessage._();

  factory InitMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InitMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitMessage',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'generated_proto'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'dbPath')
    ..aOS(2, _omitFieldNames ? '' : 'tempPath')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitMessage copyWith(void Function(InitMessage) updates) =>
      super.copyWith((message) => updates(message as InitMessage))
          as InitMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitMessage create() => InitMessage._();
  @$core.override
  InitMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InitMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InitMessage>(create);
  static InitMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get dbPath => $_getSZ(0);
  @$pb.TagNumber(1)
  set dbPath($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDbPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearDbPath() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get tempPath => $_getSZ(1);
  @$pb.TagNumber(2)
  set tempPath($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTempPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearTempPath() => $_clearField(2);
}

class StrMessage extends $pb.GeneratedMessage {
  factory StrMessage({
    $core.String? value,
  }) {
    final result = create();
    if (value != null) result.value = value;
    return result;
  }

  StrMessage._();

  factory StrMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StrMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StrMessage',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'generated_proto'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StrMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StrMessage copyWith(void Function(StrMessage) updates) =>
      super.copyWith((message) => updates(message as StrMessage)) as StrMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StrMessage create() => StrMessage._();
  @$core.override
  StrMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StrMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StrMessage>(create);
  static StrMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get value => $_getSZ(0);
  @$pb.TagNumber(1)
  set value($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => $_clearField(1);
}

class OptStrMessage extends $pb.GeneratedMessage {
  factory OptStrMessage({
    $core.String? value,
  }) {
    final result = create();
    if (value != null) result.value = value;
    return result;
  }

  OptStrMessage._();

  factory OptStrMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OptStrMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OptStrMessage',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'generated_proto'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OptStrMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OptStrMessage copyWith(void Function(OptStrMessage) updates) =>
      super.copyWith((message) => updates(message as OptStrMessage))
          as OptStrMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OptStrMessage create() => OptStrMessage._();
  @$core.override
  OptStrMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static OptStrMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OptStrMessage>(create);
  static OptStrMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get value => $_getSZ(0);
  @$pb.TagNumber(1)
  set value($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => $_clearField(1);
}

class BoolMessage extends $pb.GeneratedMessage {
  factory BoolMessage({
    $core.bool? value,
  }) {
    final result = create();
    if (value != null) result.value = value;
    return result;
  }

  BoolMessage._();

  factory BoolMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BoolMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BoolMessage',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'generated_proto'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BoolMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BoolMessage copyWith(void Function(BoolMessage) updates) =>
      super.copyWith((message) => updates(message as BoolMessage))
          as BoolMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BoolMessage create() => BoolMessage._();
  @$core.override
  BoolMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BoolMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BoolMessage>(create);
  static BoolMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get value => $_getBF(0);
  @$pb.TagNumber(1)
  set value($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => $_clearField(1);
}

class Settings extends $pb.GeneratedMessage {
  factory Settings({
    $core.bool? test,
  }) {
    final result = create();
    if (test != null) result.test = test;
    return result;
  }

  Settings._();

  factory Settings.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Settings.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Settings',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'generated_proto'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'test')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Settings clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Settings copyWith(void Function(Settings) updates) =>
      super.copyWith((message) => updates(message as Settings)) as Settings;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Settings create() => Settings._();
  @$core.override
  Settings createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Settings getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Settings>(create);
  static Settings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get test => $_getBF(0);
  @$pb.TagNumber(1)
  set test($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTest() => $_has(0);
  @$pb.TagNumber(1)
  void clearTest() => $_clearField(1);
}

enum FFIResult_Data { boolMessage, settings, notSet }

class FFIResult extends $pb.GeneratedMessage {
  factory FFIResult({
    $core.bool? success,
    $core.String? errorMessage,
    BoolMessage? boolMessage,
    Settings? settings,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (boolMessage != null) result.boolMessage = boolMessage;
    if (settings != null) result.settings = settings;
    return result;
  }

  FFIResult._();

  factory FFIResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FFIResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, FFIResult_Data> _FFIResult_DataByTag = {
    3: FFIResult_Data.boolMessage,
    4: FFIResult_Data.settings,
    0: FFIResult_Data.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FFIResult',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'generated_proto'),
      createEmptyInstance: create)
    ..oo(0, [3, 4])
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<BoolMessage>(3, _omitFieldNames ? '' : 'boolMessage',
        subBuilder: BoolMessage.create)
    ..aOM<Settings>(4, _omitFieldNames ? '' : 'settings',
        subBuilder: Settings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FFIResult clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FFIResult copyWith(void Function(FFIResult) updates) =>
      super.copyWith((message) => updates(message as FFIResult)) as FFIResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FFIResult create() => FFIResult._();
  @$core.override
  FFIResult createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FFIResult getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FFIResult>(create);
  static FFIResult? _defaultInstance;

  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  FFIResult_Data whichData() => _FFIResult_DataByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  void clearData() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorMessage => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorMessage($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasErrorMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  BoolMessage get boolMessage => $_getN(2);
  @$pb.TagNumber(3)
  set boolMessage(BoolMessage value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasBoolMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearBoolMessage() => $_clearField(3);
  @$pb.TagNumber(3)
  BoolMessage ensureBoolMessage() => $_ensure(2);

  @$pb.TagNumber(4)
  Settings get settings => $_getN(3);
  @$pb.TagNumber(4)
  set settings(Settings value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasSettings() => $_has(3);
  @$pb.TagNumber(4)
  void clearSettings() => $_clearField(4);
  @$pb.TagNumber(4)
  Settings ensureSettings() => $_ensure(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
