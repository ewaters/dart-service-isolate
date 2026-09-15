// This is a generated file - do not edit.
//
// Generated from chat_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class ChatServiceConfig extends $pb.GeneratedMessage {
  factory ChatServiceConfig({
    $core.String? serverAddress,
  }) {
    final result = create();
    if (serverAddress != null) result.serverAddress = serverAddress;
    return result;
  }

  ChatServiceConfig._();

  factory ChatServiceConfig.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChatServiceConfig.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatServiceConfig',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'chat'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serverAddress')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatServiceConfig clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatServiceConfig copyWith(void Function(ChatServiceConfig) updates) =>
      super.copyWith((message) => updates(message as ChatServiceConfig))
          as ChatServiceConfig;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatServiceConfig create() => ChatServiceConfig._();
  @$core.override
  ChatServiceConfig createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ChatServiceConfig getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatServiceConfig>(create);
  static ChatServiceConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get serverAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set serverAddress($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasServerAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearServerAddress() => $_clearField(1);
}

class JoinChannelRequest extends $pb.GeneratedMessage {
  factory JoinChannelRequest({
    $core.String? nick,
    $core.String? channelName,
  }) {
    final result = create();
    if (nick != null) result.nick = nick;
    if (channelName != null) result.channelName = channelName;
    return result;
  }

  JoinChannelRequest._();

  factory JoinChannelRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory JoinChannelRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JoinChannelRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'chat'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'nick')
    ..aOS(2, _omitFieldNames ? '' : 'channelName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinChannelRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinChannelRequest copyWith(void Function(JoinChannelRequest) updates) =>
      super.copyWith((message) => updates(message as JoinChannelRequest))
          as JoinChannelRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JoinChannelRequest create() => JoinChannelRequest._();
  @$core.override
  JoinChannelRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static JoinChannelRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<JoinChannelRequest>(create);
  static JoinChannelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get nick => $_getSZ(0);
  @$pb.TagNumber(1)
  set nick($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNick() => $_has(0);
  @$pb.TagNumber(1)
  void clearNick() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get channelName => $_getSZ(1);
  @$pb.TagNumber(2)
  set channelName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChannelName() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelName() => $_clearField(2);
}

class JoinChannelResponse extends $pb.GeneratedMessage {
  factory JoinChannelResponse({
    $core.String? topic,
    $core.Iterable<$core.String>? nick,
  }) {
    final result = create();
    if (topic != null) result.topic = topic;
    if (nick != null) result.nick.addAll(nick);
    return result;
  }

  JoinChannelResponse._();

  factory JoinChannelResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory JoinChannelResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JoinChannelResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'chat'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'topic')
    ..pPS(2, _omitFieldNames ? '' : 'nick')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinChannelResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinChannelResponse copyWith(void Function(JoinChannelResponse) updates) =>
      super.copyWith((message) => updates(message as JoinChannelResponse))
          as JoinChannelResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JoinChannelResponse create() => JoinChannelResponse._();
  @$core.override
  JoinChannelResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static JoinChannelResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<JoinChannelResponse>(create);
  static JoinChannelResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get topic => $_getSZ(0);
  @$pb.TagNumber(1)
  set topic($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTopic() => $_has(0);
  @$pb.TagNumber(1)
  void clearTopic() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get nick => $_getList(1);
}

class ObserveChannelRequest extends $pb.GeneratedMessage {
  factory ObserveChannelRequest({
    $core.String? channelName,
  }) {
    final result = create();
    if (channelName != null) result.channelName = channelName;
    return result;
  }

  ObserveChannelRequest._();

  factory ObserveChannelRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ObserveChannelRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ObserveChannelRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'chat'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ObserveChannelRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ObserveChannelRequest copyWith(
          void Function(ObserveChannelRequest) updates) =>
      super.copyWith((message) => updates(message as ObserveChannelRequest))
          as ObserveChannelRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ObserveChannelRequest create() => ObserveChannelRequest._();
  @$core.override
  ObserveChannelRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ObserveChannelRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ObserveChannelRequest>(create);
  static ObserveChannelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get channelName => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChannelName() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelName() => $_clearField(1);
}

class StreamStatusResponse extends $pb.GeneratedMessage {
  factory StreamStatusResponse({
    $core.int? count,
  }) {
    final result = create();
    if (count != null) result.count = count;
    return result;
  }

  StreamStatusResponse._();

  factory StreamStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StreamStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StreamStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'chat'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'count', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamStatusResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamStatusResponse copyWith(void Function(StreamStatusResponse) updates) =>
      super.copyWith((message) => updates(message as StreamStatusResponse))
          as StreamStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamStatusResponse create() => StreamStatusResponse._();
  @$core.override
  StreamStatusResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StreamStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StreamStatusResponse>(create);
  static StreamStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get count => $_getIZ(0);
  @$pb.TagNumber(1)
  set count($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearCount() => $_clearField(1);
}

enum InteractRequest_Type { nick, channelName, notSet }

class InteractRequest extends $pb.GeneratedMessage {
  factory InteractRequest({
    $core.String? nick,
    $core.String? channelName,
    $core.String? msg,
  }) {
    final result = create();
    if (nick != null) result.nick = nick;
    if (channelName != null) result.channelName = channelName;
    if (msg != null) result.msg = msg;
    return result;
  }

  InteractRequest._();

  factory InteractRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InteractRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, InteractRequest_Type>
      _InteractRequest_TypeByTag = {
    1: InteractRequest_Type.nick,
    2: InteractRequest_Type.channelName,
    0: InteractRequest_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InteractRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'chat'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOS(1, _omitFieldNames ? '' : 'nick')
    ..aOS(2, _omitFieldNames ? '' : 'channelName')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InteractRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InteractRequest copyWith(void Function(InteractRequest) updates) =>
      super.copyWith((message) => updates(message as InteractRequest))
          as InteractRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InteractRequest create() => InteractRequest._();
  @$core.override
  InteractRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InteractRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InteractRequest>(create);
  static InteractRequest? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  InteractRequest_Type whichType() =>
      _InteractRequest_TypeByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  void clearType() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get nick => $_getSZ(0);
  @$pb.TagNumber(1)
  set nick($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNick() => $_has(0);
  @$pb.TagNumber(1)
  void clearNick() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get channelName => $_getSZ(1);
  @$pb.TagNumber(2)
  set channelName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChannelName() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

class StatusMessage extends $pb.GeneratedMessage {
  factory StatusMessage({
    $core.String? nick,
    $core.String? status,
  }) {
    final result = create();
    if (nick != null) result.nick = nick;
    if (status != null) result.status = status;
    return result;
  }

  StatusMessage._();

  factory StatusMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StatusMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StatusMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'chat'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'nick')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatusMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatusMessage copyWith(void Function(StatusMessage) updates) =>
      super.copyWith((message) => updates(message as StatusMessage))
          as StatusMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StatusMessage create() => StatusMessage._();
  @$core.override
  StatusMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StatusMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StatusMessage>(create);
  static StatusMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get nick => $_getSZ(0);
  @$pb.TagNumber(1)
  set nick($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNick() => $_has(0);
  @$pb.TagNumber(1)
  void clearNick() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);
}

class NickMessage extends $pb.GeneratedMessage {
  factory NickMessage({
    $core.int? timeSec,
    $core.String? nick,
    $core.String? msg,
  }) {
    final result = create();
    if (timeSec != null) result.timeSec = timeSec;
    if (nick != null) result.nick = nick;
    if (msg != null) result.msg = msg;
    return result;
  }

  NickMessage._();

  factory NickMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NickMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NickMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'chat'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'timeSec')
    ..aOS(2, _omitFieldNames ? '' : 'nick')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NickMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NickMessage copyWith(void Function(NickMessage) updates) =>
      super.copyWith((message) => updates(message as NickMessage))
          as NickMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NickMessage create() => NickMessage._();
  @$core.override
  NickMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static NickMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NickMessage>(create);
  static NickMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get timeSec => $_getIZ(0);
  @$pb.TagNumber(1)
  set timeSec($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTimeSec() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimeSec() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get nick => $_getSZ(1);
  @$pb.TagNumber(2)
  set nick($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNick() => $_has(1);
  @$pb.TagNumber(2)
  void clearNick() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

/// Example Chat service.
class ChatApi {
  final $pb.RpcClient _client;

  ChatApi(this._client);

  /// Simple non-streaming request.
  $async.Future<JoinChannelResponse> joinChannel(
          $pb.ClientContext? ctx, JoinChannelRequest request) =>
      _client.invoke<JoinChannelResponse>(
          ctx, 'Chat', 'JoinChannel', request, JoinChannelResponse());

  /// Server-stream.
  $async.Future<NickMessage> observeChannel(
          $pb.ClientContext? ctx, ObserveChannelRequest request) =>
      _client.invoke<NickMessage>(
          ctx, 'Chat', 'ObserveChannel', request, NickMessage());

  /// Client-stream.
  $async.Future<StreamStatusResponse> sendStatus(
          $pb.ClientContext? ctx, StatusMessage request) =>
      _client.invoke<StreamStatusResponse>(
          ctx, 'Chat', 'SendStatus', request, StreamStatusResponse());

  /// BiDi stream.
  $async.Future<NickMessage> interact(
          $pb.ClientContext? ctx, InteractRequest request) =>
      _client.invoke<NickMessage>(
          ctx, 'Chat', 'Interact', request, NickMessage());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
