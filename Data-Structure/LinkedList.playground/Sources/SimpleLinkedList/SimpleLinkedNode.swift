public final class SimpleLinkedNode<T> {
	public var data: T
	public var next: SimpleLinkedNode<T>?
	
	// MARK: - Initalizers
	public init(data: T, next: SimpleLinkedNode<T>? = nil) {
		self.data = data
		self.next = next
	}
}
