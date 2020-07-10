part of 'version_bloc.dart';

@immutable
abstract class VersionState {}

class VersionUnloaded extends VersionState {
  @override
  String toString() => 'VersionUnloaded';
}

class VersionLoaded extends VersionState {
  final String version;

  VersionLoaded(this.version);

  @override
  String toString() => 'VersionLoaded';
}
