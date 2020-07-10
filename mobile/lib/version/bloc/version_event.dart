part of 'version_bloc.dart';

@immutable
abstract class VersionEvent {}

class LoadVersionEvent extends VersionEvent {}