/*:
 # Crypto Currencies
 ## Bitcoin
 */

import PlaygroundSupport
import UIKit

/*:
 ### Usage
 * Create Bar Chart
 * Create Bars and add to chart
 * Make Bar Chart the LiveView
 */

let frame = CGRect(x: 0, y: 0, width: 300, height: 300)
let barView = BarChart(frame: frame)
barView.backgroundColor = .white

let green =  Color(red: 0, green: 1, blue: 0)

/*:
 * Note: 
 Bitcoin Price (in USD)
 - Jan 2020 -  $9,388.88
 - Feb 2020 -  $8,639.59
 - Mar 2020 - $6,483.74
 - Apr 2020 - $8,773.11
 - May 2020 - $9,437.05
 - Jun 2020 - $9,164.54
 
 Taken from [Statista](https://www.statista.com/statistics/326707/bitcoin-price-index)
 */

let jan2020 = Bar(value: 9388.88, color: green)
let feb2020 = Bar(value: 8639.59, color: green)
let mar2020 = Bar(value: 6483.74, color: green)
let apr2020 = Bar(value: 8773.11, color: green)
let may2020 = Bar(value: 9437.05, color: green)
let jun2020 = Bar(value: 9164.54, color: green)

barView.bars = [jan2020,
                feb2020,
                mar2020,
                apr2020,
                may2020,
                jun2020]

PlaygroundPage.current.liveView = barView

//: [Next: Etherium](@next)
