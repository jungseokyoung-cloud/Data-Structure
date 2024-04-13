public struct LinkedListQueue<T>: Queue {
	typealias Node = SimpleLinkedNode<T>
	
	private var head: Node?
	private weak var tail: Node?
	
	public private(set) var count: Int = 0
	
	public var isEmpty: Bool {
		head == nil
	}
	
	public var top: T? {
		return head?.data
	}
	
	public init() { }
}

public extension LinkedListQueue {
	/// O(1)
	mutating func enqueue(_ element: T) {
		count += 1
		append(element)
	}
	
	@discardableResult
	/// O(1)
	mutating func dequeue() -> T? {
		count = count == 0 ? 0 : count - 1
		return pop_front()
	}
}

// MARK: - Private method
private extension LinkedListQueue {
	mutating func append(_ data: T) {
		guard !isEmpty else {
			// 연결리스트가 빈 경우, head로 지정
			head = Node(data: data)
			tail = head
			return
		}
	
		tail?.next = Node(data: data)
		tail = tail?.next
	}
	
	@discardableResult
	mutating func pop_front() -> T? {
		defer { head = head?.next }
		
		return head?.data
	}
}

// MARK: - Node
final class SimpleLinkedNode<T> {
	var data: T
	var next: SimpleLinkedNode<T>?
	
	// MARK: - Initalizers
	init(data: T, next: SimpleLinkedNode<T>? = nil) {
		self.data = data
		self.next = next
	}
}
