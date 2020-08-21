import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_model.dart';

class ChapterNavigationDialog extends StatefulWidget {
  final ChapterSingleModel chapter;

  ChapterNavigationDialog(this.chapter, {Key key}) : super(key: key);

  @override
  _ChapterNavigationDialogState createState() =>
      _ChapterNavigationDialogState();
}

class _ChapterNavigationDialogState extends State<ChapterNavigationDialog> {
  final textController = TextEditingController();
  bool valid;
  bool touched;

  _ChapterNavigationDialogState();

  @override
  void initState() {
    valid = false;
    touched = false;

    textController.addListener(() {
      setState(() {
        if (!touched && textController.text.isNotEmpty) {
          touched = true;
        }
        valid = _pageStrValid(textController.text);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: const Text('Navegar para página'),
        scrollable: true,
        content: ListBody(
          children: <Widget>[
            TextField(
              controller: textController,
              autofocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                labelText: 'Página',
                errorText: !valid && touched ? 'Página inválida' : null,
              ),
              onSubmitted: (String value) async {
                if (value != '') {
                  var choisedPage = int.parse(value);
                  if (_pageValid(choisedPage)) {
                    Navigator.pop(context, choisedPage);
                  }
                }
              },
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Ir'),
            onPressed: valid
                ? () {
                    Navigator.pop(context, int.parse(textController.text));
                  }
                : null,
          ),
        ],
        buttonPadding: EdgeInsets.zero,
      ),
    );
  }

  bool _pageValid(int pageNumber) {
    return pageNumber > 0 && pageNumber <= widget.chapter.pages.length;
  }

  bool _pageStrValid(String pageNumber) {
    if (pageNumber == '') {
      return false;
    }

    return _pageValid(int.parse(pageNumber));
  }
}
