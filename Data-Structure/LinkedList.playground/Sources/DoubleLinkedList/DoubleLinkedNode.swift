public final class DoubleLinkedNode<T: Equatable> {
	public var prev: DoubleLinkedNode<T>?
	public var next: DoubleLinkedNode<T>?
	public var data: T
	
	public init(data: T, prev: DoubleLinkedNode<T>? = nil, next: DoubleLinkedNode<T>? = nil) {
		self.data = data
		self.prev = prev
		self.next = next
	}
}
