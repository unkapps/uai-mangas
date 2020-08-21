import 'package:flutter/foundation.dart';

class ChapterListModel {
  final int id;
  final String number;
  final DateTime date;
  final bool readed;

  ChapterListModel({
    @required this.id,
    @required this.number,
    this.date,
    this.readed,
  });

  factory ChapterListModel.fromJson(Map<String, dynamic> json) {
    return ChapterListModel(
      id: json['id'] as int,
      number: json['number'] as String,
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
      readed: (json['readed'] as String == '1'),
    );
  }
}
