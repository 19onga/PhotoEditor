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
//    var tempImageView: DrawableView!
    var tempImageView = UIImageView()
    var imageView: UIImageView = UIImageView(image: UIImage(named: "ClearImage"))
        {
        didSet {
            tempImageView.image = imageView.image
            tempImageView.contentMode = .ScaleAspectFit
        }
    }

    //Drawing constants
    let path=UIBezierPath()
    var previousPoint = CGPoint.zero
    var lineWidth:CGFloat=10.0
    var drawOn = false
//    var lastPoint = CGPoint.zero
    var red: CGFloat = (0.0/255.0) //converts RGB value to UIColor value, numerator ("0.0") = RGB value
    var green: CGFloat = (0.0/255.0)
    var blue: CGFloat = (0.0/255.0)
    var brushWidth: CGFloat = 10.0
    var swiped = false
    
    var lastPoint: CGPoint!
    var isSwiping: Bool!
    
    //Drawing sliders' constants
    let background = UIView()
    let space = CGFloat(20)
    
    var size: CGFloat = 9
    var sizeValue = UILabel()
    var opacity: CGFloat = 1.0
    var opacityValue = UILabel()
    var strokeColor = UIColor.blackColor()
    
    let eraserButton = UIButton();
    var eraserOn = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createToolBar()
        createNavigationBar()
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
        
        //Set constants
        let width = view.bounds.width
        let height = view.bounds.height
        
        // Bounds is now correctly set
        toolbar.frame = CGRect(x: 0, y: height-height*0.1, width: width, height: height*0.1)

        //Create Draw button
        let drawBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        drawBtn.setImage(UIImage(named: "DrawIcon"), forState: UIControlState.Normal)
        drawBtn.addTarget(self.navigationController, action: Selector("draw:"), forControlEvents:  UIControlEvents.TouchUpInside)
        let draw = UIBarButtonItem(customView: drawBtn)
        
        //Create Effects button
        let eftBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        eftBtn.setImage(UIImage(named: "FilterIcon"), forState: UIControlState.Normal)
        eftBtn.addTarget(self.navigationController, action: Selector("effects:"), forControlEvents:  UIControlEvents.TouchUpInside)
        let effects = UIBarButtonItem(customView: eftBtn)
        
        //Create Text button
        let txtBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        txtBtn.setImage(UIImage(named: "TextIcon"), forState: UIControlState.Normal)
        txtBtn.addTarget(self.navigationController, action: Selector("text:"), forControlEvents:  UIControlEvents.TouchUpInside)
        let text = UIBarButtonItem(customView: txtBtn)
        
        //Create Stickers button
        let stkrBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        stkrBtn.setImage(UIImage(named: "StickersIcon"), forState: UIControlState.Normal)
        stkrBtn.addTarget(self.navigationController, action: Selector("stickers:"), forControlEvents:  UIControlEvents.TouchUpInside)
        let stickers = UIBarButtonItem(customView: stkrBtn)
        
        //Create Download button
        let dlBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        dlBtn.setImage(UIImage(named: "DownloadIcon"), forState: UIControlState.Normal)
        dlBtn.addTarget(self.navigationController, action: Selector("download:"), forControlEvents:  UIControlEvents.TouchUpInside)
        let download = UIBarButtonItem(customView: dlBtn)
        
        //Create flexible space btwn buttons
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil,action: nil)
        
        toolbar.items = [draw, space, effects, space, text, space, stickers, space, download]
        self.view.addSubview(toolbar)
    }
    
    let border = CGFloat(10)

    func draw(sender: UIButton!) {
        createTempImageView()
        UIView.animateWithDuration(0.5, animations: {self.toolbar.center.y = self.view.bounds.height*2})
        
        //Create background for sliders
        background.frame = CGRectMake(0,0, view.bounds.width, view.bounds.height*(1/4))
        background.backgroundColor = UIColor.blueColor().colorWithAlphaComponent(0.3)
        background.center = CGPoint(x: view.bounds.width/2, y: view.bounds.height-background.frame.height/2)
        self.view.addSubview(background)
        
        //Create constants
        let height = background.frame.height
        let cy = height/6

        createSlider("Size")
        
        //Creat size label
        let sizeLabel = UILabel(frame: CGRectMake(border, 0, 65, 50))
        sizeLabel.textAlignment = NSTextAlignment.Left
        sizeLabel.font = UIFont (name: "AvenirNext-Regular", size: 14)
        sizeLabel.textColor = UIColor.whiteColor()
        sizeLabel.text = "Size:"
        sizeLabel.center.y = cy*2.7 - space/2
        background.addSubview(sizeLabel)
        
        //Create size value
        sizeValue.frame = CGRectMake(0, 0, 60, 40)
        sizeValue.textAlignment = NSTextAlignment.Left
        sizeValue.font = UIFont (name: "AvenirNext-Regular", size: 14)
        sizeValue.textColor = UIColor.whiteColor()
        sizeValue.text = "\(size)"
        sizeValue.center = CGPoint(x: border + sizeLabel.frame.width, y: sizeLabel.center.y)
        background.addSubview(sizeValue)
        
        createSlider("Opacity")
        
        //Create opacity label
        let opacityLabel = UILabel(frame: CGRectMake(border, 0, 65, 50))
        opacityLabel.textAlignment = NSTextAlignment.Left
        opacityLabel.font = UIFont (name: "AvenirNext-Regular", size: 14)
        opacityLabel.textColor = UIColor.whiteColor()
        opacityLabel.text = "Opacity:"
        opacityLabel.center.y = cy*4.7 - space/2
        background.addSubview(opacityLabel)

        //Create opacity value
        opacityValue.frame = CGRectMake(0, 0, 60, 40)
        opacityValue.textAlignment = NSTextAlignment.Left
        opacityValue.font = UIFont (name: "AvenirNext-Regular", size: 14)
        opacityValue.textColor = UIColor.whiteColor()
        opacityValue.text = "\(opacity*100)%"
        opacityValue.center = CGPoint(x: border*3.5 + opacityLabel.frame.width, y: opacityLabel.center.y)
        background.addSubview(opacityValue)
        
        createColorSlider()
        createButtons()
    }
    
    func createSlider(type: String) {
        //Create constants
        let height = background.frame.height
        let cy = height/6
        
        //Set properties that are the same for all sliders
        let slider = UISlider(frame:CGRectMake(border, 0, view.bounds.width*(3/4), view.bounds.height*(1/16))) //Set x location as border so slider & label are aligned
        slider.continuous = true
        slider.tintColor = .whiteColor()
        slider.setThumbImage(UIImage(named: "whiteCircle"), forState: .Normal)
        
        //Set specific properties for slider
        switch type{
        case "Size":
            slider.minimumValue = 1
            slider.maximumValue = 50
            slider.value = Float(size)
            slider.addTarget(self, action: "changedSize:", forControlEvents: .ValueChanged)
            slider.center.y = space + cy*2.7
        case "Opacity":
            slider.minimumValue = 0.0
            slider.maximumValue = 1.0
            slider.value = Float(opacity)
            slider.addTarget(self, action: "changedOpacity:", forControlEvents: .ValueChanged)
            slider.center.y = space + cy*4.7
        default:
            break;
        }
        
        //Add slider to background view
        background.addSubview(slider)
    }
    
    //1/20 TO DO:
//    *Create preview that changes color, size, and opacity
//    *When press eraser, change image to blue eraser image
//    *Set eraser stroke to certain size and opacity
//    *Implement random color button
//    *Create uitoolbar for cancel "X" & done "v/"
    
    func createColorSlider() {
        //Set constant
        let width = background.frame.width
        
        //Create slider
        let colorSlider = ColorSlider()
        colorSlider.frame = CGRectMake(width*(9/10), space, 10, 150)
        colorSlider.borderColor = UIColor.whiteColor()
        colorSlider.previewEnabled = true
        colorSlider.addTarget(self, action: "changedColor:", forControlEvents: .ValueChanged)
        background.addSubview(colorSlider)
    }
    
    func changedSize(sender: UISlider!){
        size = round(CGFloat(sender.value)) //convert float value of slider to CGFloat
        sizeValue.text = "\(round(CGFloat(sender.value)))"
    }
    
    func changedOpacity(sender: UISlider!){
        opacity = CGFloat(round(sender.value*100)/100)//converts value of slider to whole # (i.e. 52.0). Then converts value of slider back to decimal (i.e. 0.52)
        opacityValue.text = "\(round(sender.value*100))%"
    }
    
    func changedColor(slider: ColorSlider) {
        strokeColor = slider.color
    }
    
    func createButtons(){
        //Set constants
        let width = background.frame.width
        let height = background.frame.height
        let size = background.frame.height/5
        
        //Create eraser button
        eraserButton.frame = CGRectMake(border, height/11, size, size) // X, Y, width, height
        eraserButton.setImage(UIImage(named: "EraserWhite"), forState: .Normal)
        eraserButton.addTarget(self, action: "eraserPressed:", forControlEvents: .TouchUpInside)
        
        //Create random color button
        
        //Add buttons to background view
        background.addSubview(eraserButton)
    }
    
    func eraserPressed(sender: UIButton!){
        eraserOn = !eraserOn
        eraserButton.selected = eraserOn
        eraserButton.setImage(UIImage(named: "EraserHighlighted"), forState: .Selected)
    }
    
    func createTempImageView(){
        let widthRatio = imageView.bounds.size.width / imageView.image!.size.width
        let heightRatio = imageView.bounds.size.height / imageView.image!.size.height
        let scale = min(widthRatio, heightRatio)
        let imageWidth = scale * imageView.image!.size.width
        let imageHeight = scale * imageView.image!.size.height
        
        tempImageView = UIImageView(frame:CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
        tempImageView.center = CGPoint(x: imageView.center.x, y: imageView.center.y)
        tempImageView.backgroundColor = UIColor.clearColor()
        view.insertSubview(tempImageView, aboveSubview: imageView)
    }
    
    override func touchesBegan(touches: Set<UITouch>,
        withEvent event: UIEvent?){
            isSwiping    = false
            if let touch = touches.first{
                lastPoint = touch.locationInView(tempImageView)
            }
    }
    
    override func touchesMoved(touches: Set<UITouch>,
        withEvent event: UIEvent?){
            imageView.image!.size.width
            isSwiping = true;
            if let touch = touches.first{
                let widthRatio = imageView.bounds.size.width / imageView.image!.size.width
                let heightRatio = imageView.bounds.size.height / imageView.image!.size.height
                let scale = min(widthRatio, heightRatio)
                let imageWidth = scale * imageView.image!.size.width
                let imageHeight = scale * imageView.image!.size.height
                
                let currentPoint = touch.locationInView(tempImageView)
            
                UIGraphicsBeginImageContext(CGSize(width: imageWidth, height: imageHeight))
                self.tempImageView.image?.drawInRect(CGRectMake(0, 0, imageWidth, imageHeight))
                CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y)
                CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y)
                CGContextSetLineCap(UIGraphicsGetCurrentContext(),CGLineCap.Round)
                CGContextSetLineWidth(UIGraphicsGetCurrentContext(), size)
                CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), strokeColor.colorWithAlphaComponent(opacity).CGColor)
                
                //If eraser button pressed, set blendmode to clear & eraser's size to 20
                if eraserOn == true{
                    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), CGBlendMode.Clear)
                    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 20)
                }
                
                CGContextStrokePath(UIGraphicsGetCurrentContext())
                self.tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                lastPoint = currentPoint
            }
    }
    
    override func touchesEnded(touches: Set<UITouch>,
        withEvent event: UIEvent?){
            if(!isSwiping) {
                let widthRatio = imageView.bounds.size.width / imageView.image!.size.width
                let heightRatio = imageView.bounds.size.height / imageView.image!.size.height
                let scale = min(widthRatio, heightRatio)
                let imageWidth = scale * imageView.image!.size.width
                let imageHeight = scale * imageView.image!.size.height
                
                UIGraphicsBeginImageContext(CGSize(width: imageWidth, height: imageHeight))
                self.tempImageView.image?.drawInRect(CGRectMake(0, 0, imageWidth, imageHeight))
                CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y)
                CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y)
                CGContextSetLineCap(UIGraphicsGetCurrentContext(),CGLineCap.Round)
                CGContextSetLineWidth(UIGraphicsGetCurrentContext(), size)
                CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), strokeColor.colorWithAlphaComponent(opacity).CGColor)
                
                //If eraser button pressed, set blendmode to clear
                if eraserOn == true{
                    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), CGBlendMode.Clear)
                    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), size)
                }
                
                CGContextStrokePath(UIGraphicsGetCurrentContext())
                self.tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
            }
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
    
}


