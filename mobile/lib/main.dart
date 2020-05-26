import 'package:flutter/material.dart';
import 'package:leitor_manga/page/manga_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MangaPage(title: 'Flutter Demo Home Page'),
    );
  }
}
