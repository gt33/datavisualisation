//  Created by George Taylor on 22/03/2018.
//  Copyright © 2018 George Taylor. All rights reserved.

import UIKit

public class CircleView: DisplayView {
    
    //    Global Coefficients
    
    public var pitchCoefficient: Double = 200
    public var centerPitchCoefficient: Double = 400
    
    
    override public func draw(_ rect: CGRect) {
        
        //        Pitch data label conditions and view properites
        
        guard let angleData = delegate?.passData() else {return}
        viewLabel?.text = "\(Int(angleData * 60))°"
        if angleData <= 0.9 && angleData >= -0.9 {
            viewLabel?.font = UIFont.systemFont(ofSize: self.frame.width / 2.1 - abs(CGFloat(angleData * 200)), weight: .semibold)
        }else{
            viewLabel?.font = UIFont.systemFont(ofSize:  (CGFloat((abs(angleData) - 0.9) * Double(self.frame.width) / 2.7)), weight: .semibold)
        }
        
        self.backgroundColor = .black
        
        //        Central growing circle
        
        let growingCircle = UIBezierPath(ovalIn: CGRect(x: bounds.width/2 - ((bounds.width - abs(10 + CGFloat(angleData * centerPitchCoefficient))) / 2), y: bounds.height/2 - ((bounds.width - abs(10 + CGFloat(angleData * centerPitchCoefficient))) / 2), width: bounds.width - abs(10 + CGFloat(angleData * centerPitchCoefficient)), height: bounds.width - abs(10 + CGFloat(angleData * centerPitchCoefficient))))
        UIColor.white.setFill()
        growingCircle.fill()
        
        //        Top and bottom growing circle dependencies
        
        if angleData < 0 {
            let topGrowingCircle = UIBezierPath(ovalIn: CGRect(x: bounds.width/2 - 5 - CGFloat(angleData * pitchCoefficient) / 2, y: bounds.height / 4 - 5 - CGFloat((angleData * pitchCoefficient) / 2), width: 10 + CGFloat(angleData * pitchCoefficient), height: 10 + CGFloat(angleData * pitchCoefficient)))
            UIColor.white.setFill()
            topGrowingCircle.fill()
        } else {
            let bottomGrowingCircle = UIBezierPath(ovalIn: CGRect(x: bounds.width/2 - 5 - CGFloat(angleData * pitchCoefficient) / 2, y: (bounds.height - bounds.height / 4) - 5 - CGFloat((angleData * pitchCoefficient) / 2), width: 10 + CGFloat(angleData * pitchCoefficient), height: 10 + CGFloat(angleData * pitchCoefficient)))
            UIColor.white.setFill()
            bottomGrowingCircle.fill()
            
            //      View ID
            
            tag = 3
            
        }
    }
    
    
}
