import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:leitor_manga/app/modules/core/pages/home/components/all_mangas/sortable_store_interface.dart';
import 'package:leitor_manga/app/shared/sort_model.dart';

typedef SortChanged = void Function(MangaSortingChoice value);

class MangaSort extends StatelessWidget {
  final ISortableStore sortableStore;

  final bool onSearch;

  MangaSort({Key key, @required this.sortableStore, this.onSearch = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var values = onSearch
        ? MangaSortingChoice.values
        : [MangaSortingChoice.NAME, MangaSortingChoice.NEW];

    return Observer(
      builder: (_) {
        return PopupMenuButton(
          child: Icon(Icons.sort),
          initialValue: sortableStore.sortingChoice,
          itemBuilder: (context) {
            return values.map<PopupMenuItem<MangaSortingChoice>>(
                (MangaSortingChoice value) {
              return PopupMenuItem<MangaSortingChoice>(
                value: value,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Opacity(
                        opacity: sortableStore.sortingChoice == value ? 1 : 0,
                        child: Icon(Icons.done),
                      ),
                    ),
                    Text('${value.name}'),
                  ],
                ),
              );
            }).toList();
          },
          onSelected: sortableStore.changeSorting,
        );
      },
    );
  }
}

enum MangaSortingChoice {
  NAME,
  NEW,
  RELEVANCE,
}

extension MangaSortingChoiceExtension on MangaSortingChoice {
  String get name {
    switch (this) {
      case MangaSortingChoice.NAME:
        return 'Nome';
      case MangaSortingChoice.NEW:
        return 'Novo';
      case MangaSortingChoice.RELEVANCE:
        return 'Relevancia';
      default:
        return null;
    }
  }

  SortModel get sort {
    switch (this) {
      case MangaSortingChoice.NAME:
        return SortModel('name', Direction.ASC);
      case MangaSortingChoice.NEW:
        return SortModel('leitor_net_id', Direction.DESC);
      default:
        return null;
    }
  }
}
