/*:
 ### Content
 1. [Array Queue](array-queue)
 2. [Circular Queue](circular-queue)
 3. [Linked List Queue](linked-list-queue)
 4. [Double Stack Queue](double-stack-queue)
 */

//:### Array Queue
var arrayQueue = ArrayQueue<Int>()

arrayQueue.enqueue(1)
arrayQueue.enqueue(2)
arrayQueue.enqueue(3)
arrayQueue.enqueue(4)

arrayQueue.count // 4

arrayQueue.dequeue() // 1 dequeue
arrayQueue.isEmpty // false
arrayQueue.count // 3

arrayQueue.dequeue() // 2 dequeue
arrayQueue.dequeue() // 3 dequeue
arrayQueue.top // 4
arrayQueue.count // 1

arrayQueue.dequeue() // 4 dequeue
arrayQueue.isEmpty // true
arrayQueue.count // 0

arrayQueue.dequeue() // nil
arrayQueue.top // nil
arrayQueue.count // 0

//:### Circular Queue
var circular = CircularQueue<Int>(capacity: 3)
circular.enqueue(1)
circular.enqueue(2)
circular.enqueue(3)
circular.enqueue(4) // queue is full

circular.isEmpty // false
circular.count // 3

circular.dequeue() // 1 dequeue
circular.isEmpty // false
circular.count // 2
circular.top // 2

circular.dequeue() // 2 dequeue
circular.dequeue() // 3 dequeue
circular.isEmpty // true
circular.count // 0
circular.top // nil

//:### Linked List Queue
var linkedQueue = LinkedListQueue<Int>()

linkedQueue.enqueue(1)
linkedQueue.enqueue(2)
linkedQueue.enqueue(3)

linkedQueue.isEmpty // fasle
linkedQueue.count // 3

linkedQueue.dequeue() // 1 dequeue
linkedQueue.isEmpty //
linkedQueue.count
linkedQueue.top

linkedQueue.dequeue() // 2 dequeue
linkedQueue.dequeue() // 3 dequeue
linkedQueue.isEmpty // true
linkedQueue.count // 0
linkedQueue.top // nil

linkedQueue.dequeue() // nil

//:### Double Stack Queue
var doubleStack = DoubleStackQueue<Int>()

doubleStack.enqueue(1)
doubleStack.enqueue(2)
doubleStack.enqueue(3)

doubleStack.isEmpty // false
doubleStack.count // 3
doubleStack.top // 1

doubleStack.dequeue() // 1 dequeue
doubleStack.isEmpty // false
doubleStack.count // 2
doubleStack.top // 2

doubleStack.dequeue() // 2 dequeue
doubleStack.dequeue() // 3 dequeue
doubleStack.isEmpty // true
doubleStack.count // 0
doubleStack.top // nil

doubleStack.dequeue() // nil
