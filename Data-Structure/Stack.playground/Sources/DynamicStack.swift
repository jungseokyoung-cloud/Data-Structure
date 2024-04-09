public struct DynamicStack<T>: Stack {
	private var elements: [T] = []
	
	public var count: Int {
		return elements.count
	}
	
	public var isEmpty: Bool {
		return elements.isEmpty
	}
	
	public var top: T? {
		return elements.last
	}
	
	public init() { }
}

// MARK: Public Methods
public extension DynamicStack {
	mutating func push(_ element: T) {
		elements.append(element)
	}
	
	mutating func pop() -> T? {
		return elements.popLast()
	}
}
