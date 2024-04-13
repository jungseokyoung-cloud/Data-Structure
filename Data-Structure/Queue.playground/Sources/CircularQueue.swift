import Foundation

public struct CircularQueue<T>: Queue {
	private let elements: NSMutableArray
	
	private let capacity: Int
	private var head: Int = 0
	private var tail: Int = 0
	
	public var count: Int {
		return (tail - head + capacity) % capacity
	}
	
	public var isEmpty: Bool {
		head == tail
	}
	
	private var isFull: Bool {
		head == (tail + 1) % capacity
	}
	
	public var top: T? {
		guard !isEmpty else { return nil }
		return elements[(head + 1) % capacity] as? T
	}
	
	public init(capacity: Int) {
		self.capacity = capacity + 1
		self.elements = NSMutableArray(capacity: capacity + 1)
	}
}

public extension CircularQueue {
	/// O(1)
	mutating func enqueue(_ element: T) {
		guard !isFull else {
			print("queue is full")
			return
		}
		
		if isEmpty { elements[tail] = element }
		tail = (tail + 1) % capacity
		
		elements[tail] = element
	}
	
	@discardableResult
	/// O(1)
	mutating func dequeue() -> T? {
		guard !isEmpty else { return nil }
		
		head = (head + 1) % capacity
		
		return elements[head] as? T
	}
}
