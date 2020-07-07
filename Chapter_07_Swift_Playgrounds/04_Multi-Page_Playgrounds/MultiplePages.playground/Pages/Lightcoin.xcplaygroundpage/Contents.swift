//: [Previous](@previous)

import PlaygroundSupport
import UIKit

let barView = BarChart(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
barView.backgroundColor = .white

let red =  Color(red: 1, green: 0, blue: 0, alpha: 1.0)

let jan2017 = Bar(value: 4.32, color: red)
let feb2017 = Bar(value: 3.99, color: red)
let mar2017 = Bar(value: 3.77, color: red)
let apr2017 = Bar(value: 7.43, color: red)
let may2017 = Bar(value: 15.42, color: red)
let jun2017 = Bar(value: 26.44, color: red)

barView.bars = [jan2017, feb2017, mar2017, apr2017, may2017, jun2017]

PlaygroundPage.current.liveView = barView
