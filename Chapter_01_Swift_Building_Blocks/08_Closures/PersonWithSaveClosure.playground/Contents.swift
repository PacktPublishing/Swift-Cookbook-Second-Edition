
struct PersonName {
    let givenName: String
    let middleName: String
    var familyName: String
    
    func fullName() -> String {
        return "\(givenName) \(middleName) \(familyName)"
    }
    
    mutating func change(familyName: String) {
        self.familyName = familyName
    }
}

class Person {
    
    let birthName: PersonName
    var currentName: PersonName
    var countryOfResidence: String
    
    init(name: PersonName, countryOfResidence: String = "UK") {
        birthName = name
        currentName = name
        self.countryOfResidence = countryOfResidence
    }
    
    var displayString: String {
        return "\(currentName.fullName()) - Location: \(countryOfResidence)"
    }
    
    var saveHandler: ((Bool) -> Void)?
    
    func saveToRemoteDatabase(handler: @escaping (Bool) -> Void) {
        saveHandler = handler
        // Send person information to remove database
        // Once remote save is complete, it calls saveComplete(Bool)
    }
    
    func saveComplete(success: Bool) {
        saveHandler?(success)
    }
}

// String inputs, Person output
let createPerson: (String, String, String) -> Person = { given, middle, family in
    let name = PersonName(givenName: given, middleName: middle, familyName: family)
    let person = Person(name: name)
    return person
}

let dave = createPerson("David", "Ernest", "Moon")
dave.saveToRemoteDatabase(handler: { success in
    print("Saved finished. Successful: \(success))")
})
