import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:leitor_manga/page/manga_page_vertical_list_view.dart';
import 'package:leitor_manga/page/page.dto.dart';
import 'package:leitor_manga/page/page.service.dart';

class MangaPage extends StatefulWidget {
  MangaPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MangaPageState createState() => _MangaPageState();
}

class _MangaPageState extends State<MangaPage> {
  PageService service = PageService();

  var currentPage = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: service.getPages(),
        builder: (BuildContext context, AsyncSnapshot<List<PageDto>> snapshot) {
          if (snapshot.hasData) {
            List<PageDto> pages = snapshot.data;

            return Stack(children: <Widget>[
              MangaPageVerticalListView(
                pages,
                onPageChange: (pageNumber) {
                  setState(() {
                    currentPage = pageNumber + 1;
                  });
                },
              ),
              Positioned(
                bottom: 0,
                child: Opacity(
                  opacity: 0.8,
                  child: Container(
                    color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          '$currentPage/${pages.length}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
