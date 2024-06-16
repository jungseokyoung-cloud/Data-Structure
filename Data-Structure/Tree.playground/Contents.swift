/*:
 ### Content
 1. [Binary Search Tree](Binary-Search-Tree)
 2. [AVL Tree](AVL-Tree)
 3. [RB Tree](RB-Tree)
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

tree.remove(10)

print(tree.description)

tree.remove(20)

print(tree.description)

tree.remove(16)
print(tree.description)

//:### AVL Tree
var avlTree = AVLTree<Int>()
avlTree.insert(10)
avlTree.insert(20)
avlTree.insert(30)
print(avlTree.description)

avlTree.insert(18)
print(avlTree.description)

avlTree.remove(20)

print(avlTree.description)


avlTree.insert(19)
avlTree.insert(5)
avlTree.insert(21)
print(avlTree.description)

avlTree.remove(19)
print(avlTree.description)

avlTree.remove(21)
print(avlTree.description)

//:### RB Tree
var rbTree = RedBlackTree<Int>()
rbTree.insert(80)
rbTree.insert(40)
rbTree.insert(35)
rbTree.insert(25)
print(rbTree.description)

rbTree.remove(40)
print(rbTree.description)

rbTree.remove(25)
print(rbTree.description)
