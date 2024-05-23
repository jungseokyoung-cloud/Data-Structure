public class AVLTree<T: Comparable>: BinarySearchTree<T> {
	/// tree에 값을 추가합니다.
	public override func insert(_ value: T) {
		super.insert(value)
		
		if let root = self.root {
			self.balance(for: root)
		}
	}
	
	public override func remove(_ value: T) -> T? {
		let value = super.remove(value)

		if let root = self.root {
			self.balance(for: root)
		}
		
		return value
	}
}

private extension AVLTree {
	func balance(for node: Node<T>) {
		if let leftChild = node.left {
			balance(for: leftChild)
		} else if let rightChild = node.right{
			balance(for: rightChild)
		}
		
		rotate(for: node)
		updateHeight(for: node)
	}
	
	func rotate(for node: Node<T>) {
		guard node.balanceFactor > 1 || node.balanceFactor < -1 else { return }
		
		if node.balanceFactor == 2, let rightChild = node.right {
			// RL Case
			if let leftChild = rightChild.left {
				rightRotate(for: rightChild, pivot: leftChild)
				leftRotate(for: node, pivot: leftChild)
				
			// RR Case
			} else {
				leftRotate(for: node, pivot: rightChild)
			}
		
		} else if node.balanceFactor == -2, let leftChild = node.left {
			// LR Case
			if let rightChild = node.right, rightChild.balanceFactor == 1 {
				leftRotate(for: leftChild, pivot: rightChild)
				rightRotate(for: node, pivot: leftChild)
				
			// LL Case
			} else {
				rightRotate(for: node, pivot: leftChild)
			}
		}
	}
	
	func leftRotate(for node: Node<T>, pivot: Node<T>) {
		node.right = pivot.left
		pivot.left = node
		
		if node.isRightChild {
			node.parent?.right = pivot
		} else {
			node.parent?.left = pivot
		}
		
		pivot.parent = node.parent
		node.parent = pivot
		
		if node === root { setRoot(to: pivot) }
		
		updateHeight(for: node)
		updateHeight(for: pivot)
	}
	
	func rightRotate(for node: Node<T>, pivot: Node<T>) {
		node.left = pivot.right
		pivot.right = node
		
		if node.isRightChild {
			node.parent?.right = pivot
		} else {
			node.parent?.left = pivot
		}

		pivot.parent = node.parent
		node.parent = pivot
		
		if node === root { setRoot(to: pivot) }
		
		updateHeight(for: node)
		updateHeight(for: pivot)
	}
	
	func updateHeight(for node: Node<T>) {
		node.height = max(node.left?.height ?? 0, node.right?.height ?? 0) + 1
	}
}
