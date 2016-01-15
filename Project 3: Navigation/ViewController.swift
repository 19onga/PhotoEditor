//
//  ViewController.swift
//  Project 3: Navigation
//
//  Created by Amanda Ong on 10/13/15.
//  Copyright © 2015 Amanda Ong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create background & 3 buttons with their labels
        createBackground()
        createButton("Edit")
        createButton("Saved")
        createButton("Deleted")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: animated)
//        self.navigationController?.setToolbarHidden(false, animated: animated)
//    }
    
    func createBackground() {
        let backgroundImage = UIImage(named: "pinetree")
        var imageView: UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = backgroundImage
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    func createButton(buttonType: String) {
        //Set constants
        let space = CGFloat(15)
        let h = view.bounds.height - (space*2)
        let cy = h/6
        let cx = view.bounds.width/2
        let size = view.bounds.width/3
        
        //Set properties that are the same for all buttons & labels
        let button = UIButton();
        let label = UILabel(frame: CGRectMake(0, 0, size*2, size*2))
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont (name: "AvenirNext-Regular", size: 18)
        label.textColor = UIColor.whiteColor()

        //Create different button with their labels depending on type of button called
        switch buttonType{
        case "Edit":
            button.frame = CGRectMake(0, 0, size, size) // X, Y, width, height
            button.center.x = cx
            button.center.y = space + cy
            button.setImage(UIImage(named: "PlusIcon"), forState: .Normal)
            button.addTarget(self, action: "editButtonPressed:", forControlEvents: .TouchUpInside)
            label.center = CGPointMake(cx, button.center.y + size/2 + space)
            label.text = "Edit Photo"
        case "Saved":
            button.frame = CGRectMake(0, 0, size, size) // X, Y, width, height
            button.center.x = cx
            button.center.y = space + cy*3
            button.setImage(UIImage(named: "SavedIcon"), forState: .Normal)
            button.addTarget(self, action: "savedButtonPressed:", forControlEvents: .TouchUpInside)
            label.center = CGPointMake(cx, button.center.y + size/2 + space)
            label.text = "Saved Photos"
        case "Deleted":
            button.frame = CGRectMake(0, 0, size, size) // X, Y, width, height
            button.center.x = cx
            button.center.y = space + cy*5
            button.setImage(UIImage(named: "DeleteIcon"), forState: .Normal)
            button.addTarget(self, action: "deletedButtonPressed:", forControlEvents: .TouchUpInside)
            label.center = CGPointMake(cx, button.center.y + size/2 + space)
            label.text = "Recently Deleted"
        default:
            break;
        }
        
        //Add button & label to view
        self.view.addSubview(button)
        self.view.addSubview(label)
    }
    
    
    func editButtonPressed(sender:UIButton!)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            //imagePicker.mediaTypes = [kUTTypeImage];
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let secondViewController = EditViewController()
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            secondViewController.imageView.contentMode = .ScaleAspectFit
            secondViewController.imageView.image = pickedImage
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        presentViewController(secondViewController, animated: true, completion: nil)
    }
        
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    func savedButtonPressed(sender:UIButton!)
    {
        print("saved button was pressed")
    }
    
    func deletedButtonPressed(sender:UIButton!)
    {
        print("delete button was pressed")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image:UIImage, editingInfo: [String : AnyObject]?) {
//        
//        self.dismissViewControllerAnimated(true, completion: nil)
//        
//        let svc = self.storyboard!.instantiateViewControllerWithIdentifier("imageViewer") as! ImageViewController
//        svc.image = image
//        
//        self.presentViewController(svc, animated: true, completion: nil)
//    }
    
//    @IBOutlet weak var createCollage: UIButton!
//    
//    @IBOutlet weak var pushRed: UIButton!
//    
//    @IBOutlet weak var pushBlue: UIButton!
//    
//    @IBAction func unwindToMainView (sender: UIStoryboardSegue){
//    }
//    
//    @IBOutlet weak var triangle: UIButton!
//    @IBOutlet weak var square: UIButton!
//    @IBOutlet weak var rectangle: UIButton!
//    
//    var shape: ShapeViewController!
//    
//    @IBAction func pressedTriangle(sender: AnyObject) {
//    }
//    
//    @IBAction func pressedSquare(sender: AnyObject) {
//    }
//    
//    @IBAction func pressedRectangle (sender: AnyObject) {
//    }
//    
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "showSquare" {
//            if let shapeViewController = segue.destinationViewController as? ShapeViewController {
//                shapeViewController.shape = "Square"
//            }
//        }
//        if segue.identifier == "showCircle"{
//            if let shapeViewController = segue.destinationViewController as? ShapeViewController {
//                shapeViewController.shape = "Circle"
//            }
//        }
//        if segue.identifier == "showRectangle"{
//            if let shapeViewController = segue.destinationViewController as? ShapeViewController {
//                shapeViewController.shape = "Rectangle"
//            }
//        }
//    }
}