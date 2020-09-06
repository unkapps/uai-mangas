import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/author/author_model.dart';

class Authors extends StatelessWidget {
  final List<AuthorModel> authors;

  const Authors({Key key, @required this.authors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 12,
    );
    return Row(
      children: <Widget>[
        Text(
          'Por: ',
          style: style,
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(1),
            itemCount: authors.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              var separator = index < authors.length - 1 ? ' - ' : '';
              return InkWell(
                onTap: () {},
                child: Text(
                  '${authors[index].getNameDescribingIfArtist()}$separator',
                  style: style,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
