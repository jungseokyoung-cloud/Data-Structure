struct ChainingElement<Key, Value> where Key: Hashable {
	var key: Key
	var value: Value
}

extension ChainingElement: Dictionable {}
