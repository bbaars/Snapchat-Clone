//
//  ScrollViewController.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 2/23/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

protocol ScrollViewControllerDelegate {
    var viewControllers: [UIViewController?] { get }
    var initialViewController: UIViewController? { get }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}

class ScrollViewController: UIViewController {
    
    private var scrollView: UIScrollView {
        return self.view as! UIScrollView
    }
    
    public var pageSize: CGSize {
        return scrollView.frame.size
    }
    
    private var viewControllers: [UIViewController?]!
    
    var delegate: ScrollViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        
        self.view = scrollView
        self.view.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // add our view controllers to the scroll view subview
        viewControllers = delegate?.viewControllers
        
        // loop over each view controller, find necessary frame, add as a subview
        for (index, controller) in viewControllers.enumerated() {
            if let controller = controller {
                addChild(controller)
                controller.view.frame = getFrame(for: index)
                scrollView.addSubview(controller.view)
                controller.didMove(toParent: self)
            }
        }
        
        // set the content size of the scrollview
        scrollView.contentSize = CGSize(width: CGFloat(viewControllers.count) * pageSize.width,
                                        height: pageSize.height)
        
        // set the initial view controller
        if let controller = delegate?.initialViewController {
            setScrollView(to: controller, animated: false)
        }
    }
}

fileprivate extension ScrollViewController {
    
    func getFrame(for index: Int) -> CGRect {
        return CGRect(x: CGFloat(index) * pageSize.width,
                      y: 0,
                      width: pageSize.width,
                      height: pageSize.height)

    }
    
    func setScrollView(to controller: UIViewController?, animated: Bool) {

        // 1. get the index of the initial view controller
        // 2. scroll the scrollview to that index/controller
        guard let index = getIndex(for: controller) else { return }
        scrollView.setContentOffset(CGPoint(x: pageSize.width * CGFloat(index), y: 0), animated: animated)
    }
    
    func getIndex(for controller: UIViewController?) -> Int? {
        return viewControllers.firstIndex(where: { $0 == controller })
    }
}

extension ScrollViewController {
    func getCurrentlyVisibleColorViewController() -> UIViewController? {
        
        for controller in viewControllers {
            if let controller = controller, controller is ColorView, controller.view.frame.intersects(scrollView.bounds) {
                return controller
            }
        }
        
        return nil
    }
    
    func getMajorityVisibleViewController() -> UIViewController? {
        
        var biggestViewController: UIViewController?
        var biggestFrame = CGRect.zero
        
        for controller in viewControllers {
            if let controller = controller {
                let frame = controller.view.frame.intersection(scrollView.bounds)
                
                if frame.size >= biggestFrame.size {
                    biggestFrame = frame
                    biggestViewController = controller
                }
            }
        }
        
        return biggestViewController
    }
}

extension ScrollViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll(scrollView)
    }
}
