//
//  ReusableCell.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/30/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

public protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

public extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

