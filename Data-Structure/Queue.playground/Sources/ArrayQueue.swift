public struct ArrayQueue<T>: Queue {
	private var elements: [T] = []
	private var head: Int = 0
	
	public var count: Int {
		return elements.count - head
	}
	
	public var isEmpty: Bool {
		head == elements.count
	}
	
	public var top: T? {
		guard !isEmpty else { return nil }
		return elements.last
	}
	
	public init() { }
}

public extension ArrayQueue {
	/// O(1)
	mutating func enqueue(_ element: T) {
		elements.append(element)
	}
	
	@discardableResult
	/// O(1)
	mutating func dequeue() -> T? {
		guard !isEmpty else { return nil }
		
		defer { head += 1 }
		return elements[head]
	}
}

