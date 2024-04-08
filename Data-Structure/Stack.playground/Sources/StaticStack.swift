import Foundation

public struct StaticStack<T>: Stack {
	private let capacity: Int
	private let elements: NSMutableArray
	/// 스택의 위치를 나타내는 포인터로, 원소가 추가되는 위치이다.
	private var stackPointer = 0
	
	public var count: Int {
		return stackPointer
	}
	
	public var isFull: Bool {
		count == capacity
	}
	
	public var isEmpty: Bool {
		return stackPointer == 0
	}
	
	/// 최상단의 원소를 반환합니다.
	public var top: T? {
		guard !isEmpty else { return nil }
		
		return elements[stackPointer - 1] as? T
	}
	
	// MARK: - Initializer
	public init(capacity: Int = 10) {
		self.capacity = capacity
		self.elements = NSMutableArray(capacity: capacity)
	}
}

// MARK: - Methods
public extension StaticStack {
	/// capacity를 넘어선 경우, stack overflow를 발생시킨다.
	mutating func push(_ element: T) {
		guard !isFull else { fatalError("Stack Overflow") }
		
		defer { stackPointer += 1 }
		self.elements[stackPointer] = element
	}
	
	@discardableResult
	mutating func pop() -> T? {
		guard !isEmpty else { return nil }
		
		stackPointer -= 1
		return elements[stackPointer] as? T
	}
}
