//
//  CameraRollViewController.swift
//  Project 3: Navigation
//
//  Created by Amanda Ong on 12/22/15.
//  Copyright © 2015 Amanda Ong. All rights reserved.
//

import UIKit

class CameraRollViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    

    
    var collectionView: UICollectionView!

    let friends = ["Christmas", "Yay", "So fun", "Chillin at Panera"]
    let imageArray = [UIImage(named: "friends1"), UIImage(named: "friends2"), UIImage(named: "friends3"), UIImage(named: "friends4")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        //Create flow layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 90, height: 120)
        
        //Create collection view table
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.friends.count
    }
    

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        
        /*//Create image view
        imageView  = UIImageView(frame:CGRectMake(10, 50, 100, 300));
        imageView.image = UIImage(named:"image.jpg")
        self.view.addSubview(imageView)

        
        cell.imageView?.image = self.imageArray[indexPath.row]
        cell.titleLabel?.text = self.friends[indexPath.row]
        */
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showImage", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showImage"{
            let indexPaths = self.collectionView!.indexPathsForSelectedItems()
            let indexPath = indexPaths![0] as NSIndexPath
            
            let vc = segue.destinationViewController as! NewViewController
            vc.image = self.imageArray[indexPath.row]!
            vc.title = self.friends[indexPath.row]
        }
    }
    
}
