import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:maze_ball/components/game.dart';

import 'tile/tile_coordinates.dart';
import 'tile/tile_factory.dart';

class Maze extends BodyComponent<MazeBallGame> with KeyboardHandler {
  MazeTileFactory get _mazeTileFactory {
    return MazeTileFactory(mazeDimensions: game.mazeDimensions);
  }

  Maze({required this.level})
    : super(
        bodyDef: BodyDef(
          type: BodyType.static,
          gravityOverride: Vector2.zero(),
        ),
      );

  Future<void> _buildMazeBound() async {
    // add horizontal walls
    for (var i = 0; i < game.mazeDimensions.horizontalLength; i++) {
      await add(
        _mazeTileFactory.createTile(
          MazeTileCoordinates(
            horizontalIndex: i,
            verticalIndex: 0,
            angle: MazeTileAngle.zero,
          ),
        ),
      );
      await add(
        _mazeTileFactory.createTile(
          MazeTileCoordinates(
            horizontalIndex: i,
            verticalIndex: game.mazeDimensions.verticalLength,
            angle: MazeTileAngle.zero,
          ),
        ),
      );
    }

    // add vertical walls
    for (var j = 0; j < game.mazeDimensions.verticalLength; j++) {
      await add(
        _mazeTileFactory.createTile(
          MazeTileCoordinates(
            horizontalIndex: 0,
            verticalIndex: j,
            angle: MazeTileAngle.perpendicular,
          ),
        ),
      );
      await add(
        _mazeTileFactory.createTile(
          MazeTileCoordinates(
            horizontalIndex: game.mazeDimensions.horizontalLength,
            verticalIndex: j,
            angle: MazeTileAngle.perpendicular,
          ),
        ),
      );
    }
  }

  // TODO what if there is a round in the graph of bound coordinates?
  List<MazeTileCoordinates> _getRandomUniqueCoordinates(
    int numberOfTiles,
    Random theRandom,
  ) {
    List<MazeTileCoordinates> addedTileCoordinates = [];
    var i = 0;
    while (i < numberOfTiles) {
      final tileCoordinates = MazeTileCoordinates.randomInternal(
        theRandom,
        game.mazeDimensions.horizontalLength,
        game.mazeDimensions.verticalLength,
      );
      // print("tile coordinates: $tileCoordinates");
      if (addedTileCoordinates.contains(tileCoordinates)) {
        continue;
      }
      addedTileCoordinates.add(tileCoordinates);
      // print("added tile coordinates: $tileCoordinates");
      i++;
    }
    return addedTileCoordinates;
  }

  final int level;

  Future<void> _buildRandomTiles(Random theRandom) async {
    final maximumNumberOfTiles =
        (game.mazeDimensions.horizontalLength - 1) *
            (game.mazeDimensions.verticalLength) +
        (game.mazeDimensions.horizontalLength) *
            (game.mazeDimensions.verticalLength - 1);
    int numberOfTiles = theRandom.nextInt(maximumNumberOfTiles / 2 as int);
    print("number of random tiles: $numberOfTiles");

    for (var coordinate in _getRandomUniqueCoordinates(
      numberOfTiles,
      theRandom,
    )) {
      await add(_mazeTileFactory.createTile(coordinate));
    }
  }

  @override
  Future<void> onLoad() async {
    await _buildMazeBound();
    await _buildRandomTiles(Random());

    return super.onLoad();
  }
}
