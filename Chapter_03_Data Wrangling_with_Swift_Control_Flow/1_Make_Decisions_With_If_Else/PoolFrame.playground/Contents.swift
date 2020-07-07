
enum PoolBallType: String {
    case solid
    case stripe
    case black
}

class PoolFrame {
    var player1BallType: PoolBallType?
    var player2BallType: PoolBallType?
}

class PoolTable {
    var currentFrame: PoolFrame?
}

func printBallTypeOfPlayer1(forTable table: PoolTable) {
    if let frame = table.currentFrame, let ballType = frame.player1BallType {
        print(ballType.rawValue)
    } else {
        print("Player 1 doesn't yet have a ball type or there is no current frame")
    }
}

//
// Table with no frame in play
//
let table = PoolTable()
table.currentFrame = nil

printBallTypeOfPlayer1(forTable: table)
// Player 1 doesn't yet have a ball type or there is no current frame

//
// Table with frame in play, but no balls potted
//
let frame = PoolFrame()
frame.player1BallType = nil
frame.player2BallType = nil

table.currentFrame = frame

printBallTypeOfPlayer1(forTable: table)
// Player 1 doesn't yet have a ball type or there is no current frame

//
// Table with frame in play, and a ball potted
//
frame.player1BallType = .solid
frame.player2BallType = .stripe

printBallTypeOfPlayer1(forTable: table)
// solid
