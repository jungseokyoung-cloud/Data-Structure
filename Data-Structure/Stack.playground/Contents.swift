var staticStack = StaticStack<Int>(capacity: 5)

staticStack.push(1)
staticStack.push(2)
staticStack.push(3)
staticStack.top

staticStack.push(4)
staticStack.push(5)
staticStack.top

staticStack.pop()
staticStack.top

staticStack.pop()
staticStack.pop()
staticStack.pop()
staticStack.pop()
staticStack.pop()
staticStack.pop()
staticStack.pop()
staticStack.pop()
staticStack.push(1)
staticStack.push(2)
staticStack.push(3)
staticStack.push(4)
staticStack.push(5)
// staticStack.push(5) // stack overflow 발생
