//
//  GenericBaseTableViewCell.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/27/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

class GenericBaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView() {
        preconditionFailure("Class must override this method to use \(self)")
    }
}
