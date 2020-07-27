
infix operator >>>

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

let appendedString = "Two" >>> "One"
print(appendedString)

let appendedStringToArray = "three" >>> ["one", "two"]
print(appendedStringToArray)

let appendedArray = ["three", "four"] >>> ["one", "two"]
print(appendedArray)


struct Task {
    let name: String
}

class TaskList: CustomStringConvertible {
    private var tasks: [Task] = []
    func append(task: Task) {
        tasks.append(task)
    }
    var description: String {
        return tasks.map { $0.name }.joined(separator: "\n")
    }
}

extension TaskList {
    static func >>> (lhs: Task, rhs: TaskList) {
        rhs.append(task: lhs)
    }
}

let shoppingList = TaskList()
print(shoppingList)
Task(name: "get milk") >>> shoppingList
print(shoppingList)
Task(name: "get teabags") >>> shoppingList
print(shoppingList)

