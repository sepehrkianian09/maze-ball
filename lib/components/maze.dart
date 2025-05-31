import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:maze_ball/components/game.dart';

import 'tile/maze_dimensions.dart';
import 'tile/tile_coordinates.dart';
import 'tile/tile_factory.dart';

int horizontalItemsLength = 4;
int verticalItemsLength = 4;

class Maze extends BodyComponent<MazeBallGame> with KeyboardHandler {
  MazeTileFactory get _mazeTileFactory {
    return MazeTileFactory(
      mazeDimensions: MazeDimensions(
        game: game,
        horizontalLength: 4,
        verticalLength: 4,
      ),
    );
  }

  Maze()
    : super(
        bodyDef: BodyDef(
          type: BodyType.static,
          gravityOverride: Vector2.zero(),
        ),
      );

  Future<void> _buildMazeBound() async {
    // add horizontal walls
    for (var i = 0; i < horizontalItemsLength; i++) {
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
            verticalIndex: verticalItemsLength,
            angle: MazeTileAngle.zero,
          ),
        ),
      );
    }

    // add vertical walls
    for (var j = 0; j < verticalItemsLength; j++) {
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
            horizontalIndex: horizontalItemsLength,
            verticalIndex: j,
            angle: MazeTileAngle.perpendicular,
          ),
        ),
      );
    }
  }

  List<MazeTileCoordinates> _getRandomUniqueCoordinates(
    int numberOfTiles,
    Random theRandom,
  ) {
    List<MazeTileCoordinates> addedTileCoordinates = [];
    var i = 0;
    while (i < numberOfTiles) {
      final tileCoordinates = MazeTileCoordinates.randomInternal(
        theRandom,
        horizontalItemsLength,
        verticalItemsLength,
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
    final maximumNumberOfTiles =
        (horizontalItemsLength - 1) * (verticalItemsLength) +
        (horizontalItemsLength) * (verticalItemsLength - 1);
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
