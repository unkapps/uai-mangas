import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:leitor_manga/app/modules/core/pages/home/home_controller.dart';

class SearchWidget extends StatelessWidget implements PreferredSizeWidget {
  final Color color;
  final VoidCallback onCancelSearch;
  final TextCapitalization textCapitalization;
  final String hintText;
  final double height;
  final HomeController homeController;

  SearchWidget({
    @required this.onCancelSearch,
    @required this.height,
    @required this.homeController,
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
    return Observer(
      builder: (_) {
        if (homeController.query?.isEmpty != false) {
          return Container();
        }
        return IconButton(
          icon: Icon(
            Icons.close,
            color: color,
          ),
          onPressed: () => {homeController.setQuery('')},
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
        child: Observer(
          builder: (_) {
            var controller = _getController();
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
              onChanged: homeController.setQuery,
            );
          },
        ),
      ),
    );
  }

  TextEditingController _getController() {
    final controller = TextEditingController();
    controller.value = TextEditingValue(text: homeController.query ?? '');
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text?.length ?? 0),
    );
    return controller;
  }
}
