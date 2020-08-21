import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:leitor_manga/app/modules/core/pages/home/components/search/app_bar_painter.dart';
import 'dart:math';

import 'package:leitor_manga/app/modules/core/pages/home/components/search/search_widget.dart';
import 'package:leitor_manga/app/modules/core/pages/home/home_controller.dart';

typedef SearchModeChanged = void Function(bool searchMode);

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final int searchButtonPosition;
  final HomeController homeController;

  SearchAppBar({
    Key key,
    @required this.appBar,
    @required this.homeController,
    int searchButtonPosition,
  })  : searchButtonPosition = (searchButtonPosition != null &&
                (0 <= searchButtonPosition &&
                    searchButtonPosition <= appBar.actions.length))
            ? searchButtonPosition
            : max(appBar.actions?.length ?? 0, 0),
        super(key: key);

  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  @override
  Size get preferredSize =>
      Size(appBar.preferredSize.width, appBar.preferredSize.height + 5);
}

class _SearchAppBarState extends State<SearchAppBar>
    with SingleTickerProviderStateMixin<SearchAppBar> {
  double _rippleStartX, _rippleStartY;
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    SchedulerBinding.instance.scheduleFrameCallback((_) {
      widget.homeController.setSearchMode(false);
    });

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    super.initState();
  }

  Future<bool> _onWillPop() async {
    if (widget.homeController.searchMode) {
      _cancelSearch();
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return WillPopScope(
          onWillPop: () => _onWillPop(),
          child: Stack(
            children: <Widget>[
              _buildAppBar(context),
              _buildAnimation(context),
              _buildSearch(context),
            ],
          ),
        );
      },
    );
  }

  void onSearchTapUp(TapUpDetails details) {
    _rippleStartX = details.globalPosition.dx;
    _rippleStartY = details.globalPosition.dy;
    _controller.forward();

    widget.homeController.setSearchMode(true);
  }

  Widget _buildSearchButton(BuildContext context) {
    return GestureDetector(
      child: IconButton(
        onPressed: null,
        icon: Icon(
          Icons.search,
          color: widget.appBar.iconTheme?.color ??
              Theme.of(context).iconTheme.color,
        ),
      ),
      onTapUp: onSearchTapUp,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final searchButton = _buildSearchButton(context);
    final actions = <Widget>[];

    if (widget.appBar.actions != null) {
      actions.addAll(widget.appBar.actions);
    }

    actions.insert(widget.searchButtonPosition, searchButton);

    return AppBar(
      title: widget.homeController.searchMode ? null : widget.appBar.title,
      bottom: widget.homeController.searchMode ? null : widget.appBar.bottom,
      backgroundColor: widget.appBar.backgroundColor,
      iconTheme: widget.appBar.iconTheme,
      elevation: widget.appBar.elevation,
      centerTitle: widget.appBar.centerTitle,
      actions: actions,
      leading: widget.appBar.leading,
      automaticallyImplyLeading: widget.appBar.automaticallyImplyLeading,
      flexibleSpace: widget.appBar.flexibleSpace,
      shape: widget.appBar.shape,
      brightness: widget.appBar.brightness,
      actionsIconTheme: widget.appBar.actionsIconTheme,
      textTheme: widget.appBar.textTheme,
      primary: widget.appBar.primary,
      excludeHeaderSemantics: widget.appBar.excludeHeaderSemantics,
      titleSpacing: widget.appBar.titleSpacing,
      toolbarOpacity: widget.appBar.toolbarOpacity,
      bottomOpacity: widget.appBar.bottomOpacity,
    );
  }

  AnimatedBuilder _buildAnimation(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: AppBarPainter(
            containerHeight: widget.preferredSize.height,
            center: Offset(_rippleStartX ?? 0, _rippleStartY ?? 0),
            // increase radius in % from 0% to 100% of screenWidth
            radius: _animation.value * MediaQuery.of(context).size.width,
            context: context,
            color: Theme.of(context).canvasColor,
          ),
        );
      },
    );
  }

  Widget _buildSearch(BuildContext context) {
    if (widget.homeController.searchMode) {
      return SearchWidget(
        height: widget.preferredSize.height,
        homeController: widget.homeController,
        color: Theme.of(context).iconTheme.color,
        onCancelSearch: () {
          _cancelSearch();
        },
      );
    }

    return Container();
  }

  void _cancelSearch() {
    widget.homeController.setQuery(null);
    _controller.reverse();
    widget.homeController.setSearchMode(false);
  }
}
