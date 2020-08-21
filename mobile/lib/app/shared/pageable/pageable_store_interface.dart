import 'package:mobx/mobx.dart';

abstract class IPageableStore<T> {
  ObservableList<T> items;

  int qtyPages;

  Object error;

  bool loading;

  Object errorOnGetMoreItems;

  bool loadingMoreItems;

  bool get hasError;

  bool get hasErrorOnGetMoreItems;

  void loadItems();

  void loadMoreItems();
}
