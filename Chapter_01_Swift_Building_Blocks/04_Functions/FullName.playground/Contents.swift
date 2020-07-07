
// Input parameters and output
func fullName(givenName: String, middleName: String, familyName: String) -> String {
    return "\(givenName) \(middleName) \(familyName)"
}
let myFullName = fullName(givenName: "Keith", middleName: "David", familyName: "Moon")
print(myFullName) // Keith David Moon

// Input parameters, with a side effect and no output
func printFullName(givenName: String, middleName: String, familyName: String) {
    print("\(givenName) \(middleName) \(familyName)")
}
printFullName(givenName: "Keith", middleName: "David", familyName: "Moon")

// No inputs, with an output
func authorsFullName() -> String {
    return fullName(givenName: "Keith", middleName: "David", familyName: "Moon")
}
let authorOfThisBook = authorsFullName()

// No inputs, no ouput
func printAuthorsFullName() {
    let author = authorsFullName()
    print(author)
}
printAuthorsFullName()
