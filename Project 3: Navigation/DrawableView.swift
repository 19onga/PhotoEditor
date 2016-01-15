//
//  DrawableView.swift
//  Drawing
//
//  Created by Nofel Mahmood on 23/01/2015.
//  Copyright (c) 2015 Nofel Mahmood. All rights reserved.
//

import UIKit

class DrawableView: UIView {
    
    let path=UIBezierPath()
    var previousPoint:CGPoint
    var lineWidth:CGFloat=10.0
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override init(frame: CGRect) {
        print("override init works")
        previousPoint=CGPoint.zero
        super.init(frame: frame)
        let panGestureRecognizer=UIPanGestureRecognizer(target: self, action: "pan:")
        panGestureRecognizer.maximumNumberOfTouches=1
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("required init works")
        previousPoint=CGPoint.zero
        super.init(coder: aDecoder)
       
    }
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        UIColor.greenColor().setStroke()
        path.lineWidth=lineWidth
        path.stroke()
    }
    
    func pan(panGestureRecognizer:UIPanGestureRecognizer)->Void
    {
        let currentPoint=panGestureRecognizer.locationInView(self)
        let midPoint=self.midPoint(previousPoint, p1: currentPoint)
        
        if panGestureRecognizer.state == .Began
        {
            path.moveToPoint(currentPoint)
        }
        else if panGestureRecognizer.state == .Changed
        {
            path.addQuadCurveToPoint(midPoint,controlPoint: previousPoint)
        }
        previousPoint=currentPoint
        self.setNeedsDisplay()
//        let layer = CAShapeLayer()
//        layer.path = path.CGPath
//        layer.strokeColor = UIColor.blueColor().CGColor
//        self.layer.addSublayer(layer)
    }
    
    func midPoint(p0:CGPoint,p1:CGPoint)->CGPoint
    {
        let x=(p0.x+p1.x)/2
        let y=(p0.y+p1.y)/2
        return CGPoint(x: x, y: y)
    }
    
}
