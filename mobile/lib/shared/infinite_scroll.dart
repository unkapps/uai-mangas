import 'package:flutter/material.dart';

typedef GetMoreItems<T> = Future<List<T>> Function();
typedef NewItemsReceived<T> = void Function(List<T>);

class InfiniteScroll<T> extends StatefulWidget {
  final int length;
  final int limit;
  final Widget child;
  final GetMoreItems<T> getMoreItems;
  final Color color;

  final NewItemsReceived<T> onNewItemsReceived;

  InfiniteScroll({
    Key key,
    @required this.length,
    @required this.limit,
    @required this.child,
    @required this.getMoreItems,
    @required this.onNewItemsReceived,
    this.color,
  })  : assert(child is ListView ? child.shrinkWrap == true : true),
        assert(child is GridView ? child.shrinkWrap == true : true),
        super(key: key);

  @override
  _InfiniteScrollState createState() => _InfiniteScrollState<T>();
}

class _InfiniteScrollState<T> extends State<InfiniteScroll<T>> {
  LoadStatus _status;

  @override
  void initState() {
    _status = LoadStatus.LOADED;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if ( scrollNotification.metrics.pixels >=
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
            child: Visibility(
              visible: _status == LoadStatus.IN_PROGRESS ||
                  _status == LoadStatus.ERROR,
              child: Container(
                height: 20,
                width: 20,
                child: _status == LoadStatus.IN_PROGRESS
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
            ),
          ),
        ),
      ],
    );
  }

  void _loadMoreItems() {
    if ((_status == LoadStatus.LOADED || _status == LoadStatus.ERROR) && widget.length < widget.limit) {
      setState(() {
        _status = LoadStatus.IN_PROGRESS;
      });

      widget.getMoreItems().then((newItems) {
        widget.onNewItemsReceived(newItems);
        setState(() {
          _status = LoadStatus.LOADED;
        });
      }).catchError((_) {
        setState(() {
          _status = LoadStatus.ERROR;
        });
      });
    }
  }
}

enum LoadStatus {
  LOADED,
  IN_PROGRESS,
  ERROR,
}
