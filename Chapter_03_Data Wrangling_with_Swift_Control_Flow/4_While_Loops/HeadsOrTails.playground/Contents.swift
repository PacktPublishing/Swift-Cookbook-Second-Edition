
import Foundation

enum CoinFlip: Int {
    case heads
    case tails
    
    static func flipCoin() -> CoinFlip {
        return CoinFlip(rawValue: Int(arc4random_uniform(2)))!
    }
}

func howManyHeadsInARow() -> Int {
    
    var numberOfHeadsInARow = 0
    var currentCoinFlip = CoinFlip.flipCoin()
    
    while currentCoinFlip == .heads {
        numberOfHeadsInARow = numberOfHeadsInARow + 1
        currentCoinFlip = CoinFlip.flipCoin()
    }
    return numberOfHeadsInARow
}

let noOfHeads = howManyHeadsInARow()
print(noOfHeads)
