//
//  NavigationView.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 2/23/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

protocol CameraTouchEventsDelegate: AnyObject {
    func cameraButtonPressed()
    func flipCamera()
    func toggleFlash()
}

class CameraIconVIew: UIView {
    
    // Camera Outlets
    @IBOutlet weak var cameraButtonContainerView: UIView!
    @IBOutlet weak var cameraIcon: UIImageView!
    
    @IBOutlet weak var cameraButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var cameraButtonBottomConstraint: NSLayoutConstraint!
    
    // Camera Action Button Outlets
    @IBOutlet weak var flipCameraContainerView: UIView!
    @IBOutlet weak var flashContainerView: UIView!
    @IBOutlet weak var flashIcon: UIImageView!

    @IBOutlet weak var flipCameraIcon: UIImageView!
    @IBOutlet weak var flipCameraRightConstraint: NSLayoutConstraint!
    
    // Chat Icon Outlets
    @IBOutlet weak var chatIconContainerView: UIView!
    @IBOutlet weak var chatIcon: UIImageView!
    
    @IBOutlet weak var chatIconBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatIconHorizontalConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatIconWidthConstraint: NSLayoutConstraint!
    
    // Discover Icon Outlets
    @IBOutlet weak var discoverIconContainerView: UIView!
    @IBOutlet weak var discoverIcon: UIImageView!
    
    @IBOutlet weak var discoverIconHorizontalConstraint: NSLayoutConstraint!
    
    // Search Icon Outlets
    @IBOutlet weak var searchIcon: UIImageView!
    @IBOutlet weak var searchBar: UITextField!
    
    // Add User Icon
    @IBOutlet weak var addUserIcon: UIImageView!
    
    // Add User Outlets
    @IBOutlet weak var addUserIconRightConstraint: NSLayoutConstraint!
    
    // Color View
    @IBOutlet weak var colorView: UIView!
    
    // Indicator View
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var indicatorViewHorizontalConstraint: NSLayoutConstraint!
    @IBOutlet weak var indicatorWidthConstraint: NSLayoutConstraint!
    
    // Avatar Icon
    @IBOutlet weak var avatarIcon: UIImageView!
    
    weak var delegate: CameraTouchEventsDelegate?
    
    lazy var cameraButtonBottomConstraintConstant: CGFloat = {
        return cameraButtonBottomConstraint.constant
    }()
    
    lazy var cameraButtonWidthConstraintConstant: CGFloat = {
        return cameraButtonWidthConstraint.constant
    }()
    
    lazy var chatButtonBottomConstraintConstant: CGFloat = {
        return chatIconBottomConstraint.constant
    }()
    
    lazy var chatButtonWidthConstraintConstant: CGFloat = {
        return chatIconWidthConstraint.constant
    }()
    
    lazy var flipCameraConstraintConstant: CGFloat = {
        return flipCameraRightConstraint.constant
    }()
    
    lazy var indicatorViewHorizontalConstraintConstant: CGFloat = {
        return indicatorViewHorizontalConstraint.constant
    }()
    
    lazy var indicatorWidthConstraintConstant: CGFloat = {
        return indicatorWidthConstraint.constant
    }()
    
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)

        return view == self ? nil : view
    }
    
    // guaranteed the subviews will be allocated and initiliazed and all the outlet
    // instances will be set.
    override func awakeFromNib() {
        super.awakeFromNib()

        setupIcons()
        
        indicatorView.layer.cornerRadius = indicatorView.frame.width / 2
        
        searchBar.delegate = self
        searchBar.returnKeyType = .done
    }

    private func setupIcons() {

        searchIcon.layer.addShadow()
        addUserIcon.layer.addShadow()
        flipCameraIcon.layer.addShadow()
        flashIcon.layer.addShadow()
        cameraIcon.layer.addShadow()
        cameraIcon.layer.addShadow()
        chatIcon.layer.addShadow()
        indicatorView.layer.addShadow()
        
        layoutIfNeeded()
    }
    public func animate(with percent: CGFloat, to controller: UIViewController?) {
        
        let absPercent = abs(percent)
        
        // animate all of our constraints
        animateIconsDown(with: absPercent)
        animateIconsHorizontalPosition(with: absPercent)
        animateCameraActionIcons(with: absPercent)
        animateColorView(with: absPercent, to: controller)
        animateIconScale(with: absPercent)
        animateIndicatorView(with: -percent)
        animateIndicatorViewAlpha(with: absPercent)
    }
    
    public func animateSearchBar(with percent: CGFloat, to controller: UIViewController?) {
        
         let absPercent = abs(percent)
        
        animateSearchBarText(with: absPercent, to: controller)
    }
    
    // MARK: - Gesture Recognizers
    @IBAction
    func flipCameraPressed(_ tapGesture: UITapGestureRecognizer) {
        delegate?.flipCamera()
        print("Flipped Camera")
    }
    
    @IBAction
    func toggleFlash(_ tapGesture: UITapGestureRecognizer) {
        delegate?.toggleFlash()
        flashIcon.image = FlashMode.flashIcon
    }
    
    @IBAction
    func cameraButtonPressed(_ tapGesture: UITapGestureRecognizer) {
        delegate?.cameraButtonPressed()
    }
    
    @IBAction
    func tapped(_ tapGesture: UITapGestureRecognizer) {
        print("Tapped")
    }
}

extension CameraIconVIew: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateSearching(isStarting: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateSearching(isStarting: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.resignFirstResponder()
        return true
    }
}
