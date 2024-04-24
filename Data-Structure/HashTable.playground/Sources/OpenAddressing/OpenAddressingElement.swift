struct OpenAddressingElement<Key, Value> where Key: Hashable {
	var key: Key
	var value: Value
	var isDeleted: Bool = false
	
	init(key: Key, value: Value) {
		self.key = key
		self.value = value
	}
}

extension OpenAddressingElement: Dictionable { }
