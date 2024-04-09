/*:
 ### Content
 1. [Static Array Stack](static-array-stack)
 2. [Linked List Stack](linked-list-stack)
 3. [Dynamic Array Stack](dynamic-array-stack)
 */

//:### Static Array Stack
var staticStack = StaticStack<Int>(capacity: 5)

staticStack.push(1)
staticStack.push(2)
staticStack.push(3)

staticStack.count // 3
staticStack.top // 3

staticStack.pop()
staticStack.pop()
staticStack.pop()
staticStack.pop()

staticStack.count // 0
staticStack.top // nil

staticStack.push(1)
staticStack.push(2)
staticStack.push(3)
staticStack.push(4)
staticStack.push(5)
// staticStack.push(6) // stack overflow 발생

//:### Linked List Stack
var linkedStack = LinkedStack<Int>()

linkedStack.push(1)
linkedStack.push(2)
linkedStack.push(3)

linkedStack.count // 3
linkedStack.top // 3

linkedStack.pop()

linkedStack.count // 2
linkedStack.top // 2

linkedStack.pop()
linkedStack.pop()
linkedStack.pop()

linkedStack.count // 0
linkedStack.top // nil

linkedStack.push(4)
linkedStack.push(5)
linkedStack.push(6)

//:### Dynamic Array Stack
var dynamicStack = DynamicStack<Int>()

dynamicStack.push(1)
dynamicStack.push(2)
dynamicStack.push(2)

dynamicStack.pop()
dynamicStack.count
dynamicStack.pop()
dynamicStack.pop()
dynamicStack.count

