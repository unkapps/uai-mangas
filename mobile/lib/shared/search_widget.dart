import 'dart:async';

import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget implements PreferredSizeWidget {
  final StreamController<String> streamController;
  final Color color;
  final VoidCallback onCancelSearch;
  final TextCapitalization textCapitalization;
  final String hintText;
  final double height;

  SearchWidget({
    @required this.streamController,
    @required this.onCancelSearch,
    @required this.height,
    this.color,
    this.textCapitalization,
    this.hintText,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    // to handle notches properly
    return SafeArea(
      top: true,
      child: GestureDetector(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildBackButton(),
                  _buildTextField(context),
                  _buildClearButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return StreamBuilder<String>(
      stream: streamController.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data?.isEmpty != false) {
          return Container();
        }
        return IconButton(
          icon: Icon(
            Icons.close,
            color: color,
          ),
          onPressed: () => {streamController.add('')},
        );
      },
    );
  }

  Widget _buildBackButton() {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: color),
      onPressed: onCancelSearch,
    );
  }

  Widget _buildTextField(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 13.0,
        ),
        child: StreamBuilder<String>(
          stream: streamController.stream,
          builder: (context, snapshot) {
            var controller = _getController(snapshot);
            return TextField(
              controller: controller,
              autofocus: true,
              cursorColor: Theme.of(context).accentColor,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 12.0),
                hintText: hintText,
              ),
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              style:
                  Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
              onChanged: (String value) => {streamController.add(value)},
            );
          },
        ),
      ),
    );
  }

  TextEditingController _getController(AsyncSnapshot<String> snapshot) {
    final controller = TextEditingController();
    controller.value = TextEditingValue(text: snapshot.data ?? '');
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text?.length ?? 0),
    );
    return controller;
  }
}
