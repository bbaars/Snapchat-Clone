//
//  ObjectDataSource.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/28/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

class SelectedFriendsDelegateDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    var objects = [Any]()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        
        let label = GenericLabel(font: UserInterface.Fonts.avenirNextDemiBold, fontSize: 21)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = objects[indexPath.row] as? String ?? ""
        
        cell.contentView.addSubview(label)
        
        label.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let approxSize = CGSize(width: 2000, height: 50)
        let attributes = [NSAttributedString.Key.font: UIFont(name: UserInterface.Fonts.avenirNextDemiBold, size: 21)!]
        
        let estimatedFrame = NSString(string: objects[indexPath.row] as? String ?? "").boundingRect(with: approxSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return CGSize(width: estimatedFrame.width, height: estimatedFrame.height)
    }
}
