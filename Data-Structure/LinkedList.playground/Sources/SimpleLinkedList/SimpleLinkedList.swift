/// 단일 링크드 리스트
public struct SimpleLinkedList<T> {
	
	public typealias Node = SimpleLinkedNode<T>
	
	private var head: Node?
	private var tail: Node?
	
	public var isEmpty: Bool { head == nil }
	
	public init() { }
}

// MARK: - Insert Methods
public extension SimpleLinkedList {
	/// 연결리스트의 맨 뒤에 원소를 추가합니다. `O(1)`
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
	
	/// `after`뒤에 원소를 추가합니다. `O(1)`
	mutating func insert(_ data: T, after node: Node?) {
		guard !isEmpty && node !== tail else {
			append(data)
			return
		}
		
		let nextNode = node?.next
		node?.next = Node(data: data, next: nextNode)
	}
}

// MARK: - Delete Methods
public extension SimpleLinkedList {
	@discardableResult
	/// 연결리스트의 맨 앞의 원소를 제거합니다. 제거한 후, 값을 리턴합니다. `O(1)`
	mutating func pop_front() -> T? {
		defer {
			if head === tail { head = nil; tail = nil }
			head = head?.next
		}
		
		return head?.data
	}
	
	@discardableResult
	/// 연결리스트의 맨 뒤의 원소를 제거합니다. 제거한 후, 값을 리턴합니다. `O(N)`
	mutating func pop_back() -> T? {
		guard !isEmpty else { return nil }
		guard head?.next != nil else { return pop_front() }
		
		var node = head
		
		while node?.next !== tail {
			node = node?.next
		}
		
		defer { node?.next = nil; tail = node }

		return node?.next?.data
	}
	
	
	@discardableResult
	/// `after` 뒤에 원소를 제거합니다. 제거한 후, 값을 리턴합니다. `O(1)`
	mutating func remove(after node: Node) -> T? {
		guard !isEmpty && node !== tail else { return nil }
		
		if tail === node.next { tail = node }
		
		let removeNode = node.next
		node.next = removeNode?.next
		
		return removeNode?.data
	}
}

// MARK: - Util Methods
public extension SimpleLinkedList {
	/// 연결리스트의 모든 값들을 list 형태로 리턴합니다.
	func travelsal() -> [T] {
		var values: [T?] = []
		self.forEach { values.append($0.data) }
		
		return values.compactMap { $0 }
	}
	
	/// `index`에 해당하는 연결리스트의 노드를 리턴합니다. `O(N)`
	func node(at index: Int) -> Node? {
		return self.enumerated()
			.first { $0.offset == index }
			.map { $0.element }
	}
}

// MARK: - Sequence
extension SimpleLinkedList: Sequence {
	public func makeIterator() -> SimpleLinkedListIterator<T> {
		return SimpleLinkedListIterator(head: self.head)
	}
}
