//
//  ShapeViewController.swift
//  Project 3: Navigation
//
//  Created by Amanda Ong on 10/16/15.
//  Copyright © 2015 Amanda Ong. All rights reserved.
//

import UIKit

class ShapeViewController: UIViewController {
    var shape: String!
    var shapeView: UIView = UIView()
    var size: CGFloat = 25.0
    var width: CGFloat = 25.0
    var height: CGFloat = 25.0
    var views: [UIView] = []
    var eraser: Bool = false
    
    @IBOutlet weak var sizeSlider: UISlider!
    
    @IBOutlet weak var eraserButton: UIButton!
    
    @IBAction func eraserIsPressed(sender: AnyObject) {
        eraser = true
        sender.titleLabel??.textColor = UIColor.redColor()
    }
    
    @IBAction func paintIsPressed(sender: AnyObject) {
        eraser = false
    }
    
    @IBAction func sizeSliderValueChanged(sender: UISlider) {
        size = CGFloat(sender.value)
    }
    
    @IBOutlet weak var widthSlider: UISlider!
    
    @IBAction func widthSliderValueChanged(sender: UISlider) {
        width = CGFloat(sender.value)
    }
    
    @IBOutlet weak var heightSlider: UISlider!
    
    @IBAction func heightSliderValueChanged(sender: UISlider) {
        height = CGFloat(sender.value)
    }
    
    @IBOutlet weak var hideSwitch: UISwitch!
    
    @IBAction func switchPressed(sender: AnyObject) {
        if hideSwitch.on{
            for view in views{
                view.hidden = true
            }
        }
        else{
            for view in views{
                view.hidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    // Add shape to this view controller's view when we touch down
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if shape == "Square"{
            shapeView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
            shapeView.layer.cornerRadius = 0.0
        } else if shape == "Rectangle" {
            shapeView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            shapeView.layer.cornerRadius = 0.0
        } else if shape == "Circle" {
            shapeView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
            shapeView.layer.cornerRadius = size/2.0
        }
        if eraser == true {
            if let touch: UITouch! = touches.first!{
                if views.contains(touch.view!) {
                    let index = views.indexOf(touch.view!)
                    views.removeAtIndex(index!)
                    touch.view?.removeFromSuperview()
                }
            }
        }
        else if eraser == false {
            let location = touches.first!.locationInView(view)
            shapeView.center = location
            shapeView.backgroundColor = UIColor.greenColor()
            views.append(shapeView)
            view.addSubview(shapeView)
        }
    }
    
    // Add shape to this view controller's view when we touch down and move our finger
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if shape == "Square"{
            shapeView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
            shapeView.layer.cornerRadius = size/5.0
        } else if shape == "Rectangle" {
            shapeView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            shapeView.layer.cornerRadius = width/5.0
        } else if shape == "Circle" {
            shapeView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
            shapeView.layer.cornerRadius = size/2.0
        }
        let location = touches.first!.locationInView(view)
        shapeView.center = location
        shapeView.backgroundColor = UIColor.greenColor()
        views.append(shapeView)
        view.addSubview(shapeView)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
