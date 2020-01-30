//
//  ColorVIew.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/6/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

protocol ColorView {
    var controllerBackgroundColor: UIColor { get }
}

class ColorUIView: UIView {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)

        return view == self ? nil : view
    }
}
