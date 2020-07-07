
enum PoolBallType {
    case solid
    case stripe
    case black
}

func poolBallType(forNumber number: Int) -> PoolBallType? {
    if number > 0 && number < 8 {
        return .solid
    } else if number > 8 && number < 16 {
        return .stripe
    } else if number == 8 {
        return .black
    } else {
        return nil
    }
}

let two = poolBallType(forNumber: 2)        // .solid
let eight = poolBallType(forNumber: 8)      // .black
let twelve = poolBallType(forNumber: 12)    // .stripe
let zero = poolBallType(forNumber: 0)       // nil
let sixteen = poolBallType(forNumber: 16)   // nil
