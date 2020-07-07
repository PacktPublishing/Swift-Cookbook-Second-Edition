
func fullName(givenName: String, middleName: String, familyName: String = "Moon") -> String {
    return "\(givenName) \(middleName) \(familyName)"
}

let keith = fullName(givenName: "Keith", middleName: "David")
let alissa = fullName(givenName: "Alissa", middleName: "May")
let laura = fullName(givenName: "Laura", middleName: "May", familyName: "Jones")
print(keith) // Keith David Moon
print(alissa) // Alissa May Moon
print(laura)  // Laura May Jones
