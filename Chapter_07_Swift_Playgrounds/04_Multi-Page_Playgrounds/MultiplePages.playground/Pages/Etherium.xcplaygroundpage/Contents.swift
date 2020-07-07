//: [Previous: Bitcoin](@previous)

import PlaygroundSupport
import UIKit

let barView = BarChart(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
barView.backgroundColor = .white

let blue =  Color(red: 0, green: 0, blue: 1, alpha: 1.0)

let jan2017 = Bar(value: 8.06, color: blue)
let feb2017 = Bar(value: 10.70, color: blue)
let mar2017 = Bar(value: 17.17, color: blue)
let apr2017 = Bar(value: 50.43, color: blue)
let may2017 = Bar(value: 76.85, color: blue)
let jun2017 = Bar(value: 230.15, color: blue)

barView.bars = [jan2017, feb2017, mar2017, apr2017, may2017, jun2017]

PlaygroundPage.current.liveView = barView


//: [Next: Lightcoin](@next)
