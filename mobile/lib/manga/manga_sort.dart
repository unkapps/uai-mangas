import 'package:flutter/material.dart';
import 'package:leitor_manga/shared/sort.dart';

typedef SortChanged = void Function(MangaSortingChoice value);

class MangaSort extends StatefulWidget {
  final SortChanged onSortChanged;
  final MangaSortingChoice initialSorting;

  final bool onSearch;

  MangaSort(
      {Key key,
      @required this.onSortChanged,
      @required this.initialSorting,
      this.onSearch = false})
      : super(key: key);

  @override
  _MangaSortState createState() => _MangaSortState();
}

class _MangaSortState extends State<MangaSort> {
  MangaSortingChoice _sortingChoice;

  @override
  void initState() {
    _sortingChoice = widget.initialSorting;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var values = widget.onSearch
        ? MangaSortingChoice.values
        : [MangaSortingChoice.NAME, MangaSortingChoice.NEW];

    return PopupMenuButton(
      child: Icon(Icons.sort),
      initialValue: _sortingChoice,
      itemBuilder: (context) {
        return values
            .map<PopupMenuItem<MangaSortingChoice>>((MangaSortingChoice value) {
          return PopupMenuItem<MangaSortingChoice>(
            value: value,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Opacity(
                    opacity: _sortingChoice == value ? 1 : 0,
                    child: Icon(Icons.done),
                  ),
                ),
                Text('${value.name}'),
              ],
            ),
          );
        }).toList();
      },
      onSelected: (MangaSortingChoice value) {
        if (_sortingChoice != value) {
          setState(() {
            _sortingChoice = value;
          });
          widget.onSortChanged(_sortingChoice);
        }
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

  Sort get sort {
    switch (this) {
      case MangaSortingChoice.NAME:
        return Sort('name', Direction.ASC);
      case MangaSortingChoice.NEW:
        return Sort('leitor_net_id', Direction.DESC);
      default:
        return null;
    }
  }
}
