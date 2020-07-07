
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
}

//alissa.birthName.change(familyName: "Moon") // Does not compile. Compiler tells you to change let to var 

var name = PersonName(givenName: "Alissa", middleName: "May", familyName: "Jones")
let alissa = Person(name: name)
print(alissa.currentName.fullName()) // Alissa May Jones

print(alissa.birthName.fullName()) // Alissa May Jones
print(alissa.currentName.fullName()) // Alissa May Jones
alissa.currentName.change(familyName: "Moon")
print(alissa.birthName.fullName()) // Alissa May Jones
print(alissa.currentName.fullName()) // Alissa May Moon
