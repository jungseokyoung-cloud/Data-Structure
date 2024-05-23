/*:
 ### Content
 1. [Binary Search Tree](Binary-Search-Tree)
 2. [AVL Tree](AVL-Tree)
 */
//:### Binary Search Tree
var tree = BinarySearchTree<Int>()
tree.insert(10)
tree.insert(20)
tree.insert(16)
tree.insert(18)

tree.insert(30)

tree.insert(40)

tree.insert(5)

print(tree.description)

tree.remove(20)

print(tree.description)

//:### AVL Tree
var avlTree = AVLTree<Int>()
avlTree.insert(10)
avlTree.insert(20)
avlTree.insert(30)
avlTree.insert(18)
avlTree.insert(40)
avlTree.insert(5)

print(avlTree.description)

avlTree.remove(20)

print(avlTree.description)
