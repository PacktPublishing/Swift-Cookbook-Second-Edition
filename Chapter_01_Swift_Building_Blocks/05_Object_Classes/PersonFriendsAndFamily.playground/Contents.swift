
class Person {
    
    let givenName: String
    let middleName: String
    let familyName: String
    var countryOfResidence: String = "UK"
    
    init(givenName: String, middleName: String, familyName: String) {
        self.givenName = givenName
        self.middleName = middleName
        self.familyName = familyName
    }
    
    var displayString: String {
        return "\(fullName()) - Location: \(countryOfResidence)"
    }
    
    func fullName() -> String {
        return "\(givenName) \(middleName) \(familyName)"
    }
}

final class Friend: Person {
    var whereWeMet: String?
    
    override var displayString: String {
        return "\(super.displayString) - \(whereWeMet ?? "Don't know where we met")"
    }
}

final class Family: Person {
    let relationship: String
    
    init(givenName: String, middleName: String, familyName: String = "Moon", relationship: String) {
        self.relationship = relationship
        super.init(givenName: givenName, middleName: middleName, familyName: familyName)
    }
    
    override var displayString: String {
        return "\(super.displayString) - \(relationship)"
    }
}

let steve = Person(givenName: "Steven", middleName: "Paul", familyName: "Jobs")
let dan = Friend(givenName: "Daniel", middleName: "James", familyName: "Woodel")
dan.whereWeMet = "Worked together at BBC News"
let finnley = Family(givenName: "Finnley", middleName: "David", relationship: "Son")
let dave = Family(givenName: "Dave", middleName: "deRidder", familyName: "Jones", relationship: "Father-In-Law")
dave.countryOfResidence = "US"

print(steve.displayString) // Steven Paul Jobs
print(dan.displayString) // Daniel James Woodel - Worked together at BBC News
print(finnley.displayString) // Finnley David Moon - Son
