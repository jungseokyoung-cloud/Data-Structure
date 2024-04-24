struct HashTableLinkedList<T: Dictionable> {
	typealias Node = DoubleLinkedNode<T>
	
	private var head: Node?
	private weak var tail: Node?
	
	var isEmpty: Bool { head == nil }
	
	init() { }
}

// MARK: - Insert Methods
extension HashTableLinkedList {
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
}

extension HashTableLinkedList {
	/// `node`  를 제거합니다. 제거한 후, 값을 리턴합니다. `O(1)`
	@discardableResult
	mutating func remove(at node: Node) -> T? {
		guard !isEmpty else { return nil }
		guard node !== tail else { return pop_back() }
		guard node !== head else { return pop_front() }
		
		defer {
			node.prev?.next = node.next
			node.next?.prev = node.prev
		}
		
		return node.data
	}
	
	/// 연결리스트의 맨 앞의 원소를 제거합니다. 제거한 후, 값을 리턴합니다. `O(1)`
	@discardableResult
	mutating func pop_front() -> T? {
		defer {
			head?.next?.prev = nil
			head = head?.next
			
			if isEmpty { head = nil; tail = nil }
		}
		
		return head?.data
	}
	
	/// 연결리스트의 맨 뒤에 원소를 제거합니다. 제거한 후, 값을 리턴합니다. `O(1)`
	@discardableResult
	mutating func pop_back() -> T? {
		guard !isEmpty else { return nil }
		guard head?.next != nil else { return pop_front() }
		
		defer {
			tail?.prev?.next = nil
			tail = tail?.prev
		}
		
		return tail?.data
	}
}

extension HashTableLinkedList {
	/// key 값을 가지는 연결리스트를 리턴합니다. 
	func find(for key: T.Key) -> Node? {
		var beginIterator = self.makeIterator()
		var endIterator = self.makeIterator()
		
		while
			let begin = beginIterator.next(),
			let end = endIterator.prev() {
			if begin.data.key == key {
				return begin
			} else if end.data.key == key {
				return end
			}
			
			if begin === end { break }
		}
		
		return nil
	}
}

// MARK: - Sequence
extension HashTableLinkedList: Sequence {
	public func makeIterator() -> DoubleLinkedListIterator<T> {
		return DoubleLinkedListIterator(head: self.head, tail: self.tail)
	}
}
