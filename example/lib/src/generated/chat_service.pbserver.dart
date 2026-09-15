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

import 'chat_service.pb.dart' as $0;
import 'chat_service.pbjson.dart';

export 'chat_service.pb.dart';

abstract class ChatServiceBase extends $pb.GeneratedService {
  $async.Future<$0.JoinChannelResponse> joinChannel(
      $pb.ServerContext ctx, $0.JoinChannelRequest request);
  $async.Future<$0.NickMessage> observeChannel(
      $pb.ServerContext ctx, $0.ObserveChannelRequest request);
  $async.Future<$0.StreamStatusResponse> sendStatus(
      $pb.ServerContext ctx, $0.StatusMessage request);
  $async.Future<$0.NickMessage> interact(
      $pb.ServerContext ctx, $0.InteractRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'JoinChannel':
        return $0.JoinChannelRequest();
      case 'ObserveChannel':
        return $0.ObserveChannelRequest();
      case 'SendStatus':
        return $0.StatusMessage();
      case 'Interact':
        return $0.InteractRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'JoinChannel':
        return joinChannel(ctx, request as $0.JoinChannelRequest);
      case 'ObserveChannel':
        return observeChannel(ctx, request as $0.ObserveChannelRequest);
      case 'SendStatus':
        return sendStatus(ctx, request as $0.StatusMessage);
      case 'Interact':
        return interact(ctx, request as $0.InteractRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => ChatServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => ChatServiceBase$messageJson;
}
