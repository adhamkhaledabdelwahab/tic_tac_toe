class HistoryModel {
  final String date;
  final bool isTwoPlayer;
  final String winner;

  HistoryModel(
      {required this.date, required this.isTwoPlayer, required this.winner});

  HistoryModel.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        isTwoPlayer = json['isTwoPlayer'],
        winner = json['winner'];

  Map<String, dynamic> toJson() =>
      {'date': date, 'isTwoPlayer': isTwoPlayer, 'winner': winner};
}
