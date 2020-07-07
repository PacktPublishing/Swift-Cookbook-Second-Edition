//: # Bar Chart - iOS
import PlaygroundSupport
import UIKit

//: ## Color
//: Color as a struct can produces UIColor on demand
struct Color {
    let red: Float
    let green: Float
    let blue: Float
    let alpha: Float = 1.0
    
    var displayColor: UIColor {
        return UIColor(red: CGFloat(red),
                       green: CGFloat(green),
                       blue: CGFloat(blue),
                       alpha: CGFloat(alpha))
    }
}

/*:
 ## Bar
 Simple struct to hold details aboout a bar in a bar chart
 */
struct Bar {
    var value: Float
    var color: Color
}

/*:
 ## BarView
 View that that will display the value of a bar in a chart
 */
class BarView: UIView {
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = UIColor.red
    }
}

/*:
 ## BarChart
 View that that will display at bar chart
 
 ### How to use
 Add `Bar`s to the `bars` array to add them to the chart
 */
class BarChart: UIView {
    
    var bars: [Bar] = [] {
        didSet {
            self.barViews.forEach { $0.removeFromSuperview() }
            
            var barViews = [BarView]()
            
            let barCount = CGFloat(bars.count)
            
            // Calculate the max value before calculating size
            for bar in bars {
                maxValue = max(maxValue, bar.value)
            }
            
            var xOrigin: CGFloat = interBarMargin
            
            for bar in bars {
                let width = (frame.width - (interBarMargin * (barCount+1))) / barCount
                let height = barHeight(forValue: bar.value)
                let rect = CGRect(x: xOrigin, y: bounds.height - height, width: width, height: height)
                let view = BarView(frame: rect, color: bar.color.displayColor)
                barViews.append(view)
                addSubview(view)
                
                xOrigin = view.frame.maxX + interBarMargin
            }
            self.barViews = barViews
        }
    }
    var interBarMargin: CGFloat = 5.0
    
    private var barViews: [BarView] = []
    private var maxValue: Float = 0.0
    
    private func barHeight(forValue value: Float) -> CGFloat {
        return (frame.size.height / CGFloat(maxValue)) * CGFloat(value)
    }
}

/*:
 ## Usage
 
 * Create Bar Chart
 * Create Bars and add to chart
 * Make Bar Chart the LiveView
 */
let barView = BarChart(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
barView.backgroundColor = .white

let bar1 = Bar(value: 20, color: Color(red: 1, green: 0, blue: 0))
let bar2 = Bar(value: 40, color: Color(red: 0, green: 1, blue: 0))
let bar3 = Bar(value: 25, color: Color(red: 0, green: 0, blue: 1))

barView.bars = [bar1, bar2, bar3]

PlaygroundPage.current.liveView = barView
