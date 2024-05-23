final class Node<T: Comparable> {
	var value: T
	var left: Node?
	var right: Node?
	var height: Int
	
	weak var parent: Node?
	
	init(value: T, height: Int = 0) {
		self.value = value
		self.height = height
	}
	
	init(value: T, parent: Node<T>?, height: Int = 0) {
		self.value = value
		self.parent = parent
		self.height = height
	}
}

// MARK: - Extension
extension Node {
	var balanceFactor: Int {
		return (self.right?.height ?? 0) - (self.left?.height ?? 0)
	}
	
	var isRoot: Bool {
		parent == nil
	}
	
	var isLeaf: Bool {
		self.right == nil && self.left == nil
	}
	
	var isLeftChild: Bool {
		parent?.left === self
	}
	
	var isRightChild: Bool {
		parent?.right === self
	}
	
	var hasLeftChild: Bool {
		self.left != nil
	}
}
