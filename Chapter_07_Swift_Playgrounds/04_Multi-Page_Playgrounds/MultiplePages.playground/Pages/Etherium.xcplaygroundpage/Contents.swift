//: [Previous: Bitcoin](@previous)

/*:
 # Crypto Currencies
 ## Etherium
 */

import PlaygroundSupport
import UIKit

let frame = CGRect(x: 0, y: 0, width: 300, height: 300)
let barView = BarChart(frame: frame)
barView.backgroundColor = .white

let blue =  Color(red: 0, green: 0, blue: 1)

/*:
 * Note:
 Etherium Price (in USD)
 - Jan 2020 -  $181.73
 - Feb 2020 -  $223.5
 - Mar 2020 - $133.76
 - Apr 2020 - $209.42
 - May 2020 - $245.76
 - Jun 2020 - $225.71
 
 Taken from [Statista](https://www.statista.com/statistics/806453/price-of-ethereum)
 */

let jan2020 = Bar(value: 181.73, color: blue)
let feb2020 = Bar(value: 223.5, color: blue)
let mar2020 = Bar(value: 133.76, color: blue)
let apr2020 = Bar(value: 209.42, color: blue)
let may2020 = Bar(value: 245.76, color: blue)
let jun2020 = Bar(value: 225.71, color: blue)

barView.bars = [jan2020,
                feb2020,
                mar2020,
                apr2020,
                may2020,
                jun2020]

PlaygroundPage.current.liveView = barView


//: [Next: Lightcoin](@next)
