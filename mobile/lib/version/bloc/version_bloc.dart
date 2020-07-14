import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:package_info/package_info.dart';

part 'version_event.dart';
part 'version_state.dart';

class VersionBloc extends Bloc<VersionEvent, VersionState> {
  VersionBloc() : super(VersionUnloaded());

  @override
  Stream<VersionState> mapEventToState(
    VersionEvent event,
  ) async* {
    var packageInfo = await PackageInfo.fromPlatform();
    yield VersionLoaded(packageInfo.version);
  }
}
