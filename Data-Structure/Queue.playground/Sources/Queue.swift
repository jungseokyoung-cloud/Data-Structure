public protocol Queue {
	associatedtype T
	
	var count: Int { get }
	var isEmpty: Bool { get }
	var top: T? { mutating get }
	
	mutating func enqueue(_ element: T)
	mutating func dequeue() -> T?
}

