struct SimpleLinkedListIterator<T>: IteratorProtocol {
	var current: SimpleLinkedNode<T>?
	
	init(head: SimpleLinkedNode<T>?) {
		self.current = head
	}
	
	mutating func next() -> SimpleLinkedNode<T>? {
		guard let thisCurrent = current else { return nil }
		
		defer { self.current = thisCurrent.next }
		return current
	}

}
