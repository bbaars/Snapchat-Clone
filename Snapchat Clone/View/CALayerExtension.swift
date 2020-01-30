//
//  CALayerExtension.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/15/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

extension CALayer {
    
    func addShadow() {
        self.shadowColor = UIColor.darkGray.cgColor
        self.shadowOffset = .zero
        self.shadowOpacity = 1.0
        self.shadowRadius = 0.8
    }
    
    func addRightToLeftTransition() {
        
        let transition = CATransition()
        transition.duration = 0.30
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        self.add(transition, forKey: kCATransition)
    }
    
    func addLeftToRightTransition() {
        
        let transition = CATransition()
        transition.duration = 0.20
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        self.add(transition, forKey: kCATransition)
    }
}
