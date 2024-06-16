import Foundation

final class RedBlackNode<T: Comparable>: Node<T> {
	var isRed: Bool = true
	
	required init(value: T) {
		super.init(value: value)
	}
	
	required init(value: T, parent: Node<T>?) {
		super.init(value: value, parent: parent)
	}
}
