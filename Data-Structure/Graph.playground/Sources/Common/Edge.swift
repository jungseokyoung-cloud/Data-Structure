/// Edge의 type을 정의합니다.
public enum EdgeType {
	case directed
	case unDirected
}

public struct Edge<T> {
	public var source: Vertex<T>
	public var destination: Vertex<T>
	
	public var weight: Double
	
	public init(
		source: Vertex<T>,
		destination: Vertex<T>,
		weight: Double = 1.0
	) {
		self.source = source
		self.destination = destination
		self.weight = weight
	}
}
