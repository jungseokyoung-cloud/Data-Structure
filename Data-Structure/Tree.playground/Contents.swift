var tree = BinarySearchTree<Int>()
tree.insert(10)
tree.insert(20)
tree.insert(16)
tree.insert(18)

tree.insert(30)

tree.insert(40)

tree.insert(5)

print(tree.description)

tree.remove(10)

print(tree.description)
