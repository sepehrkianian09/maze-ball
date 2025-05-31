import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:maze_ball/components/game.dart';
import 'package:maze_ball/components/tile/maze_dimensions.dart';

import 'tile/tile_coordinates.dart';
import 'tile/tile_factory.dart';

class Maze extends BodyComponent<MazeBallGame> with KeyboardHandler {
  MazeTileFactory get _mazeTileFactory {
    return MazeTileFactory(mazeDimensions: mazeDimensions);
  }

  final MazeDimensions mazeDimensions;
  final int level;

  Maze({required this.level, required this.mazeDimensions})
    : super(
        bodyDef: BodyDef(
          type: BodyType.static,
          gravityOverride: Vector2.zero(),
        ),
      );

  Future<void> _buildMazeBound() async {
    // add horizontal walls
    for (var i = 0; i < mazeDimensions.horizontalLength; i++) {
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
            verticalIndex: mazeDimensions.verticalLength,
            angle: MazeTileAngle.zero,
          ),
        ),
      );
    }

    // add vertical walls
    for (var j = 0; j < mazeDimensions.verticalLength; j++) {
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
            horizontalIndex: mazeDimensions.horizontalLength,
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
        mazeDimensions.horizontalLength,
        mazeDimensions.verticalLength,
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


  Future<void> _buildRandomTiles(Random theRandom) async {
    int numberOfTiles = level + theRandom.nextInt(level);
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
