import 'package:mobx/mobx.dart';
import 'package:package_info/package_info.dart';

part 'version_store.g.dart';

class VersionStore = _VersionStoreBase with _$VersionStore;

abstract class _VersionStoreBase with Store {
  @observable
  String version = '';

  @observable
  int versionCode;

  _VersionStoreBase() {
    getVersion();
  }

  @computed
  bool get versionLoaded {
    return version != '';
  }

  @action
  Future<void> getVersion() async {
    var packageInfo = await PackageInfo.fromPlatform();

    version = packageInfo.version;
    versionCode = int.parse(packageInfo.buildNumber);
  }
}
