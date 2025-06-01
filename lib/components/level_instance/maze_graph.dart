class MazeNode {
  final List<MazeNode> neighbors = [];

  void addNeighbor(MazeNode neighbor) {
    if (!neighbors.contains(neighbor)) {
      neighbors.add(neighbor);
    }
  }

  void removeNeighbor(MazeNode neighbor) {
    neighbors.remove(neighbor);
  }
}

class MazeEdge {
  final MazeNode node1;
  final MazeNode node2;

  MazeEdge(this.node1, this.node2);

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

class MazeGraph {
  final int horizontalLength;
  final int verticalLength;

  late final List<List<MazeNode>> nodes;
  late final List<List<MazeEdge>> horizontalEdges;
  late final List<List<MazeEdge>> verticalEdges;

  MazeGraph({required this.horizontalLength, required this.verticalLength}) {
    nodes = List.generate(
      horizontalLength,
      (int _) => List.generate(verticalLength, (int _) => MazeNode()),
    );

    horizontalEdges = List.generate(
      horizontalLength,
      (int i) => List.generate(
        verticalLength - 1,
        (int j) => MazeEdge(nodes[i][j], nodes[i][j + 1]),
      ),
    );
    for (var edgesColumn in horizontalEdges) {
      for (var edge in edgesColumn) {
        edge.connect();
      }
    }

    verticalEdges = List.generate(
      horizontalLength - 1,
      (int i) => List.generate(
        verticalLength,
        (int j) => MazeEdge(nodes[i][j], nodes[i + 1][j]),
      ),
    );
    for (var edgesColumn in verticalEdges) {
      for (var edge in edgesColumn) {
        edge.connect();
      }
    }
  }
}
