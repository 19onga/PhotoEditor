//
//  NewViewController.swift
//  Project 3: Navigation
//
//  Created by Amanda Ong on 12/22/15.
//  Copyright © 2015 Amanda Ong. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var image = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = self.image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
