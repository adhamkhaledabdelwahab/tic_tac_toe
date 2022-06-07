import 'dart:convert';

import 'history_model.dart';

class History {
  final List<HistoryModel> history;

  History({required this.history});

  History.fromJson(Map<String, dynamic> json)
      : history = (jsonDecode(json["history"]) as List<dynamic>)
            .map((e) => HistoryModel.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() =>
      {"history": jsonEncode(history.map((e) => e.toJson()).toList())};
}
