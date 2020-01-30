//
//  AddCustomTextView.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/13/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

protocol AddCustomTextViewDelegate {
    func didEndEditing()
    func didBeginEditing()
}

class AddCustomTextView: UIView {
    
    private lazy var textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        tf.font = UIFont(name: UserInterface.Fonts.avenirNext, size: 16)
        tf.textAlignment = .left
        tf.textColor = .white
        tf.returnKeyType = .done
        tf.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(textFieldDidPan(_:))))
        tf.isUserInteractionEnabled = true
        
        return tf
    }()
    
    private var currentYPosition: CGFloat = 0.0
    private var animationDuration: TimeInterval = 0.28
    
    public var delegate: AddCustomTextViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textField)
        textField.delegate = self
        textField.returnKeyType = .done
        
        setupView()
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(textFieldDidEnd)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        textField.becomeFirstResponder()
        
        animateInView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        currentYPosition = self.frame.midY
    }
    
    private func setupView() {
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["v0": textField]))
        
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func animateInView() {
        
        textField.transform = CGAffineTransform(translationX: 0, y: 300)
        UIView.animate(withDuration: animationDuration) {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self.textField.transform = .identity
        }
    }
    
    // MARK - Objc
    @objc
    func textFieldDidPan(_ panGesture: UIPanGestureRecognizer) {
        
        let translation = panGesture.translation(in: self.superview)
        if let view = panGesture.view {
            let newPosition = CGPoint(x: view.center.x,
                                      y: view.center.y + translation.y)
            view.center = newPosition
            currentYPosition = newPosition.y
        }
        
        // The gesture will compound each time, so we set it back to zero
        panGesture.setTranslation(CGPoint.zero, in: self.superview)
    }
    
    @objc
    func textFieldDidEnd() {
        resetView()
    }
    
    private func resetView() {
        
        UIView.animate(withDuration: animationDuration) {
            self.textField.frame.origin.y = self.currentYPosition
        }
        
        textField.resignFirstResponder()
        textField.textAlignment = .center
        backgroundColor = .clear
        if (textField.text == "") {
            self.removeFromSuperview()
        }
        
        delegate?.didEndEditing()
    }
    
    public func changeText(to color: UIColor?) {
        textField.textColor = color
    }
    
    public func beginEditing() {
        textField.becomeFirstResponder()
    }
}

extension AddCustomTextView : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if (textField.text == "") {
            self.removeFromSuperview()
        }
        
        textField.textAlignment = .center
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        delegate?.didBeginEditing()
        
        UIView.animate(withDuration: animationDuration) {
            textField.frame.origin.y = self.frame.midY
            self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        }
        
        textField.textAlignment = .left
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        resetView()
        
        return true
    }
}
