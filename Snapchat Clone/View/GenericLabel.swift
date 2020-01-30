//
//  GenericLabel.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/27/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

class GenericLabel: UILabel {
    
    
    /// Create a generic label of Avenir Next 17.0 pt font.
    ///
    /// - Parameters:
    ///   - frame: The frame of the label (Defaults to .zero if no frame passed in)
    ///   - font: The font string (Defaults to avenirNext)
    ///   - fontSize: The size of the font (Defaults to 17.0
    convenience init(frame: CGRect = .zero, font: String = UserInterface.Fonts.avenirNext, fontSize: CGFloat = 17.0) {
        self.init(frame: frame)
        
        self.font = UIFont(name: font, size: fontSize)
        self.textAlignment = .left
        self.textColor = UIColor.darkText
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
