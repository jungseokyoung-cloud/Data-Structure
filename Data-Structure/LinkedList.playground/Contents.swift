/*
 SimpleLinkedList
 */
var simple = SimpleLinkedList<Int>()
simple.append(1)

simple.remove(after: simple.node(at: 0)!)
simple.append(2)
simple.remove(after: simple.node(at: 0)!)
simple.travelsal()

simple.insert(20, after: simple.node(at: 0)!)
simple.insert(100, after: simple.node(at: 0)!)
simple.travelsal()

simple.remove(after: simple.node(at: 0)!)
simple.travelsal()

simple.pop_back()
simple.pop_back()
simple.pop_back()
simple.pop_back()

simple.pop_front()
simple.travelsal()
simple.append(2)

simple.travelsal()
