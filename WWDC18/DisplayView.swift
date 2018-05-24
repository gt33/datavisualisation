//  Created by George Taylor on 27/03/2018.
//  Copyright © 2018 George Taylor. All rights reserved.

import UIKit

public class DisplayView: UIView {
    
    //    UIView class including delegate
    
    public var delegate: DataPassingDelegate?
    public lazy var viewLabel = delegate?.adjustLabel()
    
}
