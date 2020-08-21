import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart' show rootBundle;

class ChangelogDialog {
  static Future<void> open(BuildContext context) async {
    var contentFuture = rootBundle.loadString('assets/md/CHANGELOG.md');

    var size = MediaQuery.of(context).size;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Changelog'),
          content: Container(
            width: size.width,
            height: size.height / 2,
            child: FutureBuilder<String>(
              future: contentFuture,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Markdown(data: snapshot.data);
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
