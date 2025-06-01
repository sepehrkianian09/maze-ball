import 'package:maze_ball/components/level_instance/tile/tile_coordinates.dart';

class _Node {
  final List<_Node> neighbors = [];

  void addNeighbor(_Node neighbor) {
    if (!neighbors.contains(neighbor)) {
      neighbors.add(neighbor);
    }
  }

  void removeNeighbor(_Node neighbor) {
    neighbors.remove(neighbor);
  }
}

class _Edge {
  final _Node node1;
  final _Node node2;

  _Edge(this.node1, this.node2);

  final bool _connected = false;
  bool isConnected() {
    return _connected;
  }

  void connect() {
    node1.addNeighbor(node2);
    node2.addNeighbor(node1);
  }

  void disconnect() {
    node1.removeNeighbor(node2);
    node2.removeNeighbor(node1);
  }
}

class MazeCellGraph {
  final int horizontalLength;
  final int verticalLength;

  late final List<List<_Node>> _nodes;
  late final List<List<_Edge>> _horizontalEdges;
  late final List<List<_Edge>> _verticalEdges;

  MazeCellGraph({
    required this.horizontalLength,
    required this.verticalLength,
  }) {
    _nodes = List.generate(
      horizontalLength,
      (int _) => List.generate(verticalLength, (int _) => _Node()),
    );

    _horizontalEdges = List.generate(
      horizontalLength,
      (int i) => List.generate(
        verticalLength - 1,
        (int j) => _Edge(_nodes[i][j], _nodes[i][j + 1]),
      ),
    );

    _verticalEdges = List.generate(
      horizontalLength - 1,
      (int i) => List.generate(
        verticalLength,
        (int j) => _Edge(_nodes[i][j], _nodes[i + 1][j]),
      ),
    );

    _connectAllEdges(_horizontalEdges);
    _connectAllEdges(_verticalEdges);
  }

  void _connectAllEdges(List<List<_Edge>> edges) {
    for (var edgesColumn in edges) {
      for (var edge in edgesColumn) {
        edge.connect();
      }
    }
  }

  _Edge _getCorrespondentEdge(MazeTileCoordinates wallCoordinates) {
    switch (wallCoordinates.angle) {
      case MazeTileAngle.zero:
        return _horizontalEdges[wallCoordinates
            .horizontalIndex][wallCoordinates.verticalIndex - 1];
      case MazeTileAngle.perpendicular:
        return _verticalEdges[wallCoordinates.horizontalIndex -
            1][wallCoordinates.verticalIndex];
    }
  }

  void addWall(MazeTileCoordinates wallCoordinates) {
    _getCorrespondentEdge(wallCoordinates).disconnect();
  }

  void removeWall(MazeTileCoordinates wallCoordinates) {
    _getCorrespondentEdge(wallCoordinates).connect();
  }
}
