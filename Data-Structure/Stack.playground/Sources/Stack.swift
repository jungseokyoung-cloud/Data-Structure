public protocol Stack {
	associatedtype T
	
	var count: Int { get }
	var isEmpty: Bool { get }
	var top: T? { get }
	
	mutating func push(_ element: T)
	mutating func pop() -> T?
}
