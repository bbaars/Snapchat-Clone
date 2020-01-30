//
//  FriendTableViewCell.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/27/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

class FriendTableViewCell: GenericBaseTableViewCell, ConfigurableCell {
    typealias T = FriendViewModel

    private var nameLabel: GenericLabel = {
        return GenericLabel(font: UserInterface.Fonts.avenirNextMedium)
    }()
    
    private var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "avatar14")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var checkedImage: UIImageView = {
        let checkedImage = UIImageView(image: UIImage(named: "checkmark")!)
        checkedImage.translatesAutoresizingMaskIntoConstraints = false
        checkedImage.contentMode = .scaleAspectFit
        return checkedImage
    }()
    
    func configureCell(with item: FriendViewModel, at indexPath: IndexPath) {
        nameLabel.text = item.name
        userImage.image = item.avatarImage
    }
    
    override func setupView() {
        
        nameLabel.text = "Cornelius Scott"
        
        addSubview(nameLabel)
        addSubview(userImage)
        addSubview(checkedImage)
        
        userImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8.0).isActive = true
        userImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 16.0).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: userImage.centerYAnchor).isActive = true
        nameLabel.sizeToFit()
        
        checkedImage.topAnchor.constraint(equalTo: userImage.topAnchor, constant: -4).isActive = true
        checkedImage.rightAnchor.constraint(equalTo: userImage.rightAnchor, constant: 2).isActive = true
        checkedImage.widthAnchor.constraint(equalToConstant: 16).isActive = true
        checkedImage.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        checkedImage.isHidden = true
    }
    
    public func setCellToSelected(isShowing: Bool) {
        
        if (isShowing) {
            
            nameLabel.textColor = UserInterface.Colors.chatBlue
            nameLabel.font = UIFont(name: UserInterface.Fonts.avenirNextDemiBold, size: 18.0)
            
            checkedImage.isHidden = false
            checkedImage.transform = CGAffineTransform(scaleX: 0, y: 0)
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.checkedImage.transform = .identity
            }, completion: nil)
            
        } else {
            nameLabel.textColor = .darkText
            nameLabel.font = UIFont(name: UserInterface.Fonts.avenirNextMedium, size: 17.0)
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.checkedImage.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
            }) { (didFinish) in
                if (didFinish) {
                    self.checkedImage.isHidden = true
                    self.checkedImage.transform = .identity
                }
            }
        }
    }
}
