import 'package:flutter/material.dart';

final _keyScaff = GlobalKey<ScaffoldState>();

BuildContext context;

Widget builder(BuildContext context, Widget child) {
  return Navigator(
    initialRoute: '/',
    onGenerateRoute: (_) => MaterialPageRoute(
      builder: (context) => _Builder(
        child: child,
      ),
    ),
  );
}

class _Builder extends StatelessWidget {
  final Widget child;

  const _Builder({@required this.child, Key key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    context = c;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _keyScaff,
      body: child,
    );
  }
}
