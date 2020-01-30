//
//  NewsStoryCollectionViewCell.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 2/27/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

class NewsStoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var newsStoryImage: UIImageView!
    @IBOutlet weak var newsStoryTitleLabel: UILabel!
    @IBOutlet weak var newsStoryTimeLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 7.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        self.backgroundColor = UserInterFace.Colors.chatColor
    }
}
