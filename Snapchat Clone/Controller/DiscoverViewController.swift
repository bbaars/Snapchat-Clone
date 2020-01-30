//
//  DiscoverViewController.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 2/23/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController, ColorView, SearchBarText {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewTopConstraint: NSLayoutConstraint!
    
    var controllerBackgroundColor: UIColor {
        return UserInterface.Colors.discoverPurple
    }
    
    var searchBarText: String {
        return UserInterface.SearchBarText.discover
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionViewTopConstraint.constant = 100
        collectionView.layer.cornerRadius = UserInterface.Elements.cornerRadius
    }
}

extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryboardStrings.CollectionViewCells.newsStory.rawValue, for: indexPath) as? NewsStoryCollectionViewCell {
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}
