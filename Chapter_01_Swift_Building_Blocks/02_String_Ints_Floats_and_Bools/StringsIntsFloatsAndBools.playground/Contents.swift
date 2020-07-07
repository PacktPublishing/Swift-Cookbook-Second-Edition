
let phrase: String = "The quick brown fox jumps over the lazy dog"
let numberOfFoxes: Int = 1
let numberOfAnimals: Int = 2

let averageCharactersPerWord: Float = (3+5+5+3+5+4+3+4+3) / 9
print(averageCharactersPerWord) // 43

/*
 phrase = "The quick brown ? jumps over the lazy ?" // Doesn't compile
 */

var anotherPhrase = phrase
anotherPhrase = "The quick brown 🦊 jumps over the lazy 🐶"
print(phrase) // "The quick brown fox jumps over the lazy dog"
print(anotherPhrase) // "The quick brown 🦊 jumps over the lazy 🐶"

var phraseInfo = "The phrase" + " has: "
print(phraseInfo) // "The phrase has: "

phraseInfo = phraseInfo + "\(numberOfFoxes) fox and \(numberOfAnimals) animals"
print(phraseInfo) // "The phrase has: 1 fox and 2 animals"

print("Number of characters in phrase: \(phrase.count)")

let multilineExplanation = """
Why is the following phrase often used?
"The quick brown fox jumps over the lazy dog"
This phrase contains every letter in the alphabet.
"""

let phrasesAreEqual = phrase == anotherPhrase
print(phrasesAreEqual) // false

let phraseHas43Characters = phrase.count == 40 + 3
print(phraseHas43Characters) // true
