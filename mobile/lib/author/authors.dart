import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:leitor_manga/author/author.dto.dart';

class Authors extends StatelessWidget {
  final List<AuthorDto> authors;

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
        SizedBox(
          height: 15,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(1),
            itemCount: authors.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              var separator = index < authors.length -1 ? ' - ' : '';
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
