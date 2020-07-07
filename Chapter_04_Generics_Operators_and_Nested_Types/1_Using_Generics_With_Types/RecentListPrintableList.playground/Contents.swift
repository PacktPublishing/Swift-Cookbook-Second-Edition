
class RecentList<ListItemType: CustomStringConvertible> {
    
    var slot1: ListItemType?
    var slot2: ListItemType?
    var slot3: ListItemType?
    var slot4: ListItemType?
    var slot5: ListItemType?
    
    func add(recent: ListItemType) {
        // Move each slot down 1
        slot5 = slot4
        slot4 = slot3
        slot3 = slot2
        slot2 = slot1
        slot1 = recent
    }
    
    func getAll() -> [ListItemType] {
        var recent = [ListItemType]()
        if let slot1 = slot1 {
            recent.append(slot1)
        }
        if let slot2 = slot2 {
            recent.append(slot2)
        }
        if let slot3 = slot3 {
            recent.append(slot3)
        }
        if let slot4 = slot4 {
            recent.append(slot4)
        }
        if let slot5 = slot5 {
            recent.append(slot5)
        }
        return recent
    }
    
    func printRecentList() {
        for item in getAll() {
            let printableItem = String(describing: item)
            print(printableItem)
        }
    }
}

class Person {
    let name: String
    init(name: String) {
        self.name = name
    }
}

extension Person: CustomStringConvertible {
    public var description: String {
        return name
    }
}

// Using Strings type

let recentlyUsedWordList = RecentList<String>()
recentlyUsedWordList.add(recent: "First")
recentlyUsedWordList.add(recent: "Next")
recentlyUsedWordList.add(recent: "Last")
recentlyUsedWordList.printRecentList()
// Last
// Next
// First

// Using Person type

let rod = Person(name: "Rod")
let jane = Person(name: "Jane")
let freddy = Person(name: "Freddy")

let lastCalledList = RecentList<Person>()
lastCalledList.add(recent: freddy)
lastCalledList.add(recent: jane)
lastCalledList.add(recent: rod)
lastCalledList.printRecentList()
// Rod
// Jane
// Freddy
