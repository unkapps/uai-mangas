import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:leitor_manga/category/category.dto.dart';

class Categories extends StatelessWidget {
  final List<CategoryDto> categories;

  const Categories({Key key, @required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(1),
        itemCount: categories.length,
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 5,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return OutlineButton(
            onPressed: () {},
            child: Text(
              categories[index].name,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ),
            ),
            borderSide: BorderSide(color: Colors.blue),
          );
        },
      ),
    );
  }
}
