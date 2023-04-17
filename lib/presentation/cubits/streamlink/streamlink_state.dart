// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'streamlink_cubit.dart';

abstract class StreamlinkState {}

class StreamlinkInitial extends StreamlinkState {}

class StreamlinkLoaded extends StreamlinkState {
  final StreamLinkEntity streamLink;
  final String id;
  StreamlinkLoaded({
    required this.streamLink,
    required this.id,
  });
}

class StreamlinkLoading extends StreamlinkState {}

class StreamlinkError extends StreamlinkState {
  final String msg;
  StreamlinkError({
    required this.msg,
  });
}
