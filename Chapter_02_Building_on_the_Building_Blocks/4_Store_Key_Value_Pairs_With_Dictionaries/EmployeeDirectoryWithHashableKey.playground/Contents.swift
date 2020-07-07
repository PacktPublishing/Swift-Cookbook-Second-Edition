
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

enum Role: String {
    case captain = "Captain"
    case firstOfficer = "First Officer"
    case secondOfficer = "Second Officer"
    case chiefEngineer = "Chief Engineer"
    case councillor = "Councillor"
    case securityOfficer = "Security Officer"
    case chiefMedicalOfficer = "Chief Medical Officer"
}

var crewDirectory = Dictionary<Role, Person>()

crewDirectory[.captain] = Person(givenName: "Jean-Luc", familyName: "Picard", commsMethod: .phone)
crewDirectory[.firstOfficer] = Person(givenName: "William", familyName: "Riker", commsMethod: .email)
crewDirectory[.chiefEngineer] = Person(givenName: "Georgi", familyName: "LaForge", commsMethod: .textMessage)
crewDirectory[.secondOfficer] = Person(givenName: "Data", familyName: "Soong", commsMethod: .fax)
crewDirectory[.councillor] = Person(givenName: "Deanna", familyName: "Troy", commsMethod: .telepathy)
crewDirectory[.securityOfficer] = Person(givenName: "Tasha", familyName: "Yar", commsMethod: .subSpaceRelay)
crewDirectory[.chiefMedicalOfficer] = Person(givenName: "Beverly", familyName: "Crusher", commsMethod: .quantumEntanglement)

let roles = Array(crewDirectory.keys)
print(roles)

let firstRole = roles.first! // Chief Medical Officer
let cmo = crewDirectory[firstRole]! // Person: Beverly Crusher
print("\(firstRole): \(cmo.name.givenName) \(cmo.name.familyName)") // Chief Medical Officer: Beverly Crusher

print(crewDirectory[.securityOfficer]!.name.givenName) // Tasha
crewDirectory[.securityOfficer] = Person(givenName: "Worf", familyName: "Son of Mogh", commsMethod: .subSpaceRelay)
print(crewDirectory[.securityOfficer]!.name.givenName) // Worf
