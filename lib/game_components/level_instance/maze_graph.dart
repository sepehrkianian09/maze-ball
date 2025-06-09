import 'dart:collection';

import 'package:maze_ball/game_components/level_instance/collectibles/cell_coordinates.dart';
import 'package:maze_ball/game_components/level_instance/tile/tile_coordinates.dart';

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

  _Node _getCorrespondentNode(CellCoordinates cellCoordinates) {
    return _nodes[cellCoordinates.x][cellCoordinates.y];
  }

  int? shortestPathBetweenCells(CellCoordinates source, CellCoordinates dest) {
    List<_Node>? shortestPath = _bfsShortestPath(
      _getCorrespondentNode(source),
      _getCorrespondentNode(dest),
    );

    return shortestPath?.length;
  }
}

List<_Node>? _bfsShortestPath(_Node start, _Node goal) {
  Queue<_Node> queue = Queue<_Node>();
  Map<_Node, _Node?> parent = {}; // Keeps track of path
  Set<_Node> visited = {};

  queue.add(start);
  visited.add(start);
  parent[start] = null;

  while (queue.isNotEmpty) {
    _Node current = queue.removeFirst();

    if (current == goal) {
      // Reconstruct path from goal to start
      List<_Node> path = [];
      _Node? node = goal;
      while (node != null) {
        path.add(node);
        node = parent[node];
      }
      return path.reversed.toList(); // From start to goal
    }

    for (_Node neighbor in current.neighbors) {
      if (!visited.contains(neighbor)) {
        queue.add(neighbor);
        visited.add(neighbor);
        parent[neighbor] = current;
      }
    }
  }

  return null; // No path found
}
