class AVLNode<T: Comparable>: Node<T> {
  var height: Int
	
	required init(value: T) {
		self.height = 0
		super.init(value: value)
	}
	
	required init(value: T, parent: Node<T>?) {
		self.height = 0
		super.init(value: value, parent: parent)
	}
}

// MARK: - Extension
extension AVLNode {
	var balanceFactor: Int {
		return ((self.right as? AVLNode<T>)?.height ?? 0) - ((self.left as? AVLNode<T>)?.height ?? 0)
	}
}
