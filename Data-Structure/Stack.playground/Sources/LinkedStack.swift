// MARK: - Node
fileprivate class DoubleLinkedNode<T> {
	fileprivate var data: T
	fileprivate var next: DoubleLinkedNode<T>?
	fileprivate var prev: DoubleLinkedNode<T>?
	
	// MARK: - Initalizers
	fileprivate init(data: T, prev: DoubleLinkedNode<T>? = nil, next: DoubleLinkedNode<T>? = nil) {
		self.data = data
		self.prev = prev
		self.next = next
	}
}

// MARK: - LinkedStack
public struct LinkedStack<T>: Stack {
	fileprivate typealias Node = DoubleLinkedNode<T>
	
	private var head: Node?
	private weak var tail: Node?

	public private(set) var count: Int = 0
	
	public var isEmpty: Bool {
		head == nil
	}
	
	public var top: T? {
		return tail?.data
	}
	
	public init() { }
}

// MARK: - Public Methods
public extension LinkedStack {
	mutating func push(_ element: T) {
		guard !isEmpty else {
			count += 1
			head = Node(data: element)
			tail = head
			return
		}
		
		count += 1
		let newNode = Node(data: element)
		tail?.next = newNode
		newNode.prev = tail
		tail = newNode
	}
	
	@discardableResult
	mutating func pop() -> T? {
		guard !isEmpty else { return nil }
		guard head !== tail else { return pop_front() }
		
		defer {
			tail = tail?.prev
			tail?.next = nil
			count -= 1
		}
		
		return tail?.data
	}
}

// MARK: - Private Methods
private extension LinkedStack {
	private mutating func pop_front() -> T? {
		guard !isEmpty else { return nil }
		
		defer {
			head = head?.next
			head?.prev = nil
			count -= 1
		}
		
		return head?.data
	}
}

