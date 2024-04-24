public struct OpenAddressingDictionary<Key, Value> where Key: Hashable {
	typealias Element = OpenAddressingElement<Key, Value>
	
	/// HashTable의 LoadFactor가 3이상일 경우 rehash가 일어납니다.
	private let maxLoadFactor: Double = 0.75
	
	/// 현재 HashTable의 loadFactor를 표시합니다.
	public var loadFactor: Double { Double(count) / Double(bucketCount)}
	
	/// HashTable의 Bucket의 숫자를 리턴합니다.
	private var bucketCount: Int
	
	/// HashTable내의 모든 값들의 개수를 리턴합니다.
	public private(set) var count: Int = 0
	
	private var buckets: [Element?]
	
	public init(bucketCount: Int = 23) {
		self.bucketCount = bucketCount
		self.buckets = Array(repeating: nil, count: bucketCount)
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
public extension OpenAddressingDictionary {
	mutating func insert(_ value: Value, with key: Key) {
		let index = index(for: key)
		
		if let findIndex = findIndex(key: key, index: index) {
			buckets[findIndex]?.value = value
		} else if let insertIndex = findAvailableIndex(from: index) {
			buckets[insertIndex] = .init(key: key, value: value)
			count += 1
		}
		
		if loadFactor >= maxLoadFactor {
			rehash(bucketCount: bucketCount * 2)
		}
	}
	
	@discardableResult
	mutating func delete(for key: Key) -> Value? {
		let index = index(for: key)
		
		guard let findIndex = findIndex(key: key, index: index) else { return nil }
		
		buckets[findIndex]?.isDeleted = true
		count -= 1
		return buckets[findIndex]?.value
	}
	
	func find(for key: Key) -> Value? {
		let index = index(for: key)
		
		guard let findIndex = findIndex(key: key, index: index) else { return nil }
		
		return buckets[findIndex]?.value
	}
}

// MARK: - Private Methods
private extension OpenAddressingDictionary {
	func index(for key: Key) -> Int {
		return abs(key.hashValue) % bucketCount
	}
	
	func nextIndex(from index: Int) -> Int {
		return (index + 1) % bucketCount
	}
	
	/// Linear Porbing을 통해 삽입 가능한 인덱스를 찾습니다.
	func findAvailableIndex(from index: Int) -> Int? {
		var index = index
		var count = 1
		
		while
			let element = buckets[index],
			!element.isDeleted {
			index = nextIndex(from: index)
			count += 1
			
			// 한바퀴 돈 경우
			if count > bucketCount { return nil }
		}
		
		return index
	}
	
	/// Linear Probing을 통해 `key`에 해당되는 원소의 인덱스를 리턴합니다.
	func findIndex(key: Key, index: Int) -> Int? {
		guard buckets[index] != nil else { return nil }
		
		var index = index
		var count = 1
		
		while let element = buckets[index] {
			if element.key == key, !element.isDeleted {
				return index
			}
			
			index = nextIndex(from: index)
			count += 1
			
			if count > bucketCount { return nil }
		}
		
		return nil
	}
	
	mutating func rehash(bucketCount: Int) {
		let currentBuckets = buckets
		
		buckets = Array(repeating: nil, count: bucketCount * 2)
		self.bucketCount = bucketCount * 2
		
		
		currentBuckets.forEach { element in
			if let element = element, !element.isDeleted {
				insert(element.value, with: element.key)
			}
		}
	}
}
