import 'package:flutter/cupertino.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_model.dart';

abstract class IPageListView extends StatefulWidget {
  final ChapterSingleModel chapter;

  IPageListView({Key key, @required this.chapter}) : super(key: key);
}