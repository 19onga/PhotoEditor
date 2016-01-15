//
//  RandomColorViewController.swift
//  Project 3: Navigation
//
//  Created by Amanda Ong on 10/13/15.
//  Copyright © 2015 Amanda Ong. All rights reserved.
//

import UIKit

class RandomColorViewController: UIViewController {

    func getRandomColor() -> UIColor{
        let randomRed = CGFloat(drand48())
        let randomGreen = CGFloat(drand48())
        let randomBlue = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = getRandomColor()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Add shape to this view controller's view when we touch down
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let location = touches.first!.locationInView(view)
        let shapeView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        shapeView.center = location
        shapeView.backgroundColor = getRandomColor()
        shapeView.layer.cornerRadius = 10
        view.addSubview(shapeView)
    }
    
    // Add shape to this view controller's view when we touch down and move our finger
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let location = touches.first!.locationInView(view)
        let shapeView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        shapeView.center = location
        shapeView.backgroundColor = getRandomColor()
        shapeView.layer.cornerRadius = 10
        view.addSubview(shapeView)
    }


}
