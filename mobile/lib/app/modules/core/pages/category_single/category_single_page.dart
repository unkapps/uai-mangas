import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/pages/category_single/category_single_controller.dart';
import 'package:leitor_manga/app/modules/core/pages/home/components/all_mangas/all_mangas.dart';

class CategorySinglePage extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  CategorySinglePage({
    Key key,
    @required this.categoryId,
    @required this.categoryName,
  }) : super(key: key);

  @override
  _CategorySinglePageState createState() => _CategorySinglePageState();
}

class _CategorySinglePageState
    extends ModularState<CategorySinglePage, CategorySingleController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: Container(
        child: AllMangas(
          categoryId: widget.categoryId,
        ),
      ),
    );
  }
}
