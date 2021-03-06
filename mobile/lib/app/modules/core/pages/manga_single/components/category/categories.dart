import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/category/category_model.dart';
import 'package:leitor_manga/app/modules/core/routes.dart';

class Categories extends StatelessWidget {
  final List<CategoryModel> categories;

  const Categories({Key key, @required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(1),
        itemCount: categories.length,
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 5,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          var category = categories[index];

          return OutlineButton(
            onPressed: () {
              Modular.link.pushNamed(Routes.CATEGORY_SINGLE
                  .replaceAll(
                    ':categoryId',
                    category.id.toString(),
                  )
                  .replaceAll(
                    ':categoryName',
                    category.name,
                  ));
            },
            child: Text(
              category.name,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ),
            ),
            borderSide: BorderSide(color: theme.accentColor),
          );
        },
      ),
    );
  }
}
