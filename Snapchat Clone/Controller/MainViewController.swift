//
//  ViewController.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 2/23/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var cameraIconView: CameraIconVIew!
    
    lazy var chatViewController: UIViewController? = {
        return storyboard?.instantiateViewController(withIdentifier: StoryboardStrings.ViewControllers.chat.rawValue)
    }()
    
    lazy var discoverViewController: UIViewController? = {
        return storyboard?.instantiateViewController(withIdentifier: StoryboardStrings.ViewControllers.discover.rawValue)
    }()
    
    lazy var filterViewController: UIViewController? = {
        return storyboard?.instantiateViewController(withIdentifier: StoryboardStrings.ViewControllers.filter.rawValue)
    }()
    
    var scrollViewController: ScrollViewController!
    var cameraViewController: CameraViewController!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraIconView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // get references to the scroll view controller / camera controller
        if let controller = segue.destination as? ScrollViewController {
            scrollViewController = controller
            scrollViewController.delegate = self
        } else if let controller = segue.destination as? CameraViewController {
            cameraViewController = controller
        }
    }
}

extension MainViewController: CameraTouchEventsDelegate {
    func cameraButtonPressed() {
        cameraViewController.takePhoto()
    }
    
    func flipCamera() {
        cameraViewController.flipCamera()
    }
    
    func toggleFlash() {
        cameraViewController.toggleFlash()
    }
}

extension MainViewController : ScrollViewControllerDelegate {
    var viewControllers: [UIViewController?] {
        return [chatViewController, filterViewController, discoverViewController]
    }
    
    var initialViewController: UIViewController? {
        return filterViewController
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // animate the icons on the camera icon view
        
        // 1. Get the offset of the scroll view in the x-axis
        // 2. Normalize to obtain a 0-1 value
        // 3. Get the current view controller
        // 3. Animate
        
        // (x - min) / (max - min)
        
        let min: CGFloat = 0
        let max: CGFloat = scrollViewController.pageSize.width
        
        let x = scrollView.contentOffset.x
        let percentage = (x - min) / (max - min) - 1
        
        let currentViewController = scrollViewController.getCurrentlyVisibleColorViewController()
        let majorityShowingViewController = scrollViewController.getMajorityVisibleViewController()
        
        cameraIconView.animate(with: percentage, to: currentViewController)
        cameraIconView.animateSearchBar(with: percentage, to: majorityShowingViewController)
    }
}
