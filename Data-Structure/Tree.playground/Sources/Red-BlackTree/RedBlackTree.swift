public final class RedBlackTree<T: Comparable>: BinarySearchTree<T> {
	override var nodeType: Node<T>.Type { RedBlackNode<T>.self }

	public override func insert(_ value: T) {
		guard let node = super.performInsert(value) as? RedBlackNode<T> else { return }
		
		insertBalancing(for: node)
	}
	
	public override func remove(_ value: T) -> T? {
		guard let removeNode = search(value) else { return nil }

		// 삭제되는 노드, 대체되는 노드
		let removedReturnType = super.performRemove(node: removeNode)
		removeBalancing(
			removedNode: removedReturnType.removedNode,
			replaceNode: removedReturnType.replaceNode,
			parentNode: removedReturnType.parentNode
		)
		
		return removeNode.value
	}
}

// MARK: - Insert Balancing Methods
private extension RedBlackTree {
	@discardableResult
	func insertBalancing(for node: RedBlackNode<T>) -> RedBlackNode<T>? {
		guard node !== root else {
			node.isRed = false
			return node
		}
		
		// 연속해서 빨간색이 나오지 않는 경우, 종료
		guard
			let parent = node.parent as? RedBlackNode<T>,
			parent.isRed 
		else { return node }
		
		if let uncle = node.uncle as? RedBlackNode<T>, uncle.isRed {
			return recoloring(for: node)
		} else {
			return restructuring(for: node)
		}
	}
	
	@discardableResult
	func restructuring(for node: RedBlackNode<T>) -> RedBlackNode<T>? {
		guard
			let parent = node.parent as? RedBlackNode<T>,
			let grandParent = parent.parent as? RedBlackNode<T>
		else { return node }
		grandParent.isRed = true

		// LL Case
		if node.isLeftChild && parent.isLeftChild {
			parent.isRed = false
			return rightRotate(for: grandParent, pivot: parent)
			
		// RR Case
		} else if node.isRightChild && parent.isRightChild {
			parent.isRed = false
			return leftRotate(for: grandParent, pivot: parent)
			
		// LR Case
		} else if node.isRightChild && parent.isLeftChild {
			node.isRed = false
			let pivot = leftRotate(for: parent, pivot: node)
			return rightRotate(for: grandParent, pivot: pivot)
			
		// RL Case
		} else {
			node.isRed = false
			let pivot = rightRotate(for: parent, pivot: node)
			return leftRotate(for: grandParent, pivot: pivot)
		}
	}
	
	@discardableResult
	func recoloring(for node: RedBlackNode<T>) -> RedBlackNode<T>? {
		guard
			let parent = node.parent as? RedBlackNode<T>,
			let grandParent = parent.parent as? RedBlackNode<T>,
			let uncle = node.uncle as? RedBlackNode<T>
		else { return node }
		
		grandParent.isRed = true
		parent.isRed = false
		uncle.isRed = false
		
		return insertBalancing(for: grandParent)
	}
}

// MARK: - Remove Balancing Methods
private extension RedBlackTree {
	///	삭제되었을 때의 balancing을 해줍니다.
	/// - Parameters:
	/// 	- removeNode: 삭제된 노드
	/// 	- replaceNode: 삭제된 노드의 위치에 대체된 노드
	func removeBalancing(
		removedNode: Node<T>?,
		replaceNode: Node<T>?,
		parentNode: Node<T>?
	) {
		guard let node = removedNode as? RedBlackNode<T>, !node.isRed else { return }
		
		// 삭제된 노드가 검정색이라면, Extra-Black을 부여
		removeExtraBlack(parent: parentNode, replaceNode: replaceNode)
		
		(root as? RedBlackNode<T>)?.isRed = false
	}
	
	func removeExtraBlack(parent: Node<T>?, replaceNode: Node<T>?) {
		// Red-And-Black Node
		if let replaceNode = replaceNode as? RedBlackNode<T>, replaceNode.isRed {
			replaceNode.isRed = false
		} else {
			removeDoublyBlack(parent: parent, doublyBlack: replaceNode)
		}
	}
	
	func removeDoublyBlack(parent: Node<T>?, doublyBlack: Node<T>?) {
		guard
			let parent = parent as? RedBlackNode<T>,
			let sibling = (parent.left === doublyBlack ? parent.right : parent.left) as? RedBlackNode<T>
		else { return }
		
		if !sibling.isRed {
			if 
				let sibilingChild = (sibling.isLeftChild ? sibling.left : sibling.right) as? RedBlackNode<T>,
				sibilingChild.isRed {
				removeCase4(
					parent: parent,
					sibling: sibling,
					child: sibilingChild
				)
			} else if
				let sibilingChild = (sibling.isLeftChild ? sibling.right : sibling.left) as? RedBlackNode<T>,
				sibilingChild.isRed {
				removeCase3(
					parent: parent,
					sibling: sibling,
					child: sibilingChild
				)
			} else {
				removeCase2(parent: parent, sibling: sibling)
			}
		} else {
			removeCase1(parent: parent, sibling: sibling, node: doublyBlack as? RedBlackNode<T>)
		}
	}

	// 형제노드가 검정, 형제의  자식이 빨간 경우
	func removeCase4(
		parent: RedBlackNode<T>,
		sibling: RedBlackNode<T>,
		child: RedBlackNode<T>
	) {
		sibling.isRed = parent.isRed
		
		child.isRed = false
		parent.isRed = false
		
		if sibling.isLeftChild {
			rightRotate(for: parent, pivot: sibling)
		} else {
			leftRotate(for: parent, pivot: sibling)
		}
	}
	
	// 형제노드가 검정, 형제의 왼쪽 자식은 빨간, 오른쪽 자식은 검은색
	func removeCase3(
		parent: RedBlackNode<T>,
		sibling: RedBlackNode<T>,
		child: RedBlackNode<T>
	) {
		sibling.isRed = true
		child.isRed = false
		
		if sibling.isLeftChild {
			leftRotate(for: sibling, pivot: child)
		} else {
			rightRotate(for: sibling, pivot: child)
		}
		
		guard
			let newChild = (sibling.isLeftChild ? child.left : child.right) as? RedBlackNode<T>
		else { return }
		
		removeCase4(parent: parent, sibling: child, child: newChild)
	}
	
	func removeCase2(parent: RedBlackNode<T>, sibling: RedBlackNode<T>) {
		sibling.isRed.toggle()
		// 부모에게 Extra-Black을 위임
		removeExtraBlack(parent: parent.parent, replaceNode: parent)
	}
	
	func removeCase1(parent: RedBlackNode<T>, sibling: RedBlackNode<T>, node: RedBlackNode<T>?) {
		parent.isRed = true
		sibling.isRed = false
		
		if sibling.isLeftChild {
			rightRotate(for: parent, pivot: sibling)
		} else {
			leftRotate(for: parent, pivot: sibling)
		}
		
		removeDoublyBlack(parent: parent, doublyBlack: node)
	}
}

// MARK: - Utils
private extension RedBlackTree {
	@discardableResult
	func leftRotate(for node: RedBlackNode<T>, pivot: RedBlackNode<T>) -> RedBlackNode<T> {
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
		
		return pivot
	}
	
	@discardableResult
	func rightRotate(for node: RedBlackNode<T>, pivot: RedBlackNode<T>) -> RedBlackNode<T> {
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
		
		return pivot
	}
}
