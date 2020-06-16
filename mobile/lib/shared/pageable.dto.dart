import 'package:flutter/foundation.dart';

typedef ItemCreator<T> = T Function(dynamic jsonPage);

class PageableDto<T> {
  List<T> data;
  int qtyPages;

  PageableDto({
    @required this.data,
    @required this.qtyPages,
  });

  factory PageableDto.fromJson(Map<String, dynamic> json, ItemCreator<List<T>> creator) {
    return PageableDto<T>(
      data: creator(json['data'] as dynamic),
      qtyPages: json['qtyPages'] as int,
    );
  }
}
