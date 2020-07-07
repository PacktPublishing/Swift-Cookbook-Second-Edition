
infix operator >>> : AppendingPrecedence

precedencegroup AppendingPrecedence {
    associativity: left
    higherThan: AdditionPrecedence
    lowerThan: MultiplicationPrecedence
}

func >>> (lhs: String, rhs: String) -> String {
    var combined = rhs
    combined.append(lhs)
    return combined
}

func >>> <Element>(lhs: Element, rhs: Array<Element>) -> Array<Element> {
    var combined = rhs
    combined.append(lhs)
    return combined
}

func >>> <Element>(lhs: Array<Element>, rhs: Array<Element>) -> Array<Element> {
    var combined = rhs
    combined.append(contentsOf: lhs)
    return combined
}

let multiOperationArray = [5,6] >>> [3,4] >>> [1,2] + [9,10] >>> [7,8]
print(multiOperationArray) // [1,2,3,4,5,6,7,8,9,10]
