class TTTBoard {
  static const List<_WinPattern> _winPatterns = [
    _WinPattern(0, 1, 2),
    _WinPattern(3, 4, 5),
    _WinPattern(6, 7, 8),
    _WinPattern(0, 3, 6),
    _WinPattern(1, 4, 7),
    _WinPattern(2, 5, 8),
    _WinPattern(0, 4, 8),
    _WinPattern(2, 4, 6),
  ];

  List<CellType> _grid = List<CellType>.filled(9, CellType.empty);
  List<CellType> get grid => List.unmodifiable(_grid);

  CellType move(CellType player, int cellIndex) {
    assert(_grid[cellIndex] == CellType.empty);

    _grid[cellIndex] = player;

    return getWinner();
  }

  CellType getWinner() {
    // no win is possible before the 5th move
    if (moveCount >= 5) {
      for (_WinPattern pattern in _winPatterns) {
        if (_checkPattern(pattern)) {
          return _grid[pattern.cell1];
        }
      }
    }
    return null;
  }

  bool _checkPattern(_WinPattern p) {
    return _grid[p.cell1] != CellType.empty &&
           _grid[p.cell1] == _grid[p.cell2] &&
           _grid[p.cell1] == _grid[p.cell3];
  }

  CellType operator [](int cellIndex) => _grid[cellIndex];

  bool get isFull => moveCount >= _grid.length;
  bool get isNotFull => !isFull;

  bool isEmpty(int index) => _grid[index] == CellType.empty;

  int get moveCount => _grid.where((CellType cell) => cell == CellType.X || cell == CellType.O).length;

  @override
  String toString() {
    return """
${cellTypeToString(_grid[0])} | ${cellTypeToString(_grid[1])} | ${cellTypeToString(_grid[2])}
${cellTypeToString(_grid[3])} | ${cellTypeToString(_grid[4])} | ${cellTypeToString(_grid[5])}
${cellTypeToString(_grid[6])} | ${cellTypeToString(_grid[7])} | ${cellTypeToString(_grid[8])}
    """;
  }
}

class _WinPattern {
  final int cell1;
  final int cell2;
  final int cell3;

  const _WinPattern(this.cell1, this.cell2, this.cell3);
}

enum CellType {
  empty,
  X,
  O
}

String cellTypeToString(CellType type) {
  switch (type) {
    case CellType.empty: return ' '; break;
    case CellType.X: return 'X'; break;
    case CellType.O: return 'O'; break;
    default: return null;
  }
}