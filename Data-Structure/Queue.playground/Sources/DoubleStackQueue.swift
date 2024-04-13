public struct DoubleStackQueue<T>: Queue {
	private var inbox = DynamicStack<T>()
	private var outbox = DynamicStack<T>()
	
	public var count: Int { inbox.count + outbox.count }
	
	public var isEmpty: Bool {
		return inbox.isEmpty && outbox.isEmpty
	}
	
	/// O(N)
	public var top: T? {
		mutating get { return getTop() }
	}
	
	public init() { }
}

public extension DoubleStackQueue {
	/// O(N)
	mutating func enqueue(_ element: T) {
		if inbox.isEmpty {
			while let element = outbox.pop() {
				inbox.push(element)
			}
		}
		
		inbox.push(element)
	}
	
	@discardableResult
	/// O(N)
	mutating func dequeue() -> T? {
		if outbox.isEmpty {
			while let element = inbox.pop() {
				outbox.push(element)
			}
		}
		
		return outbox.pop()
	}
	
	mutating func getTop() -> T? {
		if outbox.isEmpty {
			while let element = inbox.pop() {
				outbox.push(element)
			}
		}
		
		return outbox.top
	}
}

// MARK: - DynamicStack
struct DynamicStack<T> {
	private var elements: [T] = []
	
	var count: Int {
		elements.count
	}
	
	var isEmpty: Bool {
		elements.isEmpty
	}
	
	var top: T? { return elements.last }
	
	mutating func push(_ element: T) {
		elements.append(element)
	}
	
	mutating func pop() -> T? {
		guard !isEmpty else { return nil }
		return elements.popLast()
	}
}
