import Foundation

public class BinarySearchTree<T: Comparable> {
	/// 트리의 루트노드입니다.
	private(set) var root: Node<T>?
	
	public var isEmpty: Bool { size == 0 }
	
	public private(set) var size: Int = 0
	
	public init() { }
	
	// MARK: - Insert Method
	/// tree에 값을 추가합니다.
	public func insert(_ value: T) {
		performInsert(value)
	}
	
	/// Insert 작업을 수행한 후, 삽입된 노드를 리턴합니다.
	@discardableResult
	func performInsert(_ value: T) -> Node<T>? {
		guard let root else {
			self.root = Node(value: value)
			return root
		}
		
		// 이미 값이 존재하는 경우
		if let node = search(value) {
			node.value = value
			return node
		}
		
		var current = root
		size += 1
		while true {
			if current.value > value {
				if let next = current.left {
					current = next
				} else {
					let node = Node(value: value, parent: current)
					current.left = node
					
					return node
				}
			} else {
				if let next = current.right {
					current = next
				} else {
					let node = Node(value: value, parent: current)
					current.right = node
					
					return node
				}
			}
		}
	}
	
	// MARK: - Remove Method
	public func remove(_ value: T) -> T? {
		guard let node = search(value) else { return nil }
		
		defer { performRemove(node: node) }
		
		return node.value
	}
	
	/// Remove작업을 수행한 후, 삭제된 위치의 노드를 리턴합니다.
	@discardableResult
	func performRemove(node: Node<T>) -> Node<T>? {
		defer { size -= 1 }
		
		// 리프 노드인 경우
		if node.isLeaf {
			return removeLeafNode(node)
			
			// 왼쪽 자식만 존재하는 경우
		} else if let leftNode = node.left, node.right == nil {
			return removeOneChildNode(node, child: leftNode)
			
			// 오른쪽 자식만 존재하는 경우
		} else if let rightNode = node.right, node.left == nil {
			return removeOneChildNode(node, child: rightNode)
			
			// 자식이 두개인 노드인 경우
		} else {
			guard let rightNode = node.right else { return nil }
			let successor = successor(from: rightNode)
			
			return removeTwoChildNode(node, successor: successor)
		}
	}
	
	// MARK: - Contain
	public func contain(_ value: T) -> Bool {
		return search(value) != nil
	}
	
	func search(_ value: T) -> Node<T>? {
		guard root != nil else { return nil }
		
		var current = root
		
		while let node = current {
			if node.value == value { return node }
			
			if node.value > value {
				current = node.left
			} else {
				current = node.right
			}
		}
		
		return nil
	}
	
}

// MARK: - Private Methods
private extension BinarySearchTree {
	func removeLeafNode(_ node: Node<T>) -> Node<T>? {
		defer {
			if node.isLeftChild {
				node.parent?.left = nil
			} else {
				node.parent?.right = nil
			}
			
			if node === root { root = nil }
		}
		
		return node.parent
	}
	
	func removeOneChildNode(_ node: Node<T>, child: Node<T>) -> Node<T>? {
		defer {
			if node.isLeftChild {
				node.parent?.left = child
			} else {
				node.parent?.right = child
			}
			
			child.parent = node.parent
			
			if node === root { setRoot(to: child) }
		}
		
		return child
	}
	
	func removeTwoChildNode(_ node: Node<T>, successor: Node<T>) -> Node<T>? {
		var removedNode = successor.right == nil ? successor.parent : successor.right
		if removedNode === node { removedNode = successor }
		
		if node.isLeftChild {
			node.parent?.left = successor
		} else {
			node.parent?.right = successor
		}
		
		if successor.isLeftChild {
			successor.parent?.left = successor.right
			successor.right?.parent = successor.parent
		} else {
			successor.parent?.right = successor.right
			successor.right?.parent = successor.parent
		}
		
		successor.parent = node.parent
		successor.left = node.left
		successor.right = node.right
		
		successor.left?.parent = successor
		successor.right?.parent = successor
		
		if node === root { setRoot(to: successor) }
		
		return removedNode
	}
	
	func successor(from node: Node<T>) -> Node<T> {
		var current = node
		
		while let leftNode = current.left { current = leftNode }
		
		return current
	}
}

// MARK: - Internal Methods
extension BinarySearchTree {
	func setRoot(to node: Node<T>) {
		self.root = node
		root?.parent = nil
	}
}

// MARK: - CustomStringConvertible
extension BinarySearchTree: CustomStringConvertible {
	public var description: String {
		guard let root else { return "" }
		return treeString(root)
	}
}

// MARK: - treeString
private extension BinarySearchTree {
	func treeString(
		_ node: Node<T>,
		isTop: Bool = true
	) -> String {
		let stringValue = "\(node.value)"
		let leftNode = node.left
		let rightNode = node.right
		
		let stringValueWidth = stringValue.count
		
		var leftTextBlock: [String] = []
		
		if let leftNode = node.left {
			leftTextBlock = treeString(
				leftNode,
				isTop: false
			).components(separatedBy: "\n")
		}
		
		var rightTextBlock: [String] = []
		
		if let rightNode = node.right {
			rightTextBlock = treeString(
				rightNode,
				isTop: false
			).components(separatedBy:"\n")
		}
		let commonLines = min(leftTextBlock.count, rightTextBlock.count)
		let subLevelLines = max(rightTextBlock.count, leftTextBlock.count)
		
		let leftSubLines = leftTextBlock + Array(repeating: "", count: subLevelLines - leftTextBlock.count)
		let rightSubLines = rightTextBlock + Array(repeating: "", count: subLevelLines - rightTextBlock.count)
		
		let leftLineWidths = leftSubLines.map { $0.count }
		let rightLineIndents = rightSubLines.map { $0.prefix { $0==" " }.count }
		
		
		let firstLeftWidth = leftLineWidths.first ?? 0
		let firstRightIndent = rightLineIndents.first ?? 0
		
		let linkSpacing = min(stringValueWidth, 2 - stringValueWidth % 2)
		let leftLinkBar = leftNode  == nil ? 0 : 1
		let rightLinkBar = rightNode == nil ? 0 : 1
		let minLinkWidth = leftLinkBar + linkSpacing + rightLinkBar
		let valueOffset = (stringValueWidth - linkSpacing) / 2
		
		let minSpacing = 2
		let rightNodePosition = zip(leftLineWidths, rightLineIndents[0..<commonLines])
			.reduce(firstLeftWidth + minLinkWidth) {
				max($0, $1.0 + minSpacing + firstRightIndent - $1.1)
			}
		
		let linkExtraWidth = max(0, rightNodePosition - firstLeftWidth - minLinkWidth )
		let rightLinkExtra = linkExtraWidth / 2
		let leftLinkExtra = linkExtraWidth - rightLinkExtra
		
		let valueIndent = max(0, firstLeftWidth + leftLinkExtra + leftLinkBar - valueOffset)
		let valueLine = String(repeating:" ", count: max(0, valueIndent))
		+ stringValue
		let slash = "/"
		let backSlash =  "\\"
		let uLine =  "_"
		
		let leftLink = leftNode == nil ? "" : String(repeating: " ", count:firstLeftWidth) + String(repeating: uLine, count:leftLinkExtra) + slash
		
		let rightLinkOffset = linkSpacing + valueOffset * (1 - leftLinkBar)
		let rightLink = rightNode == nil ? "" : String(repeating: " ", count: rightLinkOffset) + backSlash + String(repeating: uLine, count: rightLinkExtra)
		
		let linkLine = leftLink + rightLink
		
		let leftIndentWidth = max(0, firstRightIndent - rightNodePosition)
		let leftIndent = String(repeating:" ", count:leftIndentWidth)
		let indentedLeftLines = leftSubLines.map { $0.isEmpty ? $0 : (leftIndent + $0) }
		
		let mergeOffsets = indentedLeftLines
			.map{ $0.count }
			.map{ leftIndentWidth + rightNodePosition - firstRightIndent - $0 }
			.enumerated()
			.map{ rightSubLines[$0].isEmpty ? 0 : $1 }
		
		let mergedSubLines = zip(mergeOffsets.enumerated(), indentedLeftLines)
			.map{ ( $0.0, $0.1, $1 + String(repeating:" ", count:max(0,$0.1)) ) }
			.map{ $2 + String(rightSubLines[$0].dropFirst(max(0,-$1))) }
		
		let treeLines = [leftIndent + valueLine]
		+ (linkLine.isEmpty ? [] : [leftIndent + linkLine])
		+ mergedSubLines
		
		return treeLines.joined(separator:"\n")
	}
}
