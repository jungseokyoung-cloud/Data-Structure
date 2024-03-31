public struct DoubleLinkedListIterator<T: Equatable>: IteratorProtocol {
	var currentHead: DoubleLinkedNode<T>?
	var currentTail: DoubleLinkedNode<T>?
	
	init(head: DoubleLinkedNode<T>?, tail: DoubleLinkedNode<T>?) {
		self.currentHead = head
		self.currentTail = tail
	}
	
	mutating public func next() -> DoubleLinkedNode<T>? {
		guard let thisCurrent = currentHead else { return nil }
		
		defer { self.currentHead = thisCurrent.next }
		return currentHead
	}
	
	mutating public func prev() -> DoubleLinkedNode<T>? {
		guard let thisCurrent = currentTail else { return nil }
		
		defer { self.currentTail = thisCurrent.prev }
		return currentTail
	}

}
