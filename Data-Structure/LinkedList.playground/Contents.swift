/*:
 ### Content
 1. [Simple Linked List](simple-linked-list)
 2. [Circuluar Linked List](circular-linked-list)
 3. [Double Linked List](Double-Linked-List)
 */

//:### Simple Linked List
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

//:### Circular Linked List
var circle = CircularLinkedList<Int>()

circle.append(1)
circle.append(2)
circle.append(3)

circle.insert(10, after: circle.node(at: 2)!)

circle.pop_front()
circle.pop_back()
circle.pop_front()
circle.pop_back()
circle.travelsal()

circle.append(1)
circle.append(2)
circle.append(3)

circle.remove(after: circle.node(at: 0)!)
circle.travelsal()

//:### Double Linked List
var double = DoubleLinkedList<Int>()

double.append(1)

double.append(2)
double.append(2)
double.append(3)
double.append(2)
double.append(2)
double.append(2)


double.remove(after: double.node(at: 2)!)
double.insert(10, after: double.find(2)!)

double.travalsel()

double.pop_back()
double.travalsel()

double.append(10)
double.travalsel()

