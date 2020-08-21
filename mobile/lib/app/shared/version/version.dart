import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/shared/changelog/changelog_dialog.dart';
import 'package:leitor_manga/app/shared/version/version_store.dart';

class Version extends StatelessWidget {
  final versionStore = Modular.get<VersionStore>();

  Version({Key key}) : super(key: key);

  Widget _buildProgressBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 12,
        height: 12,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        var version = versionStore.version;
        return Row(
          children: <Widget>[
            InkWell(
              child: Text('Versão: $version'),
              onTap: () {
                ChangelogDialog.open(context);
              },
            ),
            versionStore.versionLoaded ?  Container() : _buildProgressBar(),
          ],
        );
      },
    );
  }
}
