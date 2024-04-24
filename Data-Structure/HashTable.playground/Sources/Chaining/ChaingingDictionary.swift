public struct ChaingingDictionary<Key, Value> where Key: Hashable {
	typealias Element = ChainingElement<Key, Value>
	
	/// HashTable의 LoadFactor가 3이상일 경우 rehash가 일어납니다.
	private let maxLoadFactor: Double = 3
	
	/// 현재 HashTable의 loadFactor를 표시합니다.
	public var loadFactor: Double { Double(count) / Double(bucketCount)}
	
	/// HashTable의 Bucket의 숫자를 리턴합니다.
	private var bucketCount: Int
	
	/// HashTable내의 모든 값들의 개수를 리턴합니다.
	public private(set) var count: Int = 0
	
	private var buckets: [HashTableLinkedList<Element>]
	
	public init(bucketCount: Int = 23) {
		self.bucketCount = bucketCount
		self.buckets = Array(repeating: HashTableLinkedList<Element>(), count: bucketCount)
	}
	
	public subscript(key: Key) -> Value? {
		get {
			return find(for: key)
		}
		mutating set {
			if let newValue = newValue {
				insert(newValue, with: key)
			} else {
				delete(for: key)
			}
		}
	}
}

// MARK: - Public Methods
public extension ChaingingDictionary {
	mutating func insert(_ value: Value, with key: Key) {
		let index = index(for: key)
		
		if let node = buckets[index].find(for: key) {
			node.data.value = value
		} else {
			buckets[index].append(.init(key: key, value: value))
			count += 1
		}
		
		if loadFactor >= maxLoadFactor {
			rehash(bucketCount: bucketCount * 2)
		}
	}
	
	@discardableResult
	mutating func delete(for key: Key) -> Value? {
		let index = index(for: key)
		
		guard let node = buckets[index].find(for: key) else { return nil }
		
		count -= 1
		return buckets[index].remove(at: node)?.value
	}
	
	func find(for key: Key) -> Value? {
		let index = index(for: key)
		
		return buckets[index].find(for: key)?.data.value
	}
}

// MARK: - Private Methods
private extension ChaingingDictionary {
	func index(for key: Key) -> Int {
		return abs(key.hashValue) % bucketCount
	}
	
	mutating func rehash(bucketCount: Int) {
		var newBuckets = Array(repeating: HashTableLinkedList<Element>(), count: bucketCount)
		
		self.bucketCount = bucketCount
		
		buckets.forEach { bucket in
			bucket.forEach { node in
				let key = node.data.key
				let value = node.data.value
				let index = index(for: key)
				
				newBuckets[index].append(.init(key: key, value: value))
			}
		}
		
		self.buckets = newBuckets
	}
}
