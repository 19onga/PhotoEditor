//
//  EditViewController.swift
//  Project 3: Navigation
//
//  Created by Amanda Ong on 12/23/15.
//  Copyright © 2015 Amanda Ong. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var toolbar : UIToolbar!
    var tempImageView: DrawableView!
    var imageView: UIImageView = UIImageView(image: UIImage(named: "ClearImage"))
//        {
//        didSet {
//            tempImageView.image = imageView.image
//            tempImageView.contentMode = .ScaleAspectFit
//        }
//    }
    
//    var tempImageView = UIImageView()
    let path=UIBezierPath()
    var previousPoint = CGPoint.zero
    var lineWidth:CGFloat=10.0
    var drawOn = false
    var lastPoint = CGPoint.zero
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createToolBar()
        createNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //Set constants
        let width = view.bounds.width
        let height = view.bounds.height
        
        // Bounds is now correctly set
        toolbar.frame = CGRect(x: 0, y: height-height*0.1, width: width, height: height*0.1)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.view.backgroundColor = UIColor.blackColor()
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        createImageView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createImageView() {
        //Set constants
        let width = view.bounds.width
        let height = view.bounds.height
        
        //Create imageView
        imageView.frame = CGRectMake(0,0, width, height*(3/4))
        imageView.center.x = view.bounds.width/2
        imageView.center.y = view.bounds.height/2
        
        //Add imageView to view controller
        self.view.addSubview(imageView)
    }
    
    func createNavigationBar(){
        //Set constants
        let width = view.bounds.width
        let height = view.bounds.height
        
        // Create the navigation bar
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, width, height*0.1))
        navigationBar.barTintColor = UIColor.whiteColor()
        
        //Create navigation bar's title
        self.navigationController?.navigationBar.topItem?.title = "Edit"
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 34)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        //Create back button
        let backBtn = UIButton(type: UIButtonType.Custom)
        backBtn.frame = CGRectMake(0, 0, 50, 50)
        backBtn.setImage(UIImage(named: "BackIcon"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: "back:", forControlEvents: UIControlEvents.TouchUpInside)
        backBtn.sizeToFit()
        let backButtonItem = UIBarButtonItem(customView: backBtn)
        self.navigationItem.leftBarButtonItem = backButtonItem
        
        //Add navigation bar to view
        self.view.addSubview(navigationBar)
    }
    
    func createToolBar(){
        toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.Black
        
        //Create Draw button
        var drawBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        drawBtn.setImage(UIImage(named: "DrawIcon"), forState: UIControlState.Normal)
        drawBtn.addTarget(self.navigationController, action: Selector("draw:"), forControlEvents:  UIControlEvents.TouchUpInside)
        var draw = UIBarButtonItem(customView: drawBtn)
        
        //Create Effects button
        var eftBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        eftBtn.setImage(UIImage(named: "FilterIcon"), forState: UIControlState.Normal)
        eftBtn.addTarget(self.navigationController, action: Selector("effects:"), forControlEvents:  UIControlEvents.TouchUpInside)
        var effects = UIBarButtonItem(customView: eftBtn)
        
        //Create Text button
        var txtBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        txtBtn.setImage(UIImage(named: "TextIcon"), forState: UIControlState.Normal)
        txtBtn.addTarget(self.navigationController, action: Selector("text:"), forControlEvents:  UIControlEvents.TouchUpInside)
        var text = UIBarButtonItem(customView: txtBtn)
        
        //Create Stickers button
        var stkrBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        stkrBtn.setImage(UIImage(named: "StickersIcon"), forState: UIControlState.Normal)
        stkrBtn.addTarget(self.navigationController, action: Selector("stickers:"), forControlEvents:  UIControlEvents.TouchUpInside)
        var stickers = UIBarButtonItem(customView: stkrBtn)
        
        //Create Download button
        var dlBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        dlBtn.setImage(UIImage(named: "DownloadIcon"), forState: UIControlState.Normal)
        dlBtn.addTarget(self.navigationController, action: Selector("download:"), forControlEvents:  UIControlEvents.TouchUpInside)
        var download = UIBarButtonItem(customView: dlBtn)
        
        //Create flexible space btwn buttons
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil,action: nil)
        
        toolbar.items = [draw, space, effects, space, text, space, stickers, space, download]
        self.view.addSubview(toolbar)
    }
    
    func draw(sender: UIButton!) {
        var widthRatio = imageView.bounds.size.width / imageView.image!.size.width
        var heightRatio = imageView.bounds.size.height / imageView.image!.size.height
        var scale = min(widthRatio, heightRatio)
        var imageWidth = scale * imageView.image!.size.width
        var imageHeight = scale * imageView.image!.size.height
//        drawOn = true
//        createTempImageView()
        tempImageView = DrawableView(frame:CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
        tempImageView.center = CGPoint(x: imageView.center.x, y: imageView.center.y)
        tempImageView.backgroundColor = UIColor.purpleColor()
        self.view.addSubview(tempImageView)
    }
    
    
//    func createTempImageView(){
//        var widthRatio = imageView.bounds.size.width / imageView.image!.size.width
//        var heightRatio = imageView.bounds.size.height / imageView.image!.size.height
//        var scale = min(widthRatio, heightRatio)
//        var imageWidth = scale * imageView.image!.size.width
//        var imageHeight = scale * imageView.image!.size.height
//
//        tempImageView = UIImageView(frame:CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
//        tempImageView.center = CGPoint(x: imageView.center.x, y: imageView.center.y)
//        tempImageView.backgroundColor = UIColor.purpleColor()
//        view.insertSubview(tempImageView, aboveSubview: imageView)
//    }
//    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//            if drawOn == true{
//            swiped = false
//            if let touch = touches.first{
//        lastPoint = touch.locationInView(self.view)
//                print("touchesBegan is working")
//            }
//            }
//            super.touchesBegan(touches, withEvent: event)
//    }
//    
//    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
//        var widthRatio = imageView.bounds.size.width / imageView.image!.size.width
//        var heightRatio = imageView.bounds.size.height / imageView.image!.size.height
//        var scale = min(widthRatio, heightRatio)
//        var imageWidth = scale * imageView.image!.size.width
//        var imageHeight = scale * imageView.image!.size.height
//        
//        // 1
//        UIGraphicsBeginImageContext(CGSize(width: imageWidth, height: imageHeight))
//        let context = UIGraphicsGetCurrentContext()
//        tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
//
//        // 2
//        CGContextMoveToPoint(context, fromPoint.x, fromPoint.y)
//        CGContextAddLineToPoint(context, toPoint.x, toPoint.y)
//        
//        // 3
//        CGContextSetLineCap(context, CGLineCap.Round)
//        CGContextSetLineWidth(context, brushWidth)
//        CGContextSetRGBStrokeColor(context, red, green, blue, 1.0)
//        CGContextSetBlendMode(context, CGBlendMode.Normal)
//        
//        // 4
//        CGContextStrokePath(context)
//        
//        // 5
//        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
//        tempImageView.alpha = opacity
//        UIGraphicsEndImageContext()
//        
//    }
//    
//    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
//            if drawOn == true{
//            
//            // 6
//            swiped = true
//            if let touch = touches.first{
//                let currentPoint = touch.locationInView(view)
//                drawLineFrom(lastPoint, toPoint: currentPoint)
//                
//                // 7
//                lastPoint = currentPoint
//            }
//            
//            }
//            super.touchesMoved(touches, withEvent: event)
//    }
//    
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        var widthRatio = imageView.bounds.size.width / imageView.image!.size.width
//        var heightRatio = imageView.bounds.size.height / imageView.image!.size.height
//        var scale = min(widthRatio, heightRatio)
//        var imageWidth = scale * imageView.image!.size.width
//        var imageHeight = scale * imageView.image!.size.height
//        
//        if drawOn == true{
//            if !swiped {
//                // draw a single point
//                drawLineFrom(lastPoint, toPoint: lastPoint)
//            }
//            
//            // Merge tempImageView into mainImageView
//            UIGraphicsBeginImageContext(CGSize(width: imageWidth, height: imageHeight))
//            imageView.image?.drawInRect(CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight), blendMode: CGBlendMode.Normal, alpha: 1.0)
//            tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight), blendMode: CGBlendMode.Normal, alpha: opacity)
//            
//            imageView.image = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            
//            tempImageView.image = nil
//            
//            
//        }
//        super.touchesEnded(touches, withEvent: event)
//    }
    
}


