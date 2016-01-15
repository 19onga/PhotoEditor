//
//  CollectionViewCell.swift
//  Project 3: Navigation
//
//  Created by Amanda Ong on 12/22/15.
//  Copyright © 2015 Amanda Ong. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override var highlighted: Bool {
        didSet {
            if (highlighted) {
                self.layer.opacity = 0.6;
            } else {
                self.layer.opacity = 1.0;
            }
        }
    }
    
}

