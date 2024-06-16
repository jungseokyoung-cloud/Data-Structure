import Foundation

class Node<T: Comparable> {
	var value: T
	var left: Node?
	var right: Node?
	
	weak var parent: Node?
	
	required init(value: T) {
		self.value = value
	}
	
	required init(value: T, parent: Node<T>?) {
		self.value = value
		self.parent = parent
	}
}

// MARK: - Extension
extension Node {
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
	
	var uncle: Node? {
		guard
			let parent = parent,
			let grandParent = parent.parent
		else { return nil }
		
		return parent.isLeftChild ? grandParent.right : grandParent.left
	}
	
	var sibling: Node? {
		guard let parent = parent else { return nil }
		
		return isLeftChild ? parent.right : parent.left
	}
}
