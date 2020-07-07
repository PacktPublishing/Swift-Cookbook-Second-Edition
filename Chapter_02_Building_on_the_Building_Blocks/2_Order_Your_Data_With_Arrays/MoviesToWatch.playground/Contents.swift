
var moviesToWatch: Array<String> = Array()
moviesToWatch.append("The Shawshank Redemption")
moviesToWatch.append("Ghostbusters")
moviesToWatch.append("Terminator 2")
print(moviesToWatch[0]) // "The Shawshank Redemption"
print(moviesToWatch[1]) // "Ghostbusters"
print(moviesToWatch[2]) // "Terminator 2"
print(moviesToWatch.count) // 3

moviesToWatch.insert("The Matrix", at: 2)
print(moviesToWatch.count) // 4
print(moviesToWatch)
// The Shawshank Redemption
// Ghostbusters
// The Matrix
// Terminator 2

let firstMovieToWatch = moviesToWatch.first
print(firstMovieToWatch as Any) // Optional("The Shawshank Redemption")
let lastMovieToWatch = moviesToWatch.last
print(lastMovieToWatch as Any) // Optional("Terminator 2")
let secondMovieToWatch = moviesToWatch[1]
print(secondMovieToWatch) // "Ghostbusters"

moviesToWatch[1] = "Ghostbusters (1984)"
print(moviesToWatch.count) // 4
print(moviesToWatch)
// The Shawshank Redemption
// Ghostbusters (1984)
// The Matrix
// Terminator 2

let spyMovieSuggestions: [String] = ["The Bourne Identity", "Casino Royale", "Mission Impossible"]

moviesToWatch = moviesToWatch + spyMovieSuggestions
print(moviesToWatch.count) // 7
print(moviesToWatch)
// The Shawshank Redemption
// Ghostbusters (1984)
// The Matrix
// Terminator 2
// The Bourne Identity
// Casino Royale
// Mission Impossible

var starWarsTrilogy = Array<String>(repeating: "Star Wars: ", count: 3)
starWarsTrilogy[0] = starWarsTrilogy[0] + "A New Hope"
starWarsTrilogy[1] = starWarsTrilogy[1] + "Empire Strikes Back"
starWarsTrilogy[2] = starWarsTrilogy[2] + "Return of the Jedi"
print(starWarsTrilogy)
// Star Wars: A New Hope
// Star Wars: Empire Strikes Back
// Star Wars: Return of the Jedi

moviesToWatch.replaceSubrange(2...4, with: starWarsTrilogy)
print(moviesToWatch.count) // 7
print(moviesToWatch)
// The Shawshank Redemption
// Ghostbusters (1984)
// Star Wars: A New Hope
// Star Wars: Empire Strikes Back
// Star Wars: Return of the Jedi
// Casino Royale
// Mission Impossible

moviesToWatch.remove(at: 6)
print(moviesToWatch.count) // 6
print(moviesToWatch)
// The Shawshank Redemption
// Ghostbusters (1984)
// Star Wars: A New Hope
// Star Wars: Empire Strikes Back
// Star Wars: Return of the Jedi
// Casino Royale

// Obtaining an Index

let index5 = moviesToWatch.index(moviesToWatch.startIndex,
                                 offsetBy: 5,
                                 limitedBy: moviesToWatch.endIndex)
print(index5 as Any) // Optional 5

let index10 = moviesToWatch.index(moviesToWatch.startIndex,
                                  offsetBy: 10,
                                  limitedBy: moviesToWatch.endIndex)
print(index10 as Any) // nil

// Arrays declared as constants are immutable

let evenNumbersTo10 = [2, 4, 6, 8, 10]
//evenNumbersTo10.append(12) // Doesn't compile
