/*
 SimpleLinkedList
 */
var simple = SimpleLinkedList<Int>()
simple.append(1)
let node = simple.node(at: 0)!

simple.remove(after: node)
simple.append(2)
simple.remove(after: node)
simple.travelsal()

simple.insert(20, after: node)
simple.insert(100, after: node)
simple.travelsal()

simple.remove(after: node)
simple.travelsal()

simple.pop_back()
simple.pop_front()
simple.travelsal()

simple.remove(after: node)
simple.travelsal()
