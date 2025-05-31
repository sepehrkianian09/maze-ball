import 'dart:math';

enum MazeTileAngle {
  zero(0),
  perpendicular(pi / 2);

  final double value;
  const MazeTileAngle(this.value);
}

class MazeTileCoordinates {
  final int horizontalIndex;
  final int verticalIndex;
  final MazeTileAngle angle;

  MazeTileCoordinates({
    required this.horizontalIndex,
    required this.verticalIndex,
    required this.angle,
  });

  factory MazeTileCoordinates.randomInternal(
    Random theRandom,
    int horizontalItemsLength,
    int verticalItemsLength,
  ) {
    randomAngle() =>
        MazeTileAngle.values[theRandom.nextInt(MazeTileAngle.values.length)];
    final angle = randomAngle();

    switch (angle) {
      case MazeTileAngle.zero:
        return MazeTileCoordinates(
          horizontalIndex: theRandom.nextInt(horizontalItemsLength),
          verticalIndex: 1 + theRandom.nextInt(verticalItemsLength - 1),
          angle: angle,
        );
      case MazeTileAngle.perpendicular:
        return MazeTileCoordinates(
          horizontalIndex: 1 + theRandom.nextInt(horizontalItemsLength - 1),
          verticalIndex: theRandom.nextInt(verticalItemsLength),
          angle: angle,
        );
    }
  }
}