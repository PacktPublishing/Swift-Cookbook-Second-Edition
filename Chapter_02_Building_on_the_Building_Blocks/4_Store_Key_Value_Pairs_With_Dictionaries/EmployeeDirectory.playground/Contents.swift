
struct PersonName {
    let givenName: String
    let familyName: String
}

enum CommunicationMethod {
    case phone
    case email
    case textMessage
    case fax
    case telepathy
    case subSpaceRelay
    case quantumEntanglement
}

class Person {
    let name: PersonName
    let preferredCommunicationMethod: CommunicationMethod
    
    convenience init(givenName: String, familyName: String, commsMethod: CommunicationMethod) {
        let name = PersonName(givenName: givenName, familyName: familyName)
        self.init(name: name, commsMethod: commsMethod)
    }
    
    init(name: PersonName, commsMethod: CommunicationMethod) {
        self.name = name
        preferredCommunicationMethod = commsMethod
    }
}

var crewDirectory = Dictionary<String, Person>()

crewDirectory["Captain"] = Person(givenName: "Jean-Luc", familyName: "Picard", commsMethod: .phone)
crewDirectory["First Officer"] = Person(givenName: "William", familyName: "Riker", commsMethod: .email)
crewDirectory["Chief Engineer"] = Person(givenName: "Georgi", familyName: "LaForge", commsMethod: .textMessage)
crewDirectory["Second Officer"] = Person(givenName: "Data", familyName: "Soong", commsMethod: .fax)
crewDirectory["Councillor"] = Person(givenName: "Deanna", familyName: "Troy", commsMethod: .telepathy)
crewDirectory["Security Officer"] = Person(givenName: "Tasha", familyName: "Yar", commsMethod: .subSpaceRelay)
crewDirectory["Chief Medical Officer"] = Person(givenName: "Beverly", familyName: "Crusher", commsMethod: .quantumEntanglement)

let roles = Array(crewDirectory.keys)
print(roles)

let firstRole = roles.first! // Chief Medical Officer
let cmo = crewDirectory[firstRole]! // Person: Beverly Crusher
print("\(firstRole): \(cmo.name.givenName) \(cmo.name.familyName)") // Chief Medical Officer: Beverly Crusher

print(crewDirectory["Security Officer"]!.name.givenName) // Tasha
crewDirectory["Security Officer"] = Person(givenName: "Worf", familyName: "Son of Mogh", commsMethod: .subSpaceRelay)
print(crewDirectory["Security Officer"]!.name.givenName) // Worf
