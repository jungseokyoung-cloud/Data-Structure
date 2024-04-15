public enum HeapType {
	case max
	case min
}

public struct Heap<T: Comparable> {
	private var nodes = [T]()
	private let sort: (T, T) -> Bool
	
	public var isEmpty: Bool {
		nodes.isEmpty
	}
	
	public var count: Int {
		nodes.count
	}
	
	public var peek: T? {
		nodes.first
	}
	
	public init(type: HeapType) {
		switch type {
			case .min:
				self.sort = { $0 < $1 }
			case .max:
				self.sort = { $0 > $1 }
		}
	}
}

// MARK: - Public Methods
public extension Heap {
	mutating func insert(_ element: T) {
		nodes.append(element)
		shiftUp()
	}
	
	mutating func pop() -> T? {
		guard !isEmpty else { return nil }
		
		defer {
			nodes.swapAt(0, nodes.count - 1)
			nodes.removeLast()
			shiftDown()
		}
		
		return nodes[0]
	}
}

// MARK: - Private Methods
private extension Heap {
	mutating func shiftUp() {
		var now = nodes.count - 1
		var parent = getParent(of: now)
		
		// now가 0인 경우는 트리의 루트에 도착한 경우, 부모 값과 비교해서 바꿔야 하는 경우
		while now > 0 && sort(nodes[now], nodes[parent]) {
			nodes.swapAt(now, parent)
			now = parent
			parent = getParent(of: now)
		}
	}
	
	mutating func shiftDown() {
		var now = 0
		while true {
			let (left, right) = getChilds(of: now)
			var candidate = now
			
			if left < nodes.count && sort(nodes[left], nodes[candidate]) {
				candidate = left
			}
			
			if right < nodes.count && sort(nodes[right], nodes[candidate]) {
				candidate = right
			}
			
			if candidate == now { return }
			
			nodes.swapAt(now, candidate)
			now = candidate
		}
		
	}
	
	func getParent(of node: Int) -> Int {
		return (node - 1) / 2
	}
	
	func getChilds(of node: Int) -> (left: Int, right: Int) {
		return (node * 2 + 1, node * 2 + 2)
	}
}


