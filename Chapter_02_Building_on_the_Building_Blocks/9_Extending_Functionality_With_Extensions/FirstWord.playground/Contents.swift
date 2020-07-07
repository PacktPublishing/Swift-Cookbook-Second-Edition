
extension String {
    func firstWord() -> String {
        let firstSpace = index(of: " ") ?? endIndex
        let firstNameSubString = prefix(upTo: firstSpace)
        return String(firstNameSubString)
    }
}

let llap = "Live long, and prosper"
let firstWord = llap.firstWord()
print(firstWord) // Live
