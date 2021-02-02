
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
var alissasName = PersonName(givenName: "Alissa", middleName: "May", familyName: "Jones")

let alissasBirthName = PersonName(givenName: "Alissa", middleName: "May", familyName: "Jones")
print(alissasName.fullName()) // Alissa May Jones
var alissasCurrentName = alissasBirthName
print(alissasName.fullName()) // Alissa May Jones

alissasCurrentName.change(familyName: "Moon")
print(alissasBirthName.fullName()) // Alissa May Jones
print(alissasCurrentName.fullName()) // Alissa May Moon
