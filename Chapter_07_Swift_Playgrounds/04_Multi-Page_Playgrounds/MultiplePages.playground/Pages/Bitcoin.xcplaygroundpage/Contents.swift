
/*:
 # Crypto Currencies
 ## Bitcoin
 
 * Create Bar Chart
 * Create Bars and add to chart
 * Make Bar Chart the LiveView
 */

import PlaygroundSupport
import UIKit

/*:
 ## Usage
 
 * Create Bar Chart
 * Create Bars and add to chart
 * Make Bar Chart the LiveView
 */

let barView = BarChart(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
barView.backgroundColor = .white

let green =  Color(red: 0, green: 1, blue: 0, alpha: 1.0)

/*:

 * Note: 
 Bitcoin Price (in USD)
 - Jan 2017 -  $970.17
 - Feb 2017 -  $960.05
 - Mar 2017 - $1203.02
 - Apr 2017 - $1076.90
 - May 2017 - $1390.24
 - Jun 2017 - $2414.11
 */

let jan2017 = Bar(value: 970.17, color: green)
let feb2017 = Bar(value: 960.05, color: green)
let mar2017 = Bar(value: 1203.02, color: green)
let apr2017 = Bar(value: 1076.90, color: green)
let may2017 = Bar(value: 1390.24, color: green)
let jun2017 = Bar(value: 2414.11, color: green)

barView.bars = [jan2017, feb2017, mar2017, apr2017, may2017, jun2017]

PlaygroundPage.current.liveView = barView

//: [Next: Etherium](@next)
