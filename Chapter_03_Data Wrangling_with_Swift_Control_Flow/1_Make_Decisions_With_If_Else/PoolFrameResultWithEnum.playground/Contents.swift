
enum Result {
    case win(congratulationsMessage: String)
    case lose(commiserationsMessage: String)
}

func printMessage(forResult result: Result) {
    if case Result.win(congratulationsMessage: let winString) = result {
        print("You won! \(winString)")
    } else if case Result.lose(commiserationsMessage: let loseString) = result {
        print("You lost :( \(loseString)")
    }
}

let result = Result.win(congratulationsMessage: "You're simply the best!")
printMessage(forResult: result) // You won! You're simply the best! 
