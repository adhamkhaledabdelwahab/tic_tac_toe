import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/History.dart';
import 'package:tic_tac_toe/game_logic.dart';
import 'package:tic_tac_toe/shared_preference_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key, required this.history}) : super(key: key);

  final History history;

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                setState(() {
                  widget.history.history.clear();
                });
                SharedPreferenceService.saveHistory(
                    jsonEncode(History(history: [])));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.white,
                    content: const Text(
                      "Game History Cleared",
                      style: TextStyle(fontSize: 20),
                    ),
                    action: SnackBarAction(
                        label: "Close",
                        onPressed: () => ScaffoldMessenger.of(context)
                            .hideCurrentSnackBar(
                                reason: SnackBarClosedReason.dismiss)),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Tooltip(
                  message: "Clear History",
                  waitDuration: Duration(seconds: 1),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
        title: const Text("Tic Tac Toe History"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: widget.history.history.length,
            itemBuilder: (crx, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).splashColor,
                ),
                child: Column(
                  children: [
                    Text(
                      widget.history.history.elementAt(index).winner != "draw"
                          ? widget.history.history.elementAt(index).isTwoPlayer
                              ? "Player ${widget.history.history.elementAt(index).winner} wins the game"
                              : widget.history.history
                                          .elementAt(index)
                                          .winner ==
                                      Player.x
                                  ? "Human wins the game"
                                  : "Machine wins the game"
                          : "Game is Draw",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "date: ${widget.history.history.elementAt(index).date}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
