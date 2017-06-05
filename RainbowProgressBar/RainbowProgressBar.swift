//
//  RainbowProgressBar.swift
//  RainbowProgressBar
//
//  Created by NguyenVuHuy on 6/5/17.
//  Copyright © 2017 hyubyn. All rights reserved.
//

import UIKit
import Foundation

class RainbowProgressBar: UIView, CAAnimationDelegate {
   
    var maskLayer: CALayer!
    var progress: CGFloat = 0
    var isAnimating = false
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black
        let newLayer = layer as! CAGradientLayer
        newLayer.startPoint = CGPoint.init(x: 0.0, y: 0.5)
        newLayer.endPoint = CGPoint.init(x: 1.0, y: 0.5)
        let arrayColor = NSMutableArray()
        var hue = 0.0
        while hue <= 360 {
            let color = UIColor.init(hue: CGFloat(1.0 * hue / 360), saturation: 1.0, brightness: 1.0, alpha: 1.0)
            arrayColor.add(color.cgColor)
            hue += 5
        }
        
        newLayer.colors = (arrayColor as! [Any])
        
        maskLayer = CALayer()
        maskLayer.frame = CGRect.init(x: 0, y: 0, width: 0, height: frame.size.height)
        maskLayer.backgroundColor = UIColor.black.cgColor
        newLayer.mask = maskLayer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        var maskRect = maskLayer.frame
        maskRect.size.width = bounds.width * progress
        maskLayer.frame = maskRect
        print(maskRect)
    }
    
    func setProgress(value: CGFloat) {
        if value != progress {
            progress = 1.0 < fabs(value) ? 1 : fabs(value)
            print(progress)
            setNeedsLayout()
        }
    }
    
    func shiftColor(colors: NSMutableArray) -> NSMutableArray {
        if let resultArray = colors.mutableCopy() as? NSMutableArray {
            let lastObject = resultArray.dropLast()
            resultArray.insert(lastObject, at: 0)
            return resultArray
        }
        return NSMutableArray()
    }
    
    func performAnimation() {
        let layer = self.layer as? CAGradientLayer
        if layer != nil {
            let fromColors = layer!.colors as! NSMutableArray
            let toColors = shiftColor(colors: fromColors)
            let animation = CABasicAnimation(keyPath: "color")
            animation.fromValue = fromColors
            animation.toValue = toColors
            animation.duration = 0.08
            animation.isRemovedOnCompletion = true
            animation.fillMode = kCAFillModeForwards
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            animation.delegate = self
            layer!.add(animation, forKey: "animateGradient")
        }
    }
    
    
    
    func startAnimating() {
        if !isAnimating {
            performAnimation()
            isAnimating = true
        }
    }
    
    func stopAnimating() {
        if isAnimating {
            isAnimating = false
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if isAnimating {
            performAnimation()
        }
    }
}
