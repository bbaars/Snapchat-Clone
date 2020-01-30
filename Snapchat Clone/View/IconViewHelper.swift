//
//  IconView.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/15/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

extension UIView {
    
    static func getIconView(withImage image: UIImage, width: CGFloat = 20) -> UIView {
     
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: width).isActive = true
        
        return view
    }
}
