
enum PoolBallType {
    case solid
    case stripe
    case black
}

func poolBallType(forNumber number: Int) -> PoolBallType {
    if number < 8 {
        return .solid
    } else if number > 8 {
        return .stripe
    } else {
        return .black
    }
}

let two = poolBallType(forNumber: 2) // .solid
let eight = poolBallType(forNumber: 8) // .black
let twelve = poolBallType(forNumber: 12) // .stripe

// Not ideal
let zero = poolBallType(forNumber: 0) // .solid
let sixteen = poolBallType(forNumber: 16) // .stripe
