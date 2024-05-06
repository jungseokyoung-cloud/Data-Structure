/// Graph의 정점을 정의합니다. 각 정점은 `id`로 구분됩니다.
public struct Vertex<T> {
	public let id: Int
	public var value: T
	
	public init(id: Int, value: T) {
		self.id = id
		self.value = value
	}
}

// MARK: - Hashable
public extension Vertex: Hashable {
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
	
	static func ==(lhs: Vertex, rhs: Vertex) -> Bool {
		return lhs.id == rhs.id
	}
}

extension Vertex: CustomStringConvertible {
	public var description: String {
		return "\(id): \(data)"
	}
}
