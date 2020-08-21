import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:leitor_manga/app/shared/pageable/pageable_store_interface.dart';

class InfiniteScroll<T> extends StatefulWidget {
  final int length;
  final int limit;
  final Widget child;
  final Color color;

  final IPageableStore<T> pageableStore;

  InfiniteScroll({
    Key key,
    @required this.length,
    @required this.limit,
    @required this.child,
    @required this.pageableStore,
    this.color,
  })  : assert(child is ListView ? child.shrinkWrap == true : true),
        assert(child is GridView ? child.shrinkWrap == true : true),
        super(key: key);

  @override
  _InfiniteScrollState createState() => _InfiniteScrollState<T>();
}

class _InfiniteScrollState<T> extends State<InfiniteScroll<T>> {
  @override
  void initState() {
    widget.pageableStore.loadingMoreItems = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification.metrics.pixels >=
                  scrollNotification.metrics.maxScrollExtent - 50) {
                _loadMoreItems();
              }

              return false;
            },
            child: widget.child,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Observer(
              builder: (_) {
                return Visibility(
                  visible: widget.pageableStore.loadingMoreItems ||
                      widget.pageableStore.hasErrorOnGetMoreItems,
                  child: Container(
                    height: 20,
                    width: 20,
                    child: widget.pageableStore.loadingMoreItems
                        ? CircularProgressIndicator(
                            strokeWidth: 2.0,
                          )
                        : InkWell(
                            onTap: () {
                              _loadMoreItems();
                            },
                            child: Icon(
                              Icons.refresh,
                              color: widget.color,
                            ),
                          ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _loadMoreItems() {
    if ((!widget.pageableStore.loadingMoreItems ||
            widget.pageableStore.hasError) &&
        widget.length < widget.limit) {
      widget.pageableStore.loadingMoreItems = true;

      widget.pageableStore.loadMoreItems();
    }
  }
}
