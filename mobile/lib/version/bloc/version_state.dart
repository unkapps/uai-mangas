part of 'version_bloc.dart';

@immutable
abstract class VersionState {}

class VersionUnloaded extends VersionState {
  @override
  String toString() => 'VersionUnloaded';
}

class VersionLoaded extends VersionState {
  final String version;
  final int versionCode;

  VersionLoaded(this.version, this.versionCode);

  @override
  String toString() => 'VersionLoaded';
}
