public struct DoubleLinkedList<T: Equatable> {
	public typealias Node = DoubleLinkedNode<T>
	
	private var head: Node?
	private var tail: Node?

	public var isEmpty: Bool { head == nil }
	
	public init() { }
}

// MARK: - Insert Methods
public extension DoubleLinkedList {
	/// 연결리스트 맨 뒤에 원소를 추가합니다. `O(1)`
	mutating func append(_ data: T) {
		guard !isEmpty else {
			head = Node(data: data)
			tail = head
			return
		}
		
		let newNode = Node(data: data)
		tail?.next = newNode
		newNode.prev = tail
		tail = newNode
	}
	
	/// `after`뒤에 원소를 추가합니다. `O(1)`
	mutating func insert(_ data: T, after node: Node) {
		guard !isEmpty && node !== tail else {
			append(data)
			return
		}
		
		let newNode = Node(data: data)
		newNode.next = node.next
		newNode.prev = node
		
		node.next?.prev = newNode
		node.next = newNode
	}
}

// MARK: - Delete Methods
public extension DoubleLinkedList {
	@discardableResult
	/// 연결리스트의 맨 앞의 원소를 제거합니다. 제거한 후, 값을 리턴합니다. `O(1)`
	mutating func pop_front() -> T? {
		guard !isEmpty else { return nil }
		
		defer {
			if head === tail { head = nil; tail = nil }
			
			head?.next?.prev = nil
			head = head?.next
		}
		
		return head?.data
	}
	
	@discardableResult
	/// 연결리스트의 맨 뒤에 원소를 제거합니다. 제거한 후, 값을 리턴합니다. `O(1)`
	mutating func pop_back() -> T? {
		guard !isEmpty else { return nil }
		guard head?.next != nil else { return pop_front() }

		defer {
			tail?.prev?.next = nil
			tail = tail?.prev
		}
		
		return tail?.data
	}
	
	@discardableResult
	/// `after` 뒤에 원소를 제거합니다. 제거한 후, 값을 리턴합니다. `O(1)`
	mutating func remove(after node: Node) -> T? {
		guard node !== tail else { return nil }
		guard !isEmpty && node.next !== tail else { return pop_back() }
		
		let removeNode = node.next
		
		node.next = removeNode?.next
		removeNode?.next?.prev = node
		
		return removeNode?.data
	}
}

// MARK: - Util Methods
public extension DoubleLinkedList {
	/// 연결리스트의 모든 원소의 값들을 list 형태로 리턴합니다.
	func travalsel() -> [T] {
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
	
	/// 파라미터로 전달된 값을 가지는 노드를 리턴합니다.
	/// 투포인터 알고리즘을 통해 탐색하기 때문에, `head` 혹은 `tail`에서 가장 가까운 노드를 리턴합니다.
	/// 만약, `head` `tail`에서 동일한 거리만큼 떨어져 있다면, `head`와 가까운 노드를 리턴합니다.
	/// `O(N)`
	func find(_ data: T) -> Node? {
		var beginIterator = self.makeIterator()
		var endIterator = self.makeIterator()
		
		while let begin = beginIterator.next(), let end = endIterator.prev() {
			if begin.data == data {
				return begin
			} else if end.data == data {
				return end
			}
			
			if begin === end { break }
		}
		
		return nil
	}
}

// MARK: - Sequence
extension DoubleLinkedList: Sequence {
	public func makeIterator() -> DoubleLinkedListIterator<T> {
		return DoubleLinkedListIterator(head: self.head, tail: self.tail)
	}
}
