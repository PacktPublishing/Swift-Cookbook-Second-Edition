//: Playground - noun: a place where people can play

import PlaygroundSupport
import UIKit

let barView = BarChart(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
barView.backgroundColor = .white

let bar1 = Bar(value: 20, color: Color(red: 1, green: 0, blue: 0))
let bar2 = Bar(value: 40, color: Color(red: 0, green: 1, blue: 0))
let bar3 = Bar(value: 25, color: Color(red: 0, green: 0, blue: 1))

barView.bars = [bar1, bar2, bar3]

PlaygroundPage.current.liveView = barView
