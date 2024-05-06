public protocol Graph {
	associatedtype Element
	
	mutating func createVertex(data: Element) -> Vertex<Element>
	mutating func addEdge(
		_ type: EdgeType,
		from source: Vertex<Element>,
		to destination: Vertex<Element>,
		weight: Double?
	)
	
	mutating func edges(from source: Vertex<Element>) -> [Edge<Element>]
	mutating func adjacencyVertex(from source: Vertex<Element>) -> [Vertex<Element>]
}
