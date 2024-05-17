final class Node<T: Comparable> {
	var value: T
	var left: Node?
	var right: Node?
	
	weak var parent: Node?
	
	init(value: T) {
		self.value = value
	}
	
	init(value: T, parent: Node<T>?) {
		self.value = value
		self.parent = parent
	}
}
