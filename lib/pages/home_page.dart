import 'package:flutter/material.dart';

import '../models/ttt_board.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TTTBoard _board;
  CellType _currentPlayer;
  CellType _winner;
  String _msg;
  bool _isInterfaceEnabled;

  @override
  void initState() {
    print("$runtimeType::initState()");

    super.initState();

    _newGame();
  }

  void _newGame() {
    setState(() {
      _board = TTTBoard();
      _currentPlayer = CellType.O;
      _nextPlayer();
      _isInterfaceEnabled = true;
    });
  }

  void _makeAMove(int index) {
    setState(() {
      _winner = _board.move(_currentPlayer, index);

      if (_winner != null) {
        _msg = "Player ${cellTypeToString(_winner)} wins!";
        _isInterfaceEnabled = false;
      }
      else if (_board.isFull) {
        _msg = "Another damn tie... Bleh!";
        _isInterfaceEnabled = false;
      }
      else {
        _nextPlayer();
      }
    });
  }

  void _nextPlayer() {
    _currentPlayer = _currentPlayer == CellType.X ? CellType.O : CellType.X;
    _msg = 'Player ${cellTypeToString(_currentPlayer)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: "New Game",
            onPressed: _newGame,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    _msg,
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                children: List<Widget>.generate(_board.grid.length, _buildCell),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCell(int i) {
    return GestureDetector(
      onTap: _isInterfaceEnabled && _board.isEmpty(i) ? () => _makeAMove(i) : null,
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.blueGrey,
        child: FittedBox(
          child: Text(
            cellTypeToString(_board[i]),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

