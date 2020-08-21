import 'package:leitor_manga/app/modules/core/pages/home/components/all_mangas/manga_sort.dart';

abstract class ISortableStore {
  MangaSortingChoice sortingChoice;

  void changeSorting(MangaSortingChoice sortingChoice);
}
