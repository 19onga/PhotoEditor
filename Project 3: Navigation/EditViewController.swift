//
//  EditViewController.swift
//  Project 3: Navigation
//
//  Created by Amanda Ong on 12/23/15.
//  Copyright © 2015 Amanda Ong. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //View controller constants
    var toolbar : UIToolbar!
    var tempImageView = UIImageView()
    var imageView: UIImageView = UIImageView(image: UIImage(named: "ClearImage"))
        {
        didSet {
            tempImageView.image = imageView.image
            tempImageView.contentMode = .ScaleAspectFit
        }
    }
    var editbkd = UIView()
    var editTitle = UILabel()
    var backBtn = UIButton()

    //Drawing constants
    var lastPoint: CGPoint!
    var isSwiping: Bool!
    
    //Drawing sliders' layout constants
    let topbkd = UIView()
    let line = UIImageView()
    let background = UIView()
    let space = CGFloat(20)
    let border = CGFloat(10) //To align slider & label

    //Size slider constants
    let sizeSldr = UISlider()
    var size: CGFloat = 9
    var sizeValue = UILabel()
    
    //Opacity slider constants
    let opacSldr = UISlider()
    var opacity: CGFloat = 1.0
    var opacityValue = UILabel()
    
    //Color slider constants
    let colorSlider = ColorSlider()
    var strokeColor = UIColor.blackColor()

    //Drawing buttons constants
    let doneBtn = UIButton()
    let cancelBtn = UIButton()
    
    let eraserBtn = UIButton()
    var eraserOn = false

    let randomBtn = UIButton()
    var random = false
    
    let downBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()

        //Create edit background
        editbkd.frame = CGRectMake(0,0, view.bounds.width, view.bounds.height*(1.2/16))
        editbkd.center = CGPoint(x: view.bounds.width/2, y: -view.bounds.height*2)
        editbkd.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.4)
        self.view.addSubview(editbkd)
        
        //Create constants
        let editWid = editbkd.frame.width
        let editHgt = editbkd.frame.height
        let backSize = editbkd.frame.width*0.12
        
        //Create edit title
        editTitle.frame = CGRectMake(0, 0, editWid/4, editHgt)
        editTitle.center = CGPoint(x: editWid/2, y: editHgt/2 + 5)
        editTitle.textAlignment = NSTextAlignment.Center
        editTitle.font = UIFont (name: "AvenirNext-Regular", size: 20)
        editTitle.textColor = UIColor.whiteColor()
        editTitle.text = "Edit"
        editbkd.addSubview(editTitle)
        
        //Create back button
        backBtn.frame = CGRectMake(0, 0, backSize, backSize)
        backBtn.center = CGPoint(x: editWid*(1/16), y: editHgt*(5/8))
        backBtn.setImage(UIImage(named: "Back"), forState: .Normal)
        backBtn.addTarget(self, action: "back:", forControlEvents: .TouchUpInside)
        editbkd.addSubview(backBtn)
        
        createToolBar()
        
        //Animate
        UIView.animateWithDuration(0.3, animations: {
            self.toolbar.center.y = 0.9*self.view.bounds.height + self.toolbar.frame.height/2
            self.editbkd.center.y = self.editbkd.frame.height/2
        })
        
        //createNavigationBar()
    }
    
    func back(sender: UIButton!){
        self.dismissViewControllerAnimated(true, completion: nil)
        if let navigationController = self.navigationController
        {
            navigationController.popViewControllerAnimated(true)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
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
    
    func createToolBar(){
        toolbar = UIToolbar()
        //toolbar.barStyle = UIBarStyle.Black
        toolbar.barTintColor = UIColor.darkGrayColor()
        
        //Set constants
        let width = view.bounds.width
        let height = view.bounds.height
        
        // Bounds is now correctly set
        toolbar.frame = CGRect(x: 0, y: height-height*0.1, width: width, height: height*0.1)
        toolbar.center = CGPoint(x: width/2, y: height*2)
        
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

    func draw(sender: UIButton!) {
        //Create copy of image to draw on
        createTempImageView()
        
        //Create background for cancel & done button
        topbkd.frame = CGRectMake(0,0, view.bounds.width, view.bounds.height*(1.2/16))
        topbkd.center = CGPoint(x: view.bounds.width/2, y: -view.bounds.height*2)
        topbkd.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.4)
        self.view.addSubview(topbkd)
        
        createTopBkdBtns()
        
        //Create background for sliders
        background.frame = CGRectMake(0,0, view.bounds.width, view.bounds.height*(1/4))
        background.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.4)
        background.center = CGPoint(x: view.bounds.width/2, y: view.bounds.height*2)
        self.view.addSubview(background)
        
        //Dismiss toolbar & edit bar. Show drawing toolbar & top bar.
        UIView.animateWithDuration(0.3, animations: {
            self.toolbar.center.y = self.view.bounds.height*2
            self.editbkd.center.y = -self.view.bounds.height*2
            self.background.center.y = self.view.bounds.height-self.background.frame.height/2
            self.topbkd.center.y = self.topbkd.frame.height/2
        })
        //Create sliders & buttons
        createSliders()
        createColorSlider()
        createButtons()
        
        //Reset tools to original state
        resetDrawTools()
    }
    
    func createTopBkdBtns() {
        //Create constants
        let size1 = topbkd.frame.height*(5/8) //size for done button
        let size2 = topbkd.frame.height*(4.7/8) //size for cancel button
        let topWidth = topbkd.frame.width
        let topHeight = topbkd.frame.height
        
        //Create line to separate buttons
        line.frame = CGRectMake(0, 0, topWidth/10, topHeight-25)
        line.image = UIImage(named: "Line")
        line.center = CGPoint(x: topWidth/2, y: topHeight*(5/8))
        topbkd.addSubview(line)
        
        //Create done button
        doneBtn.frame = CGRectMake(0, 0, size1, size1)
        doneBtn.center = CGPoint(x: topWidth*(3/4), y: topHeight*(5/8))
        doneBtn.setImage(UIImage(named: "Done"), forState: .Normal)
        doneBtn.addTarget(self, action: "done:", forControlEvents: .TouchUpInside)
        topbkd.addSubview(doneBtn)
        
        //Create cancel button
        cancelBtn.frame = CGRectMake(0, 0, size2, size2)
        cancelBtn.center = CGPoint(x: topWidth/4, y: topHeight*(5/8))
        cancelBtn.setImage(UIImage(named: "Cancel"), forState: .Normal)
        cancelBtn.addTarget(self, action: "cancel:", forControlEvents: .TouchUpInside)
        topbkd.addSubview(cancelBtn)
    }
    
    func done(sender: UIButton!){
        //Get width & height of scaled image
        let widthRatio = imageView.bounds.size.width / imageView.image!.size.width
        let heightRatio = imageView.bounds.size.height / imageView.image!.size.height
        let scale = min(widthRatio, heightRatio)
        let imageWidth = scale * imageView.image!.size.width
        let imageHeight = scale * imageView.image!.size.height
        
        //Draw bitmap that is the size of scaled image, scales based on phone screensize,
        UIGraphicsBeginImageContextWithOptions(CGSize(width: imageWidth, height: imageHeight), false, 0.0);
        imageView.image?.drawInRect(CGRectMake(0, 0, imageWidth, imageHeight))
        tempImageView.image?.drawInRect(CGRectMake(0, 0, imageWidth, imageHeight))
        tempImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    
        imageView.image = screenshot
        tempImageView.image = nil
        downBtnPressed(doneBtn)
    }
    
    func cancel(sender: UIButton!){
        tempImageView.image = nil
        tempImageView.removeFromSuperview()
        downBtnPressed(cancelBtn)
    }
    
    func createSliders() {
        //Create constants
        let height = background.frame.height
        let cy = height/6
        
        //Create size slider
        sizeSldr.frame = CGRectMake(border, 0, view.bounds.width*(3/4), view.bounds.height*(1/16)) //Set x location as border so slider & label are aligned
        sizeSldr.continuous = true
        sizeSldr.tintColor = .whiteColor()
        sizeSldr.setThumbImage(UIImage(named: "whiteCircle"), forState: .Normal)
        sizeSldr.minimumValue = 1
        sizeSldr.maximumValue = 50
        sizeSldr.value = Float(size)
        sizeSldr.addTarget(self, action: "changedSize:", forControlEvents: .ValueChanged)
        sizeSldr.center.y = space + cy*2.7
        background.addSubview(sizeSldr)
        
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
        
        //Create opacity slider
        opacSldr.frame = CGRectMake(border, 0, view.bounds.width*(3/4), view.bounds.height*(1/16)) //Set x location as border so slider & label are aligned
        opacSldr.continuous = true
        opacSldr.tintColor = .whiteColor()
        opacSldr.setThumbImage(UIImage(named: "whiteCircle"), forState: .Normal)
        opacSldr.minimumValue = 0.0
        opacSldr.maximumValue = 1.0
        opacSldr.value = Float(opacity)
        opacSldr.addTarget(self, action: "changedOpacity:", forControlEvents: .ValueChanged)
        opacSldr.center.y = space + cy*4.7
        background.addSubview(opacSldr)
        
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
    }
    
    //1/20 TO DO:
//    *Glitch: when take screenshot, opaque colors become brighter
//    *Create back button to go to camera roll
//    *Fix transtion from camera roll to editviewcontroller to slide from right
//    *Set SOLID color for edit, top, & drawing bars & toolbar
//    *Save image to Camera library, share on FB, Twitter, Instagram
//    *Use tab view controller to make switching around for text
    
    func createColorSlider() {
        //Set constant
        let width = background.frame.width
        
        //Create slider
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
        let drawBtnSize = background.frame.height/5
        
        //Create eraser button
        eraserBtn.frame = CGRectMake(border, height/11, drawBtnSize, drawBtnSize) // X, Y, width, height
        eraserBtn.backgroundColor = UIColor.clearColor()
        eraserBtn.layer.cornerRadius = 5
        eraserBtn.layer.borderWidth = 1
        eraserBtn.layer.borderColor = UIColor.whiteColor().CGColor
        eraserBtn.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4)
        eraserBtn.setImage(UIImage(named: "EraserWhite"), forState: .Normal)
        changeBtnColor(eraserBtn, origImage: UIImage(named: "EraserWhite")!, tintClr: .blackColor(), ctrlState: .Selected)
        eraserBtn.addTarget(self, action: "eraserPressed:", forControlEvents: .TouchUpInside)
        
        //Create random color button
        randomBtn.frame = CGRectMake(border*3 + eraserBtn.frame.width, height/11, drawBtnSize, drawBtnSize)
        randomBtn.backgroundColor = UIColor.clearColor()
        randomBtn.layer.cornerRadius = 5
        randomBtn.layer.borderWidth = 1
        randomBtn.layer.borderColor = UIColor.whiteColor().CGColor
        randomBtn.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4)
        randomBtn.setImage(UIImage(named: "MustacheWhite"), forState: .Normal)
        randomBtn.addTarget(self, action: "randomBtnPressed:", forControlEvents: .TouchUpInside)
        
        //Create down button
        downBtn.frame = CGRectMake(0, 0, height/8, height/9)
        downBtn.center = CGPoint(x: width/2, y: border)
        downBtn.setImage(UIImage(named: "DownArrow"), forState: .Normal)
        downBtn.addTarget(self, action: "downBtnPressed:", forControlEvents: .TouchUpInside)
        
        //Add buttons to background view
        background.addSubview(eraserBtn)
        background.addSubview(randomBtn)
        background.addSubview(downBtn)
    }
    
    func eraserPressed(sender: UIButton!){
        eraserOn = !eraserOn
        
        //Change button color when buttton is selected
        eraserBtn.selected = eraserOn
        
        //Change button's background & border when button is/isn't selected
        if eraserOn == true{
            eraserBtn.backgroundColor = .whiteColor()
            eraserBtn.layer.borderColor = UIColor.blackColor().CGColor
        }
        else {
            eraserBtn.backgroundColor = UIColor.clearColor()
            eraserBtn.layer.borderColor = UIColor.whiteColor().CGColor
        }
    }
    
    func randomBtnPressed(sender: UIButton!){
        //Random btn is on
        random = true
        
        //Generate random color & assign it to stroke color
        let randomColor = getRandomColor()
        strokeColor = randomColor
        
        //Change button color when buttton is selected
        randomBtn.selected = random
        changeBtnColor(randomBtn, origImage: UIImage(named: "MustacheWhite")!, tintClr: randomColor, ctrlState: .Selected)
        
        if random == true{
            randomBtn.backgroundColor = .whiteColor()
            randomBtn.layer.borderColor = randomColor.CGColor
        }
        else {
            randomBtn.backgroundColor = UIColor.clearColor()
            randomBtn.layer.borderColor = UIColor.whiteColor().CGColor
        }
    }
  
    func getRandomColor() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    func changeBtnColor(button: UIButton, origImage: UIImage, tintClr: UIColor, ctrlState: UIControlState){
        let tintedImage = origImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        button.setImage(tintedImage, forState: ctrlState)
        button.tintColor = tintClr
    }
    
    func downBtnPressed(sender: UIButton!){
        //Create constant
        let viewheight = view.bounds.height
        
        //Move toolbar back up & background back down
        UIView.animateWithDuration(0.3, animations: {
            self.toolbar.center.y = viewheight*0.9 + self.toolbar.frame.size.height/2
            self.editbkd.center.y = self.editbkd.frame.height/2
            self.background.center.y = viewheight*2
            self.topbkd.center.y = -viewheight*2
        })
        
        //Remove image from tempImageView & remove tempImageView
        tempImageView.image = nil
        tempImageView.removeFromSuperview()
    }
    
    func resetDrawTools(){
        sizeSldr.value = 9
        sizeValue.text = "9.0"
        size = 9
        
        opacSldr.value = 1.0
        opacityValue.text = "100%"
        opacity = 1.0
        
        strokeColor = UIColor.blackColor()

        eraserBtn.selected = false
        eraserBtn.backgroundColor = UIColor.clearColor()
        eraserBtn.layer.borderColor = UIColor.whiteColor().CGColor
        
        randomBtn.selected = false
        randomBtn.backgroundColor = UIColor.clearColor()
        randomBtn.layer.borderColor = UIColor.whiteColor().CGColor
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
                    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 20)
                }
                
                CGContextStrokePath(UIGraphicsGetCurrentContext())
                self.tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
            }
    }
}

//    func createNavigationBar(){
//        //Set constants
//        let width = view.bounds.width
//        let height = view.bounds.height
//
//        // Create the navigation bar
//        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, width, height*0.1))
//        navigationBar.barTintColor = UIColor.whiteColor()
//
//        //Create navigation bar's title
//        self.navigationController?.navigationBar.topItem?.title = "Edit"
//        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 34)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
//
//        //Create back button
//        let backBtn = UIButton(type: UIButtonType.Custom)
//        backBtn.frame = CGRectMake(0, 0, 50, 50)
//        backBtn.setImage(UIImage(named: "BackIcon"), forState: UIControlState.Normal)
//        backBtn.addTarget(self, action: "back:", forControlEvents: UIControlEvents.TouchUpInside)
//        backBtn.sizeToFit()
//        let backButtonItem = UIBarButtonItem(customView: backBtn)
//        self.navigationItem.leftBarButtonItem = backButtonItem
//
//        //Add navigation bar to view
//        self.view.addSubview(navigationBar)
//    }


