import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  bool searchMode = false;

  @observable
  String query = '';

  @action
  void setSearchMode(searchMode) {
    this.searchMode = searchMode;
  }

  @action
  void setQuery(query) {
    this.query = query;
  }
}
