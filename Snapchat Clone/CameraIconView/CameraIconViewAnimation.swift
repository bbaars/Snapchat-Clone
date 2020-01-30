//
//  CameraIconViewAnimation.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/9/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

extension CameraIconVIew {
    
    func animateIconsDown(with percent: CGFloat) {
        
        let finalConstraintContant: CGFloat = 20
        
        let cameraButtonDeltaDistance = cameraButtonBottomConstraint.constant - finalConstraintContant
        let chatButtonDeltaDistance = chatIconBottomConstraint.constant - finalConstraintContant
        
        // distance each icon is currently from the finalConstraintConstant (delta Y)
        // 38 - 20 = 18
        // 38 - ([1] * 18)
        let cameraButtonDeltaY = cameraButtonBottomConstraintConstant - (percent * cameraButtonDeltaDistance)
        
        let chatButtonDeltaY = chatButtonBottomConstraintConstant - (percent * chatButtonDeltaDistance)
        
        chatIconBottomConstraint.constant = chatButtonDeltaY
        cameraButtonBottomConstraint.constant = cameraButtonDeltaY
    }
    
    func animateIconsHorizontalPosition(with percent: CGFloat) {
        
        //1:5 ratio is 20% multiplyer
        //        print(chatIconHorizontalConstraint.multiplier)
        
        // gets us the distance from the 'left/right' edge of the screen based on the multipler for the half the width of the screen in terms of pixels
        let startingOffset = chatIconHorizontalConstraint.multiplier * (bounds.width * 0.5)
        
        // tells us how far we need to travel 55%, or 1/4 from the left edge of the screen to our new offset.
        let newOffset = (bounds.width * 0.5 * 0.55) - startingOffset
        
        chatIconHorizontalConstraint.constant = newOffset * percent
        discoverIconHorizontalConstraint.constant = -newOffset * percent
    }
    
    func animateCameraActionIcons(with percent: CGFloat) {
        
        let finalConstraintConstant: CGFloat = -30
        
        let flipCameraDeltaX = flipCameraRightConstraint.constant - finalConstraintConstant
        
        flipCameraRightConstraint.constant = flipCameraConstraintConstant - (flipCameraDeltaX * percent)
        flipCameraContainerView.alpha = 1 - percent
        flashContainerView.alpha = 1 - percent
    }
    
    func animateColorView(with percent: CGFloat, to controller: UIViewController?) {
        
        guard let controller = controller as? ColorView else { return }
        
        // 0 -> 1
        let min: CGFloat = 0.15
        let max: CGFloat = 0.85
        
        // 0 is at 15% and 1 is at 85%.
        let newPercent = (percent - min) / (max - min)
        
        colorView.backgroundColor = controller.controllerBackgroundColor
        colorView.alpha = newPercent
    }
    
    func animateIconScale(with percent: CGFloat) {
        
        let finalIconWidth = cameraButtonWidthConstraintConstant * 0.20
        cameraButtonWidthConstraint.constant = cameraButtonWidthConstraintConstant - (percent * finalIconWidth)
        
        let finalChatWidth = chatButtonWidthConstraintConstant * 0.10
        chatIconWidthConstraint.constant = chatButtonWidthConstraintConstant - (percent * finalChatWidth)
        
        let finalIndicatorWidth = indicatorWidthConstraintConstant * 0.8
        indicatorWidthConstraint.constant = indicatorWidthConstraintConstant + (percent * finalIndicatorWidth)
        
        indicatorView.layer.cornerRadius = indicatorWidthConstraint.constant / 2
    }
    
    func animateIndicatorView(with offset: CGFloat) {
        
        // should give us the 45% from the center to the left
        let finalOffset = (bounds.width * 0.5) - (bounds.width * 0.5 * 0.55)
        
        indicatorViewHorizontalConstraint.constant = indicatorViewHorizontalConstraintConstant - (finalOffset * offset)
    }
    
    func animateIndicatorViewAlpha(with percent: CGFloat) {
        indicatorView.alpha = percent
    }
    
    func animateSearchBarText(with percent: CGFloat, to controller: UIViewController?) {
        
        // normalize our percent between 0 -> 50% animate out the current text 50% -> 100% Animate in the new text
        let begFadeOut: CGFloat = 0.45
        let endFadeOut: CGFloat = 1.0
        
        let begFadeOutNorm = (percent - 0) / (begFadeOut - 0)
        let endFadeOutNorm = (percent - 0.55) / (endFadeOut - 0.55)
        
        if (percent <= begFadeOut) {
            searchBar.alpha = 1 - begFadeOutNorm
        } else {
            searchBar.alpha = endFadeOutNorm
        }
        
        if let controller = controller as? SearchBarText {
            searchBar.attributedPlaceholder = NSAttributedString(string: controller.searchBarText,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
    }
    
    func animateSearching(isStarting: Bool) {
        
        // animate out the avatar icon, add-user icon, flip-camera, flash-icon
        avatarIcon.isHidden = isStarting
        flipCameraIcon.isHidden = isStarting
        flashIcon.isHidden = isStarting
        addUserIcon.isHidden = isStarting
        
        UIView.animate(withDuration: 0.35,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                        
                        self.layoutIfNeeded()
        }, completion: nil)
        
        if (isStarting) {
            
            let x = UIImageView(image: UserInterface.Icons.close)
            x.contentMode = .scaleAspectFit
            x.tag = 29
            x.isUserInteractionEnabled = true
            x.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(textFieldShouldReturn(_:))))
            x.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(x)
            
            x.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor).isActive = true
            x.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
            x.widthAnchor.constraint(equalToConstant: 22).isActive = true
            x.heightAnchor.constraint(equalToConstant: 22).isActive = true
            
        } else if let close = self.viewWithTag(29) {
            close.removeFromSuperview()
        }
    }
    
    @objc
    func dismissView() {
        print("Dismissing")
        searchBar.resignFirstResponder()
    }
}
