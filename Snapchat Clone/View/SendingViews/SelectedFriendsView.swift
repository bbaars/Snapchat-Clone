//
//  SelectedFriendsCollectionView.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/28/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

class SelectedFriendsView: UIView {

    private var cellID = "SelectedFriendCell"
    
    private var dataSource = SelectedFriendsDelegateDataSource()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        layout.minimumInteritemSpacing = 1000
        layout.minimumLineSpacing = 8
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.allowsSelection = false
        cv.backgroundColor = .clear
        cv.dataSource = dataSource
        cv.delegate = dataSource
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.contentSize.width = self.frame.size.width / 2
        cv.isScrollEnabled = false
        cv.clipsToBounds = true
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        
        self.backgroundColor = UserInterface.Colors.chatBlue
        
        addSubview(collectionView)
        
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -32).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    public func add(name: String) {
        
        let totalFriends = dataSource.objects.count
        let newIndexPath = [IndexPath(item: totalFriends, section: 0)]
        
        collectionView.performBatchUpdates({
            dataSource.objects.append(name + ",")
            collectionView.insertItems(at: newIndexPath)
        }) { (didFinish) in
            if (didFinish) {
                self.collectionView.reloadItems(at: newIndexPath)
                self.collectionView.scrollToItem(at: IndexPath(item: totalFriends, section: 0), at: .right, animated: true)
            }
        }
    }
    
    public func remove(name: String) {
        
        collectionView.performBatchUpdates({
            self.dataSource.objects.removeLast()
            let indexPath = [IndexPath(item: self.dataSource.objects.count, section: 0)]
            self.collectionView.deleteItems(at: indexPath)
        }) { (didFinish) in
            if didFinish {
                self.collectionView.reloadItems(at: self.collectionView.indexPathsForVisibleItems)
            }
        }
        
        if dataSource.objects.isEmpty {
            self.removeFromSuperview()
        }
    }
}
