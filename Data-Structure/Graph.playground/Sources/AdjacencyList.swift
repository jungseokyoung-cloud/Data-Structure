public struct AdjacencyList<T>: Graph {
	private var list = [Vertex<T>: [Edge<T>]]()
	
	public init() { }
}

// MARK: - Graph Methods
public extension AdjacencyList {
	mutating func createVertex(data: T) -> Vertex<T> {
		let vertex = Vertex(id: list.count, value: data)
		list[vertex] = []
		return vertex
	}
	
	mutating func addEdge(
		_ type: EdgeType,
		from source: Vertex<Element>,
		to destination: Vertex<Element>,
		weight: Double?
	) {
		switch type {
			case .directed:
				addDirectedEdge(from: source, to: destination, weight: weight)
			case .unDirected:
				addNonDirectedEdge(from: source, to: destination, weight: weight)
		}
	}
	
	func edges(from source: Vertex<T>) -> [Edge<T>] {
		return list[source] ?? []
	}
	
	func adjacencyVertex(from source: Vertex<T>) -> [Vertex<T>] {
		return list[source]?.map { $0.destination } ?? []
	}
}

// MARK: - Private Methods
private extension AdjacencyList {
	mutating func addDirectedEdge(
		from source: Vertex<Element>,
		to destination: Vertex<Element>,
		weight: Double?
	) {
		let edge = Edge(source: source, destination: destination, weight: weight)
		
		list[source]?.append(edge)
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

extension AdjacencyList: CustomStringConvertible {
	public var description: String {
		var result = ""
		for (vertex, edges) in list { // 1
			var edgeString = ""
			for (index, edge) in edges.enumerated() { // 2
				if index != edges.count - 1 {
					edgeString.append("\(edge.destination), ")
				} else {
					edgeString.append("\(edge.destination)")
				}
			}
			result.append("\(vertex) ---> [ \(edgeString) ]\n") // 3
		}
		return result
	}
}
