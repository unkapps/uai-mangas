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

            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];

                return Container(
                    child: ListTile(
                      title: Text(category.name),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
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
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: theme.cardColor))));
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
