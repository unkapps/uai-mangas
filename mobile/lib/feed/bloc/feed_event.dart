part of 'feed_bloc.dart';

@immutable
abstract class FeedEvent {}

class LoadFeedEvent extends FeedEvent {
  LoadFeedEvent();

  @override
  String toString() => 'LoadFeedEvent';
}

class UnauthenticatedFeedEvent extends FeedEvent {
  UnauthenticatedFeedEvent();

  @override
  String toString() => 'UnauthenticatedFeedEvent';
}
