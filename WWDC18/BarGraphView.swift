//  Created by George Taylor on 20/03/2018.
//  Copyright © 2018 George Taylor. All rights reserved.

import UIKit

public class BarGraphView: DisplayView {
    
    
    
    override public func draw(_ rect: CGRect) {
        
        //     Setting properties and data
        self.backgroundColor = .black
        let barDepth: CGFloat = 10
        var rectY: CGFloat = 0
        guard let angleData = delegate?.passData() else {return}
        viewLabel?.font = UIFont.systemFont(ofSize: frame.width/2.7, weight: .semibold)
        viewLabel?.text = "\(Int(angleData * 60))°"
        
        //        For Loop drawing individual bars growing the angleData exponentially
        
        for n in 0...100 {
            if angleData > 0 {
                rectY = CGFloat(n * 20)
            } else {
                rectY = CGFloat(self.frame.height - CGFloat(n * 20))
            }
            
            
            let drawBar = CGRect(x: bounds.width / 2 , y: rectY, width: abs(CGFloat(pow((2*angleData), Double(n)))) , height: barDepth)
            let negativeDrawBar = CGRect(x: bounds.width / 2 , y: rectY, width: -abs(CGFloat(pow((-2*angleData), Double(n)))) , height: barDepth)
            let bar = UIBezierPath(rect: drawBar)
            let negativeBar = UIBezierPath(rect: negativeDrawBar)
            UIColor.white.setFill()
            bar.fill()
            negativeBar.fill()
            
            //        View ID
            tag = 1
            
        }
    }
    
    
}

// Another interesting width visual: sin(CGFloat(Double(n+1) * sinPitchData) * 0.2

