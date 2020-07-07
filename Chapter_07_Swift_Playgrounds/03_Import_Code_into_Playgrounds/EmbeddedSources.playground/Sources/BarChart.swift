import UIKit

public struct Bar {
    var value: Float
    var color: Color
    
    public init(value: Float, color: Color) {
        self.value = value
        self.color = color
    }
}

class BarView: UIView {
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        backgroundColor = color
        setupTexture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = UIColor.red
        setupTexture()
    }
    
    private func setupTexture() {
        let textureImage = UIImage(named: "texture")!
        let textureColor = UIColor(patternImage: textureImage)
        let textureView = UIView(frame: CGRect(origin: .zero, size: bounds.size))
        textureView.backgroundColor = textureColor
        addSubview(textureView)
    }
}

public class BarChart: UIView {
    
    public var bars: [Bar] = [] {
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
