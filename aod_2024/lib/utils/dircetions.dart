enum Direction {
  horizontalRight(x: 1, y: 0),
  horizontalLeft(x: -1, y: 0),
  verticalUp(x: 0, y: 1),
  verticalDown(x: 0, y: -1),
  diagonalDownRight(x: 1, y: 1),
  diagonalUpLeft(x: -1, y: -1),
  diagonalUpRight(x: 1, y: -1),
  diagonalDownLeft(x: -1, y: 1);

  final int x;
  final int y;
  const Direction({required this.x, required this.y});

  Direction next() {
    switch (this) {
      case verticalUp:
        return horizontalRight;
      case horizontalRight:
        return verticalDown;
      case verticalDown:
        return horizontalLeft;
      case horizontalLeft:
        return verticalUp;
      default:
        return verticalUp;
    }
  }
}

enum LazyDirection {
  horizontalRight(x: 1, y: 0),
  horizontalLeft(x: -1, y: 0),
  verticalUp(x: 0, y: -1),
  verticalDown(x: 0, y: 1);

  final int x;
  final int y;
  const LazyDirection({required this.x, required this.y});

  LazyDirection next() {
    switch (this) {
      case verticalUp:
        return horizontalRight;
      case horizontalRight:
        return verticalDown;
      case verticalDown:
        return horizontalLeft;
      case horizontalLeft:
        return verticalUp;
      default:
        return verticalUp;
    }
  }
}
