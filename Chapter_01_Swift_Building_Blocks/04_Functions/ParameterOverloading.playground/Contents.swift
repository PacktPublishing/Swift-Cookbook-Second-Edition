
func combine(_ givenName: String, _ familyName: String) -> String {
    return "\(givenName) \(familyName)"
}

func combine(_ integer1: Int, _ integer2: Int) -> Int {
    return integer1+integer2
}

let combinedString = combine("Finnley", "Moon")
let combinedInt = combine(5, 10)
print(combinedString) // Finnley Moon
print(combinedInt) // 15
