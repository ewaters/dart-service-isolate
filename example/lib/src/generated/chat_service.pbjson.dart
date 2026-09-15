// This is a generated file - do not edit.
//
// Generated from chat_service.proto.

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

@$core.Deprecated('Use chatServiceConfigDescriptor instead')
const ChatServiceConfig$json = {
  '1': 'ChatServiceConfig',
  '2': [
    {'1': 'server_address', '3': 1, '4': 1, '5': 9, '10': 'serverAddress'},
  ],
};

/// Descriptor for `ChatServiceConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatServiceConfigDescriptor = $convert.base64Decode(
    'ChFDaGF0U2VydmljZUNvbmZpZxIlCg5zZXJ2ZXJfYWRkcmVzcxgBIAEoCVINc2VydmVyQWRkcm'
    'Vzcw==');

@$core.Deprecated('Use joinChannelRequestDescriptor instead')
const JoinChannelRequest$json = {
  '1': 'JoinChannelRequest',
  '2': [
    {'1': 'nick', '3': 1, '4': 1, '5': 9, '10': 'nick'},
    {'1': 'channel_name', '3': 2, '4': 1, '5': 9, '10': 'channelName'},
  ],
};

/// Descriptor for `JoinChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinChannelRequestDescriptor = $convert.base64Decode(
    'ChJKb2luQ2hhbm5lbFJlcXVlc3QSEgoEbmljaxgBIAEoCVIEbmljaxIhCgxjaGFubmVsX25hbW'
    'UYAiABKAlSC2NoYW5uZWxOYW1l');

@$core.Deprecated('Use joinChannelResponseDescriptor instead')
const JoinChannelResponse$json = {
  '1': 'JoinChannelResponse',
  '2': [
    {'1': 'topic', '3': 1, '4': 1, '5': 9, '10': 'topic'},
    {'1': 'nick', '3': 2, '4': 3, '5': 9, '10': 'nick'},
  ],
};

/// Descriptor for `JoinChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinChannelResponseDescriptor = $convert.base64Decode(
    'ChNKb2luQ2hhbm5lbFJlc3BvbnNlEhQKBXRvcGljGAEgASgJUgV0b3BpYxISCgRuaWNrGAIgAy'
    'gJUgRuaWNr');

@$core.Deprecated('Use observeChannelRequestDescriptor instead')
const ObserveChannelRequest$json = {
  '1': 'ObserveChannelRequest',
  '2': [
    {'1': 'channel_name', '3': 1, '4': 1, '5': 9, '10': 'channelName'},
  ],
};

/// Descriptor for `ObserveChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List observeChannelRequestDescriptor = $convert.base64Decode(
    'ChVPYnNlcnZlQ2hhbm5lbFJlcXVlc3QSIQoMY2hhbm5lbF9uYW1lGAEgASgJUgtjaGFubmVsTm'
    'FtZQ==');

@$core.Deprecated('Use streamStatusResponseDescriptor instead')
const StreamStatusResponse$json = {
  '1': 'StreamStatusResponse',
  '2': [
    {'1': 'count', '3': 1, '4': 1, '5': 13, '10': 'count'},
  ],
};

/// Descriptor for `StreamStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamStatusResponseDescriptor =
    $convert.base64Decode(
        'ChRTdHJlYW1TdGF0dXNSZXNwb25zZRIUCgVjb3VudBgBIAEoDVIFY291bnQ=');

@$core.Deprecated('Use interactRequestDescriptor instead')
const InteractRequest$json = {
  '1': 'InteractRequest',
  '2': [
    {'1': 'nick', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'nick'},
    {'1': 'channel_name', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'channelName'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
  '8': [
    {'1': 'type'},
  ],
};

/// Descriptor for `InteractRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List interactRequestDescriptor = $convert.base64Decode(
    'Cg9JbnRlcmFjdFJlcXVlc3QSFAoEbmljaxgBIAEoCUgAUgRuaWNrEiMKDGNoYW5uZWxfbmFtZR'
    'gCIAEoCUgAUgtjaGFubmVsTmFtZRIQCgNtc2cYAyABKAlSA21zZ0IGCgR0eXBl');

@$core.Deprecated('Use statusMessageDescriptor instead')
const StatusMessage$json = {
  '1': 'StatusMessage',
  '2': [
    {'1': 'nick', '3': 1, '4': 1, '5': 9, '10': 'nick'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `StatusMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statusMessageDescriptor = $convert.base64Decode(
    'Cg1TdGF0dXNNZXNzYWdlEhIKBG5pY2sYASABKAlSBG5pY2sSFgoGc3RhdHVzGAIgASgJUgZzdG'
    'F0dXM=');

@$core.Deprecated('Use nickMessageDescriptor instead')
const NickMessage$json = {
  '1': 'NickMessage',
  '2': [
    {'1': 'time_sec', '3': 1, '4': 1, '5': 5, '10': 'timeSec'},
    {'1': 'nick', '3': 2, '4': 1, '5': 9, '10': 'nick'},
    {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
  ],
};

/// Descriptor for `NickMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nickMessageDescriptor = $convert.base64Decode(
    'CgtOaWNrTWVzc2FnZRIZCgh0aW1lX3NlYxgBIAEoBVIHdGltZVNlYxISCgRuaWNrGAIgASgJUg'
    'RuaWNrEhAKA21zZxgDIAEoCVIDbXNn');

const $core.Map<$core.String, $core.dynamic> ChatServiceBase$json = {
  '1': 'Chat',
  '2': [
    {
      '1': 'JoinChannel',
      '2': '.chat.JoinChannelRequest',
      '3': '.chat.JoinChannelResponse'
    },
    {
      '1': 'ObserveChannel',
      '2': '.chat.ObserveChannelRequest',
      '3': '.chat.NickMessage',
      '6': true
    },
    {
      '1': 'SendStatus',
      '2': '.chat.StatusMessage',
      '3': '.chat.StreamStatusResponse',
      '5': true
    },
    {
      '1': 'Interact',
      '2': '.chat.InteractRequest',
      '3': '.chat.NickMessage',
      '5': true,
      '6': true
    },
  ],
};

@$core.Deprecated('Use chatServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    ChatServiceBase$messageJson = {
  '.chat.JoinChannelRequest': JoinChannelRequest$json,
  '.chat.JoinChannelResponse': JoinChannelResponse$json,
  '.chat.ObserveChannelRequest': ObserveChannelRequest$json,
  '.chat.NickMessage': NickMessage$json,
  '.chat.StatusMessage': StatusMessage$json,
  '.chat.StreamStatusResponse': StreamStatusResponse$json,
  '.chat.InteractRequest': InteractRequest$json,
};

/// Descriptor for `Chat`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List chatServiceDescriptor = $convert.base64Decode(
    'CgRDaGF0EkIKC0pvaW5DaGFubmVsEhguY2hhdC5Kb2luQ2hhbm5lbFJlcXVlc3QaGS5jaGF0Lk'
    'pvaW5DaGFubmVsUmVzcG9uc2USQgoOT2JzZXJ2ZUNoYW5uZWwSGy5jaGF0Lk9ic2VydmVDaGFu'
    'bmVsUmVxdWVzdBoRLmNoYXQuTmlja01lc3NhZ2UwARI/CgpTZW5kU3RhdHVzEhMuY2hhdC5TdG'
    'F0dXNNZXNzYWdlGhouY2hhdC5TdHJlYW1TdGF0dXNSZXNwb25zZSgBEjgKCEludGVyYWN0EhUu'
    'Y2hhdC5JbnRlcmFjdFJlcXVlc3QaES5jaGF0Lk5pY2tNZXNzYWdlKAEwAQ==');
