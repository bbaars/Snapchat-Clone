//
//  ConfigurableCell.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/30/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

public protocol ConfigurableCell: ReusableCell {
    associatedtype T
    
    func configureCell(with item: T, at indexPath: IndexPath)
}
