//: [Previous](@previous)

/*:
 # Crypto Currencies
 ## Lightcoin
 */

import PlaygroundSupport
import UIKit

let frame = CGRect(x: 0, y: 0, width: 300, height: 300)
let barView = BarChart(frame: frame)
barView.backgroundColor = .white

let red =  Color(red: 1, green: 0, blue: 0)

/*:
 * Note:
 Lightcoin Price (in USD)
 - Jan 2020 -  $67.58
 - Feb 2020 -  $58.09
 - Mar 2020 - $39.13
 - Apr 2020 - $46.19
 - May 2020 - $44.23
 - Jun 2020 - $41.21
 
 Taken from [Statista](https://www.statista.com/statistics/807160/litecoin-price-monthly)
 */

let jan2020 = Bar(value: 67.58, color: red)
let feb2020 = Bar(value: 58.09, color: red)
let mar2020 = Bar(value: 39.13, color: red)
let apr2020 = Bar(value: 46.19, color: red)
let may2020 = Bar(value: 44.23, color: red)
let jun2020 = Bar(value: 41.21, color: red)

barView.bars = [jan2020,
                feb2020,
                mar2020,
                apr2020,
                may2020,
                jun2020]

PlaygroundPage.current.liveView = barView
