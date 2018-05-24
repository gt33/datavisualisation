//  Created by George Taylor on 26/03/2018.
//  Copyright © 2018 George Taylor. All rights reserved.

import UIKit

public class ClimateBarGraphView: DisplayView {
    
    //   Global climate variables and Icons
    public var yearText: Int = 1993
    public var CO2: Double = 0.0
    public var seaLevels: Double = 0.0
    public var globalTemp: Double = 0.0
    public var CO2Icon = UIImage(named: "CO2Icon")
    public var temperatureIcon = UIImage(named: "tempIcon")
    public var seaIcon = UIImage(named: "seaIcon")
    
    
    override public func draw(_ rect: CGRect) {
        
        //        Setup view and label properties
        self.backgroundColor = .white
        let barDepth: CGFloat = 10
        var rectY: CGFloat = 0
        let dataTrend: Double = (CO2 + seaLevels + globalTemp) / 3
        guard var angleData = delegate?.passData() else {return}
        angleData = abs(angleData)
        viewLabel?.text = "\(yearText)"
        
        //        Present data based on pitch range values
        
        switch angleData {
        case 0..<0.06:
            yearText = 1993
            CO2 = 0.3571
            globalTemp = 0.24
            seaLevels = 0.0428
        case 0.06..<0.12:
            yearText = 1994
            CO2 = 0.3588
            globalTemp = 0.32
            seaLevels = 0.084
        case 0.12..<0.18:
            yearText = 1995
            CO2 = 0.3602
            globalTemp = 0.44
            seaLevels = 0.1207
        case 0.18..<0.24:
            yearText = 1996
            CO2 = 0.36288
            globalTemp = 0.33
            seaLevels = 0.1444
        case 0.24..<0.3:
            yearText = 1997
            CO2 = 0.36373
            globalTemp = 0.47
            seaLevels = 0.1793
        case 0.3..<0.36:
            yearText = 1998
            CO2 = 0.3667
            globalTemp = 0.62
            seaLevels = 0.1605
        case 0.36..<0.42:
            yearText = 1999
            CO2 = 0.36838
            globalTemp = 0.4
            seaLevels = 0.1963
        case 0.42..<0.48:
            yearText = 2000
            CO2 = 0.3695
            globalTemp = 0.4
            seaLevels = 0.2254
        case 0.48..<0.54:
            yearText = 2001
            CO2 = 0.37114
            globalTemp = 0.54
            seaLevels = 0.282
        case 0.54..<0.6:
            yearText = 2002
            CO2 = 0.37328
            globalTemp = 0.62
            seaLevels = 0.3138
        case 0.6..<0.66:
            yearText = 2003
            CO2 = 0.3758
            globalTemp = 0.61
            seaLevels = 0.3478
        case 0.66..<0.72:
            yearText = 2004
            CO2 = 0.37752
            globalTemp = 0.53
            seaLevels = 0.3676
        case 0.72..<0.78:
            yearText = 2005
            CO2 = 0.3798
            globalTemp = 0.67
            seaLevels = 0.4158
        case 0.78..<0.84:
            yearText = 2006
            CO2 = 0.3819
            globalTemp = 0.62
            seaLevels = 0.4303
        case 0.84..<0.9:
            yearText = 2007
            CO2 = 0.38379
            globalTemp = 0.64
            seaLevels = 0.438
        case 0.9..<0.96:
            yearText = 2008
            CO2 = 0.3856
            globalTemp = 0.52
            seaLevels = 0.4648
        case 0.96..<1.02:
            yearText = 2009
            CO2 = 0.38743
            globalTemp = 0.63
            seaLevels = 0.515
        case 1.02..<1.08:
            yearText = 2010
            CO2 = 0.3899
            globalTemp = 0.7
            seaLevels = 0.53
        case 1.08..<1.14:
            yearText = 2011
            CO2 = 0.39165
            globalTemp = 0.57
            seaLevels = 0.5229
        case 1.14..<1.2:
            yearText = 2012
            CO2 = 0.39385
            globalTemp = 0.61
            seaLevels = 0.6304
        case 1.2..<1.26:
            yearText = 2013
            CO2 = 0.39652
            globalTemp = 0.64
            seaLevels = 0.6571
        case 1.26..<1.32:
            yearText = 2014
            CO2 = 0.39865
            globalTemp = 0.73
            seaLevels = 0.6917
        case 1.32..<1.38:
            yearText = 2015
            CO2 = 0.40084
            globalTemp = 0.86
            seaLevels = 0.7985
        case 1.38..<1.44:
            yearText = 2016
            CO2 = 0.40421
            globalTemp = 0.99
            seaLevels = 0.8274
        case 1.44..<1.5:
            yearText = 2017
            CO2 = 0.40652
            globalTemp = 0.9
            seaLevels = 0.8426
        case 1.5..<1.56:
            yearText = 2018
            CO2 = 0.40769
            globalTemp = 0.91
            seaLevels = 0.8881
            
        default:
            yearText = 1993
            CO2 = 0
            globalTemp = 0
            seaLevels = 0
        }
        
        //        For loop to create individual dynamic bars
        
        for n in 0...100 {
            
            rectY = CGFloat(n * 20)
            
            let drawBar = CGRect(x: bounds.width / 2 , y: rectY, width: CGFloat((angleData + dataTrend) * Double(frame.width / 5) * sin(Double(n) / Double(frame.height / 190))), height: barDepth)
            let negativeDrawBar = CGRect(x: bounds.width / 2 , y: rectY, width: -(CGFloat((angleData + dataTrend) * Double(frame.width / 5) * sin(Double(n) / Double(frame.height / 190)))), height: barDepth)
            let bar = UIBezierPath(rect: drawBar)
            let negativeBar = UIBezierPath(rect: negativeDrawBar)
            UIColor.black.setFill()
            bar.fill()
            negativeBar.fill()
            
        }
        
        //        Draw Icons
        
        CO2Icon?.draw(in: CGRect(x: frame.width - frame.width / 6 , y: (frame.height * 0.25) - (frame.width / 5), width: frame.width / 8, height: frame.width / 8))
        temperatureIcon?.draw(in: CGRect(x: frame.width - frame.width / 6, y: (frame.height * 0.5) - (frame.width / 16), width: frame.width / 8, height: frame.width / 8))
        seaIcon?.draw(in: CGRect(x: frame.width - frame.width / 6, y: (frame.height * 0.75) + (frame.width / 12), width: frame.width / 8, height: frame.width / 8))
        
        //        View ID
        
        tag = 4
    }
    
}
