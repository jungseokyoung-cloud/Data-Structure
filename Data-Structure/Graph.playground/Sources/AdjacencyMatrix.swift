public struct AdjacencyMatrix<T>: Graph {
	private var weights = [[Double?]]()
	private var vertices = Set<Vertex<T>>()
	private var indexToVertex = [Int: Vertex<T>]()
	
	public init() { }
}

// MARK: - Graph Methods
public extension AdjacencyMatrix {
	mutating func createVertex(data: T) -> Vertex<T> {
		let vertex = Vertex(id: vertices.count, value: data)
		vertices.insert(vertex)
		indexToVertex[vertices.count] = vertex
		
		for index in 0..<weights.count { weights[index].append(nil) }
		weights.append(.init(repeating: nil, count: vertices.count))
		
		return vertex
	}
	
	mutating func addEdge(
		_ type: EdgeType,
		from source: Vertex<T>,
		to destination: Vertex<T>,
		weight: Double?
	) {
		switch type {
			case .directed:
				addDirectedEdge(from: source, to: destination, weight: weight)
			case .unDirected:
				addNonDirectedEdge(from: source, to: destination, weight: weight)
		}
	}
	
	mutating func edges(from source: Vertex<T>) -> [Edge<T>] {
		var edges: [Edge<T>] = []
		
		weights[source.id].enumerated().forEach { (col, weight) in
			if let destination = indexToVertex[col] {
				edges.append(.init(source: source, destination: destination, weight: weight))
			}
		}
		
		return edges
	}
	
	mutating func adjacencyVertex(from source: Vertex<T>) -> [Vertex<T>] {
		var vertexes: [Vertex<T>] = []
		
		for col in 0..<weights.count {
			if let destination = indexToVertex[col], weights[source.id][col] != nil {
				vertexes.append(destination)
			}
		}
		
		return vertexes
	}
}

// MARK: - Private Methods
private extension AdjacencyMatrix {
	mutating func addDirectedEdge(
		from source: Vertex<Element>,
		to destination: Vertex<Element>,
		weight: Double?
	) {
		weights[source.id][destination.id] = weight ?? 1.0
	}
	
	mutating func addNonDirectedEdge(
		from source: Vertex<Element>,
		to destination: Vertex<Element>,
		weight: Double?
	) {
		addDirectedEdge(from: source, to: destination, weight: weight)
		addDirectedEdge(from: destination, to: source, weight: weight)
	}
}

public extension AdjacencyMatrix: CustomStringConvertible {
	var description: String {
		let verticesDescription = vertices.map { "\($0)" }
		var grid: [String] = []
		
		for i in 0..<weights.count {
			var row = ""
			for j in 0..<weights.count {
				if let value = weights[i][j] {
					row += "\(value)\t"
				} else {
					row += "-\t\t"
				}
			}
			grid.append(row)
		}
		let edgesDescription = grid.joined(separator: "\n")
		
		return "\(verticesDescription)\n\n\(edgesDescription)"
	}
}
