//  Created by George Taylor on 26/03/2018.
//  Copyright © 2018 George Taylor. All rights reserved.

import UIKit
import CoreMotion
//import PlaygroundSupport

//Delegate to pass label and pitch data
public protocol DataPassingDelegate {
    func passData() -> Double
    func adjustLabel() -> UILabel
}

public class MasterViewController: UIViewController, UIGestureRecognizerDelegate, DataPassingDelegate {
    
    //    Global properties
    
    public let motionManager = CMMotionManager()
    public var isCurrentOrientationPortrait: Bool = true
    public var currentViewNumber = 1
    public var currentView: UIView?
    public var angleData: Double = 0.0
    public var degreeLabelText = ""
    public let mainLabel = UILabel(frame: CGRect.zero)
    public var topArrow: UIButton!
    public var bottomArrow: UIButton!
    public var leftArrow: UIButton!
    public var rightArrow: UIButton!
    public var CO2Icon = UIImage(named: "CO2Icon")
    public var temperatureIcon = UIImage(named: "tempIcon")
    public var seaIcon = UIImage(named: "seaIcon")
    
    //    Protocol functions to transport data
    public func passData() -> Double {
        return angleData
    }
    
    public func adjustLabel() -> UILabel {
        return mainLabel
    }
    
    //    Navigation functions
    
    @objc public func navigateUp(_ sender: Any) {
        
        if currentViewNumber == 1 {
            currentViewNumber += 0
        }else if currentViewNumber == 4{
            currentViewNumber += 0
        } else{
            currentViewNumber -= 1
        }
        guard let nextView = tagToClassConverter() else {return}
        createConstraintsForView(currentView: nextView)
        currentView?.removeFromSuperview()
        currentView? = nextView
        
    }
    @objc public func navigateDown(_ sender: Any) {
        
        if currentViewNumber == 3 {
            currentViewNumber -= 0
        }else if currentViewNumber == 6 {
            currentViewNumber -= 0
        }else{
            currentViewNumber += 1
        }
        guard let nextView = tagToClassConverter() else {return}
        createConstraintsForView(currentView: nextView)
        currentView?.removeFromSuperview()
        currentView? = nextView
    }
    @objc public func navigateLeft(_ sender: Any) {
        
        if currentViewNumber < 4 {
            currentViewNumber += 0
        }else{
            currentViewNumber -= 3
        }
        guard let nextView = tagToClassConverter() else {return}
        createConstraintsForView(currentView: nextView)
        currentView?.removeFromSuperview()
        currentView? = nextView
        
    }
    @objc public func navigateRight(_ sender: Any) {
        
        if currentViewNumber >= 4 {
            currentViewNumber -= 0
        }else{
            currentViewNumber += 3
        }
        guard let nextView = tagToClassConverter() else {return}
        createConstraintsForView(currentView: nextView)
        currentView?.removeFromSuperview()
        currentView? = nextView
    }
    
    //    Gesture Recogniser Functions
    
    @objc public func handleLeftSwipe(recognizer: UIGestureRecognizer) {
        navigateRight(self)
        
    }
    @objc public func handleRightSwipe(recognizer: UIGestureRecognizer) {
        navigateLeft(self)
        
    }
    
    @objc public func handleUpSwipe(recognizer: UIGestureRecognizer) {
        navigateDown(self)
        
    }
    
    @objc public func handleDownSwipe(recognizer: UIGestureRecognizer) {
        navigateUp(self)
        
    }
    
    //    Displaying the six different views
    
    public func tagToClassConverter() -> DisplayView? {
        
        switch currentViewNumber {
        case 1 :
            let view1 = BarGraphView(frame: CGRect.zero)
            view.insertSubview(view1, at: 0)
            view1.delegate = self
            mainLabel.textColor = UIColor(white: 0.62, alpha: 1)
            topArrow.isHidden = true
            bottomArrow.isHidden = false
            leftArrow.isHidden = true
            rightArrow.isHidden = false
            self.mainLabel.setNeedsDisplay()
            self.currentView?.setNeedsDisplay()
            createConstraintsForView(currentView: view1)
            return view1
        case 2 :
            let view2 = GrowingBarView(frame: CGRect.zero)
            view.insertSubview(view2, at: 0)
            view2.delegate = self
            mainLabel.textColor = UIColor(white: 0.62, alpha: 1)
            mainLabel.font = UIFont.systemFont(ofSize: view.bounds.width / 5, weight: .semibold)
            topArrow.isHidden = false
            bottomArrow.isHidden = false
            leftArrow.isHidden = true
            rightArrow.isHidden = false
            createConstraintsForView(currentView: view2)
            return view2
        case 3 :
            let view3 = CircleView(frame: CGRect.zero)
            view.insertSubview(view3, at: 0)
            view3.delegate = self
            mainLabel.textColor = UIColor(white: 0.62, alpha: 1)
            topArrow.isHidden = false
            bottomArrow.isHidden = true
            leftArrow.isHidden = true
            rightArrow.isHidden = false
            createConstraintsForView(currentView: view3)
            return view3
        case 4 :
            let view4 = ClimateBarGraphView(frame: CGRect.zero)
            view.insertSubview(view4, at: 0)
            view4.delegate = self
            mainLabel.textColor = UIColor(white: 0.62, alpha: 1)
            mainLabel.font = UIFont.systemFont(ofSize: view.bounds.width / 4, weight: .semibold)
            topArrow.isHidden = true
            bottomArrow.isHidden = false
            leftArrow.isHidden = false
            rightArrow.isHidden = true
            CO2Icon?.draw(in: CGRect(x: view.bounds.width / 2, y: view.bounds.height / 2, width: 60, height: 30))
            temperatureIcon?.draw(in: CGRect(x: view.bounds.width - 80, y: view.bounds.height * 0.45, width: 30, height: 60))
            seaIcon?.draw(in: CGRect(x: view.bounds.width - 80, y: view.bounds.height * 0.66, width: 60, height: 20))
            createConstraintsForView(currentView: view4)
            return view4
            
        case 5 :
            let view5 = ClimateGrowingBarView(frame: CGRect.zero)
            view.insertSubview(view5, at: 0)
            view5.delegate = self
            mainLabel.textColor = UIColor(white: 0.62, alpha: 1)
            mainLabel.font = UIFont.systemFont(ofSize: view.bounds.width / 4, weight: .semibold)
            topArrow.isHidden = false
            bottomArrow.isHidden = false
            leftArrow.isHidden = false
            rightArrow.isHidden = true
            createConstraintsForView(currentView: view5)
            return view5
        case 6 :
            let view6 = ClimateCircleView(frame: CGRect.zero)
            view.insertSubview(view6, at: 0)
            view6.delegate = self
            mainLabel.textColor = UIColor(white: 0.62, alpha: 1)
            mainLabel.font = UIFont.systemFont(ofSize: view.bounds.width / 4, weight: .semibold)
            topArrow.isHidden = false
            bottomArrow.isHidden = true
            leftArrow.isHidden = false
            rightArrow.isHidden = true
            createConstraintsForView(currentView: view6)
            return view6
        default:
            return nil
        }
    }
    
    //    View Constraints
    
    public func createConstraintsForView(currentView: UIView) {
        currentView.translatesAutoresizingMaskIntoConstraints = false
        let viewWidthConstraint = NSLayoutConstraint(item: currentView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        viewWidthConstraint.isActive = true
        
        let viewHeightConstraint = NSLayoutConstraint(item: currentView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        viewHeightConstraint.isActive = true
        
        let viewXConstraint = NSLayoutConstraint(item: currentView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        viewXConstraint.isActive = true
        
        let viewYConstraint = NSLayoutConstraint(item: currentView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        viewYConstraint.isActive = true
    }
    
    //    Device orientation
    
    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            isCurrentOrientationPortrait = false
        } else if UIDevice.current.orientation.isPortrait {
            isCurrentOrientationPortrait = true
        }
        
    }
    
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        //        Create Gesture Recognisers
        
        let downGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleDownSwipe))
        downGestureRecognizer.direction = .down
        view.addGestureRecognizer(downGestureRecognizer)
        
        let upGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleUpSwipe))
        upGestureRecognizer.direction = .up
        view.addGestureRecognizer(upGestureRecognizer)
        
        let leftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleLeftSwipe))
        leftGestureRecognizer.direction = .left
        view.addGestureRecognizer(leftGestureRecognizer)
        
        let rightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleRightSwipe))
        rightGestureRecognizer.direction = .right
        view.addGestureRecognizer(rightGestureRecognizer)
        
        //        Design Main Label
        
        mainLabel.textAlignment = .center
        mainLabel.setNeedsDisplay()
        self.view.addSubview(mainLabel)
        
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = NSLayoutConstraint(item: mainLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        widthConstraint.isActive = true
        
        let heightConstraint = NSLayoutConstraint(item: mainLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        heightConstraint.isActive = true
        
        let xConstraint = NSLayoutConstraint(item: mainLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        xConstraint.isActive = true
        
        let yConstraint = NSLayoutConstraint(item: mainLabel, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        yConstraint.isActive = true
        
        //        Top Arrow properties and constraints
        
        topArrow = UIButton(frame: CGRect.zero)
        topArrow.setImage(UIImage(named: "upArrowImage"), for: .normal)
        topArrow.addTarget(self, action: #selector(navigateUp(_:)), for: .touchUpInside)
        view.addSubview(topArrow)
        
        topArrow.translatesAutoresizingMaskIntoConstraints = false
        let upWidthConstraint = NSLayoutConstraint(item: topArrow, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: topArrow, attribute: NSLayoutAttribute.width, multiplier: 1 / 3, constant: 80)
        upWidthConstraint.isActive = true
        
        let upHeightConstraint = NSLayoutConstraint(item: topArrow, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: topArrow, attribute: NSLayoutAttribute.width, multiplier: 1 / 3, constant: 0)
        upHeightConstraint.isActive = true
        
        let upXConstraint = NSLayoutConstraint(item: topArrow, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        upXConstraint.isActive = true
        
        let upBottomConstraint = NSLayoutConstraint(item: topArrow, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 10)
        upBottomConstraint.isActive = true
        
        //        Bottom Arrow properties and constraints
        
        
        bottomArrow = UIButton(frame: CGRect.zero)
        bottomArrow.setImage(UIImage(named: "downArrowImage"), for: .normal)
        bottomArrow.addTarget(self, action: #selector(navigateDown(_:)), for: .touchUpInside)
        view.addSubview(bottomArrow)
        
        bottomArrow.translatesAutoresizingMaskIntoConstraints = false
        let downWidthConstraint = NSLayoutConstraint(item: bottomArrow, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: bottomArrow, attribute: NSLayoutAttribute.width, multiplier: 1/3, constant: 80)
        downWidthConstraint.isActive = true
        
        let downHeightConstraint = NSLayoutConstraint(item: bottomArrow, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: bottomArrow, attribute: NSLayoutAttribute.width, multiplier: 1/3, constant: 0)
        downHeightConstraint.isActive = true
        
        let downXConstraint = NSLayoutConstraint(item: bottomArrow, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        downXConstraint.isActive = true
        
        let downBottomConstraint = NSLayoutConstraint(item: bottomArrow, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: -10)
        downBottomConstraint.isActive = true
        
        //        Right Arrow properties and constraints
        
        rightArrow = UIButton(frame: CGRect.zero)
        rightArrow.setImage(UIImage(named: "rightArrowImage"), for: .normal)
        rightArrow.addTarget(self, action: #selector(navigateRight(_:)), for: .touchUpInside)
        view.addSubview(rightArrow)
        
        rightArrow.translatesAutoresizingMaskIntoConstraints = false
        let rightWidthConstraint = NSLayoutConstraint(item: rightArrow, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: rightArrow, attribute: NSLayoutAttribute.height, multiplier: 1 / 3, constant: 0)
        rightWidthConstraint.isActive = true
        
        let rightHeightConstraint = NSLayoutConstraint(item: rightArrow, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: rightArrow, attribute: NSLayoutAttribute.height, multiplier: 1 / 3, constant: 80)
        rightHeightConstraint.isActive = true
        
        let rightTrailingConstraint = NSLayoutConstraint(item: rightArrow, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -10)
        rightTrailingConstraint.isActive = true
        
        let rightYConstraint = NSLayoutConstraint(item: rightArrow, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        rightYConstraint.isActive = true
        
        //        Left Arrow properties and constraints
        
        leftArrow = UIButton(frame: CGRect.zero)
        leftArrow.setImage(UIImage(named: "leftArrowImage"), for: .normal)
        leftArrow.addTarget(self, action: #selector(navigateLeft(_:)), for: .touchUpInside)
        view.addSubview(leftArrow)
        
        
        leftArrow.translatesAutoresizingMaskIntoConstraints = false
        let leftWidthConstraint = NSLayoutConstraint(item: leftArrow, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: leftArrow, attribute: NSLayoutAttribute.height, multiplier: 1 / 3, constant: 0)
        leftWidthConstraint.isActive = true
        
        let leftHeightConstraint = NSLayoutConstraint(item: leftArrow, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: leftArrow, attribute: NSLayoutAttribute.height, multiplier: 1 / 3, constant: 80)
        leftHeightConstraint.isActive = true
        
        let leftLeadingConstraint = NSLayoutConstraint(item: leftArrow, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 10)
        leftLeadingConstraint.isActive = true
        
        let leftYConstraint = NSLayoutConstraint(item: leftArrow, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        leftYConstraint.isActive = true
        
        //        Get Sensor Data (current Playgrounds does not recognise the landscape orientation) :'(
        
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1 / 30
            motionManager.startDeviceMotionUpdates(to: .main) { deviceMotion, error in
                guard error == nil else { return }
                
                guard let pitchData = deviceMotion?.attitude.pitch else {return}
                guard let rollData = deviceMotion?.attitude.roll else {return}
                if self.isCurrentOrientationPortrait {
                    self.angleData = pitchData
                } else {
                    self.angleData = rollData
                }
                
                self.currentView?.setNeedsDisplay()
                
            }
            
        }
        
        //        Assigning current view
        
        currentView = tagToClassConverter()
    }
    
    //    Stop device motion updates when view disappears
    
    override public func viewWillDisappear(_ animated: Bool) {
        motionManager.stopDeviceMotionUpdates()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

