import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/pages/home/components/category_list/category_list_store.dart';
import 'package:leitor_manga/app/modules/core/routes.dart';
import 'package:mobx/mobx.dart';

class CategoryList extends StatelessWidget {
  final categoriesStore = Modular.get<CategoriesStore>();

  CategoryList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      child: Observer(
        builder: (_) {
          if (categoriesStore.categories.status == FutureStatus.pending) {
            return Center(child: CircularProgressIndicator());
          }

          if (categoriesStore.categories.status == FutureStatus.rejected) {
            return InkWell(
              child: Center(
                child: Text('Erro! Clique para tentar novamente.'),
              ),
              onTap: () {
                categoriesStore.load();
              },
            );
          }

          if (categoriesStore.categories.status == FutureStatus.fulfilled) {
            var categories = categoriesStore.categories.value;

            return GridView.builder(
              shrinkWrap: true,
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                var category = categories[index];
                return OutlineButton(
                  child: Text(
                    '${category.name}',
                    textAlign: TextAlign.center,
                  ),
                  highlightedBorderColor: theme.accentColor,
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
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
