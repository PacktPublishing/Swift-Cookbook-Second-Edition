
enum GridPosition: String {
    case player1 = "o"
    case player2 = "x"
    case empty = " "
}

struct TicTacToe {
    
    var gridStorage: [[GridPosition]] = []
    
    init() {
        gridStorage.append(Array(repeating: .empty, count: 3))
        gridStorage.append(Array(repeating: .empty, count: 3))
        gridStorage.append(Array(repeating: .empty, count: 3))
    }
    
    func gameStateString() -> String {
        var stateString = "-------------\n"
        stateString += printableString(forRow: gridStorage[0])
        stateString += "-------------\n"
        stateString += printableString(forRow: gridStorage[1])
        stateString += "-------------\n"
        stateString += printableString(forRow: gridStorage[2])
        stateString += "-------------\n"
        
        return stateString
    }
    
    func printableString(forRow row: [GridPosition]) -> String {
        var rowString = "| \(row[0].rawValue) "
        rowString += "| \(row[1].rawValue) "
        rowString += "| \(row[2].rawValue) |\n"
        return rowString
    }
    
    subscript(row: Int, column: Int) -> GridPosition {
        get {
            return gridStorage[row][column]
        }
        set(newValue) {
            gridStorage[row][column] = newValue
        }
    }
}

var game = TicTacToe()

//
// Moves without using subscript
//

// Move 1
game.gridStorage[1][1] = .player1
print(game.gameStateString())
/*
 -------------
 |   |   |   |
 -------------
 |   | o |   |
 -------------
 |   |   |   |
 -------------
 */

// Move 2
game.gridStorage[0][2] = .player2
print(game.gameStateString())
/*
 -------------
 |   |   | x |
 -------------
 |   | o |   |
 -------------
 |   |   |   |
 -------------
 */

//
// Moves using subscript
//

// Move 3
game[0, 0] = .player1
print(game.gameStateString())
/*
 -------------
 | o |   | x |
 -------------
 |   | o |   |
 -------------
 |   |   |   |
 -------------
 */

// Move 4
game[1, 2] = .player2
print(game.gameStateString())
/*
 -------------
 | o |   | x |
 -------------
 |   | o | x |
 -------------
 |   |   |   |
 -------------
 */

// Move 5
game[2, 2] = .player1
print(game.gameStateString())
/*
 -------------
 | o |   | x |
 -------------
 |   | o | x |
 -------------
 |   |   | o |
 -------------
 */

let topLeft = game[0, 0]
let middle = game[1, 1]
let bottomRight = game[2, 2]
let player1HasWon = (topLeft == .player1) && (middle == .player1) && (bottomRight == .player1)
