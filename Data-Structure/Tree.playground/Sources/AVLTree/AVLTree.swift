public class AVLTree<T: Comparable>: BinarySearchTree<T> {
	/// tree에 값을 추가합니다.
	public override func insert(_ value: T) {
		let insertNode = super.performInsert(value)
		var current = insertNode
		
		while let temp = current {
			current = self.balance(for: temp).parent
		}
	}
	
	public override func remove(_ value: T) -> T? {
		guard let removeNode = search(value) else { return nil }
		
		defer { 
			let node = super.performRemove(node: removeNode)
			var current = node
			
			while let temp = current {
				current = self.balance(for: temp).parent
			}
		}
		
		return removeNode.value
	}
}

private extension AVLTree {
	/// 균형을 잡힌 서브트리의 루트노드를 리턴합니다.
	func balance(for node: Node<T>) -> Node<T> {
		let node = rotate(for: node)
		updateHeight(for: node)
		return node
	}
	
	/// 회전을 한 후, 회전을 진행한 서브트리의 루트노드를 리턴합니다.
	func rotate(for node: Node<T>) -> Node<T> {
		guard node.balanceFactor > 1 || node.balanceFactor < -1 else { return node }
		if node.balanceFactor == 2, let rightChild = node.right {
			// RL Case
			if let leftChild = rightChild.left {
				let pivot = rightRotate(for: rightChild, pivot: leftChild)
				return leftRotate(for: node, pivot: pivot)
				
			// RR Case
			} else {
				return leftRotate(for: node, pivot: rightChild)
			}
		
		} else if node.balanceFactor == -2, let leftChild = node.left {
			// LR Case
			if let rightChild = leftChild.right {
				let pivot = leftRotate(for: leftChild, pivot: rightChild)
				return rightRotate(for: node, pivot: pivot)
				
			// LL Case
			} else {
				return rightRotate(for: node, pivot: leftChild)
			}
		}
		
		return node
	}
	
	@discardableResult
	func leftRotate(for node: Node<T>, pivot: Node<T>) -> Node<T> {
		node.right = pivot.left
		node.right?.parent = node
		
		if node.isRightChild {
			node.parent?.right = pivot
		} else {
			node.parent?.left = pivot
		}
		pivot.parent = node.parent
		pivot.left = node
		node.parent = pivot
		
		if node === root { setRoot(to: pivot) }
		
		updateHeight(for: node)
		updateHeight(for: pivot)
		
		return pivot
	}

	@discardableResult
	func rightRotate(for node: Node<T>, pivot: Node<T>) -> Node<T> {
		node.left = pivot.right
		node.left?.parent = node
		
		if node.isRightChild {
			node.parent?.right = pivot
		} else {
			node.parent?.left = pivot
		}
		pivot.parent = node.parent
		pivot.right = node
		node.parent = pivot
		
		if node === root { setRoot(to: pivot) }
		
		updateHeight(for: node)
		updateHeight(for: pivot)
		
		return pivot
	}
	
	func updateHeight(for node: Node<T>) {
		node.height = max(node.left?.height ?? 0, node.right?.height ?? 0) + 1
	}
}
