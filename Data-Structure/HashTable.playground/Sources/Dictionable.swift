protocol Dictionable {
	associatedtype Key: Hashable
	associatedtype Value
	var key: Key { get set }
	var value: Value { get set }
}
