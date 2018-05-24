//  Created by George Taylor on 21/03/2018.
//  Copyright © 2018 George Taylor. All rights reserved.

import UIKit

public class GrowingBarView: DisplayView {
    
    override public func draw(_ rect: CGRect) {
        
        //    Data and view settings
        
        guard let angleData = delegate?.passData() else {return}
        viewLabel?.text = "\(Int(angleData * 60))°"
        self.backgroundColor = .black
        
        //        Draw bar with relation to pitch angleData
        
        let createSensorBar = CGRect(x: bounds.width / 3, y: bounds.height / 2, width: bounds.width / 3, height: CGFloat(angleData * 300))
        let sensorBar = UIBezierPath(rect: createSensorBar)
        UIColor.white.setFill()
        sensorBar.fill()
        
        //        View ID
        tag = 2
        
    }
    
}

