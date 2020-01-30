//
//  CGRectExtension.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/7/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

extension CGSize {
    static func >=(left: CGSize, right: CGSize) -> Bool {
        let leftArea = left.width * left.height
        let rightArea = right.width * right.height
        
        return leftArea >= rightArea
    }
}
