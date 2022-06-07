import 'dart:math';

/// player class contains player name and its chosen play squares
class Player {
  static const x = 'X';
  static const o = 'O';
  static const empty = '';

  static List<int> playerX = [];
  static List<int> playerO = [];
}

/// recreate containsAll method to take 2 or 3 items to test if exists in list
extension ContainsAll on List {
  containsAll(int x, int y, [z]) {
    return z != null
        ? contains(x) && contains(y) && contains(z)
        : contains(x) && contains(y);
  }
}

/// game class for all game actions and logic
class Game {
  /// play game taking index of required square to be obtained and current active player
  playGame({required int index, required String activePlayer}) {
    if (activePlayer == Player.x) {
      Player.playerX.add(index);
    } else {
      Player.playerO.add(index);
    }
  }

  /// check winner if it is X or O or draw
  checkWinner() {
    String winner = '';
    if (Player.playerX.containsAll(0, 1, 2) ||
        Player.playerX.containsAll(3, 4, 5) ||
        Player.playerX.containsAll(6, 7, 8) ||
        Player.playerX.containsAll(0, 3, 6) ||
        Player.playerX.containsAll(1, 4, 7) ||
        Player.playerX.containsAll(2, 5, 8) ||
        Player.playerX.containsAll(0, 4, 8) ||
        Player.playerX.containsAll(2, 4, 6)) {
      winner = Player.x;
    } else if (Player.playerO.containsAll(0, 1, 2) ||
        Player.playerO.containsAll(3, 4, 5) ||
        Player.playerO.containsAll(6, 7, 8) ||
        Player.playerO.containsAll(0, 3, 6) ||
        Player.playerO.containsAll(1, 4, 7) ||
        Player.playerO.containsAll(2, 5, 8) ||
        Player.playerO.containsAll(0, 4, 8) ||
        Player.playerO.containsAll(2, 4, 6)) {
      winner = Player.o;
    } else {
      winner = Player.empty;
    }
    return winner;
  }

  /// autoplay method perform and acts as a real player but machine is the one
  Future<void> autoPlay({required String activePlayer}) async {
    int index = 0;
    List<int> emptyCells = [];

    /// retrieve all empty play squares
    for (int i = 0; i < 9; i++) {
      if (!Player.playerX.contains(i) && !Player.playerO.contains(i)) {
        emptyCells.add(i);
      }
    }

    /// attack
    ///*********************************
    /// (0,1,2)
    if (Player.playerO.containsAll(0, 1) && emptyCells.contains(2)) {
      index = 2;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerO.containsAll(0, 2) && emptyCells.contains(1)) {
      index = 1;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerO.containsAll(1, 2) && emptyCells.contains(0)) {
      index = 0;
      playGame(index: index, activePlayer: activePlayer);
    }

    /// (3,4,5)
    else if (Player.playerO.containsAll(3, 4) && emptyCells.contains(5)) {
      index = 5;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerO.containsAll(3, 5) && emptyCells.contains(4)) {
      index = 4;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerO.containsAll(4, 5) && emptyCells.contains(3)) {
      index = 3;
      playGame(index: index, activePlayer: activePlayer);
    }

    /// (6,7,8)
    else if (Player.playerO.containsAll(6, 7) && emptyCells.contains(8)) {
      index = 8;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerO.containsAll(6, 8) && emptyCells.contains(7)) {
      index = 7;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerO.containsAll(7, 8) && emptyCells.contains(6)) {
      index = 6;
      playGame(index: index, activePlayer: activePlayer);
    }

    /// (0,3,6)
    else if (Player.playerO.containsAll(0, 3) && emptyCells.contains(6)) {
      index = 6;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerO.containsAll(0, 6) && emptyCells.contains(3)) {
      index = 3;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerO.containsAll(3, 6) && emptyCells.contains(0)) {
      index = 0;
      playGame(index: index, activePlayer: activePlayer);
    }

    /// (1,4,7)
    else if (Player.playerO.containsAll(1, 4) && emptyCells.contains(7)) {
      index = 7;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerO.containsAll(1, 7) && emptyCells.contains(4)) {
      index = 4;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerO.containsAll(4, 7) && emptyCells.contains(1)) {
      index = 1;
      playGame(index: index, activePlayer: activePlayer);
    }

    /// (2,5,8)
    else if (Player.playerO.containsAll(2, 5) && emptyCells.contains(8)) {
      index = 8;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerO.containsAll(2, 8) && emptyCells.contains(5)) {
      index = 5;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerO.containsAll(5, 8) && emptyCells.contains(2)) {
      index = 2;
      playGame(index: index, activePlayer: activePlayer);
    }

    /// (0,4,8)
    else if (Player.playerO.containsAll(0, 4) && emptyCells.contains(8)) {
      index = 8;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerO.containsAll(0, 8) && emptyCells.contains(4)) {
      index = 4;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerO.containsAll(4, 8) && emptyCells.contains(0)) {
      index = 0;
      playGame(index: index, activePlayer: activePlayer);
    }

    /// (2,4,6)
    else if (Player.playerO.containsAll(2, 4) && emptyCells.contains(6)) {
      index = 6;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerO.containsAll(2, 6) && emptyCells.contains(4)) {
      index = 4;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerO.containsAll(4, 6) && emptyCells.contains(2)) {
      index = 2;
      playGame(index: index, activePlayer: activePlayer);
    }

    /// Defense
    ///*********************************
    /// (0,1,2)
    else if (Player.playerX.containsAll(0, 1) && emptyCells.contains(2)) {
      index = 2;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerX.containsAll(0, 2) && emptyCells.contains(1)) {
      index = 1;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerX.containsAll(1, 2) && emptyCells.contains(0)) {
      index = 0;
      playGame(index: index, activePlayer: activePlayer);
    }

    /// (3,4,5)
    else if (Player.playerX.containsAll(3, 4) && emptyCells.contains(5)) {
      index = 5;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerX.containsAll(3, 5) && emptyCells.contains(4)) {
      index = 4;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerX.containsAll(4, 5) && emptyCells.contains(3)) {
      index = 3;
      playGame(index: index, activePlayer: activePlayer);
    }

    /// (6,7,8)
    else if (Player.playerX.containsAll(6, 7) && emptyCells.contains(8)) {
      index = 8;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerX.containsAll(6, 8) && emptyCells.contains(7)) {
      index = 7;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerX.containsAll(7, 8) && emptyCells.contains(6)) {
      index = 6;
      playGame(index: index, activePlayer: activePlayer);
    }

    /// (0,3,6)
    else if (Player.playerX.containsAll(0, 3) && emptyCells.contains(6)) {
      index = 6;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerX.containsAll(0, 6) && emptyCells.contains(3)) {
      index = 3;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerX.containsAll(3, 6) && emptyCells.contains(0)) {
      index = 0;
      playGame(index: index, activePlayer: activePlayer);
    }

    /// (1,4,7)
    else if (Player.playerX.containsAll(1, 4) && emptyCells.contains(7)) {
      index = 7;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerX.containsAll(1, 7) && emptyCells.contains(4)) {
      index = 4;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerX.containsAll(4, 7) && emptyCells.contains(1)) {
      index = 1;
      playGame(index: index, activePlayer: activePlayer);
    }

    /// (2,5,8)
    else if (Player.playerX.containsAll(2, 5) && emptyCells.contains(8)) {
      index = 8;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerX.containsAll(2, 8) && emptyCells.contains(5)) {
      index = 5;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerX.containsAll(5, 8) && emptyCells.contains(2)) {
      index = 2;
      playGame(index: index, activePlayer: activePlayer);
    }

    /// (0,4,8)
    else if (Player.playerX.containsAll(0, 4) && emptyCells.contains(8)) {
      index = 8;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerX.containsAll(0, 8) && emptyCells.contains(4)) {
      index = 4;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerX.containsAll(4, 8) && emptyCells.contains(0)) {
      index = 0;
      playGame(index: index, activePlayer: activePlayer);
    }

    /// (2,4,6)
    else if (Player.playerX.containsAll(2, 4) && emptyCells.contains(6)) {
      index = 6;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerX.containsAll(2, 6) && emptyCells.contains(4)) {
      index = 4;
      playGame(index: index, activePlayer: activePlayer);
    } else if (Player.playerX.containsAll(4, 6) && emptyCells.contains(2)) {
      index = 2;
      playGame(index: index, activePlayer: activePlayer);
    } else {
      /// perform random play
      Random random = Random();
      int randomIndex = random.nextInt(emptyCells.length);
      index = emptyCells[randomIndex];
      playGame(index: index, activePlayer: activePlayer);
    }
  }
}
