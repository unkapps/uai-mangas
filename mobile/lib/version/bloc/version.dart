import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:leitor_manga/version/bloc/version_bloc.dart';

class Version extends StatelessWidget {
  const Version({Key key}) : super(key: key);

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
    return BlocBuilder<VersionBloc, VersionState>(
      builder: (BuildContext context, VersionState state) {
        var version = state is VersionLoaded ? state.version : '';
        return Row(
          children: <Widget>[
            Text('Versão: $version'),
            state is VersionUnloaded ? _buildProgressBar() : Container(),
          ],
        );
      },
    );
  }
}
