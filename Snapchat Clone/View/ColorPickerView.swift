//
//  ColorPickerView.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/15/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

protocol ColorPickerViewDelegate {
    func didChooseColor(_ color: UIColor?)
}

class ColorPickerView: UIView {

    override public class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
    
    private lazy var currentColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 3.0
        view.layer.borderColor = UIColor.white.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var colorView: UIView = {
        let view = UIView()
        view.addSubview(currentColorView)
        
        currentColorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        currentColorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        currentColorView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        currentColorView.heightAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        currentColorView.layer.cornerRadius = self.frame.width / 2
        
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(colorWasDragged(_:))))
        
        return view
    }()
    
    private lazy var transforms: CGAffineTransform = {
        var allTransforms = CGAffineTransform.identity
        allTransforms = allTransforms.translatedBy(x: -50, y: 0)
        allTransforms = allTransforms.scaledBy(x: 3.0, y: 3.0)
        
        return allTransforms
    }()
    
    private var notAnimated = false
    private var didLayoutSubviews = false
    private var currentColorPosition: CGFloat?
    
    lazy var colorPickerHeight: CGFloat = {
        return self.frame.height
    }()
    
    public var delegate: ColorPickerViewDelegate?
    
    init() {
        super.init(frame: .zero)

        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let begHeight = self.frame.height
        
        self.frame.size.height = 0
        self.layer.cornerRadius = self.frame.size.width / 2
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.frame.size.height = begHeight
        }, completion: nil)
        
        self.insertSubview(colorView, at: 1)
        
        colorView.centerYAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        colorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        colorView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        colorView.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true
        
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        
        let values = (0...360).map { $0 }
        var colors: [CGColor] = values.map {
            return UIColor(hue: CGFloat(Float($0) / 360.0), saturation: 1.0, brightness: 1.0, alpha: 1.0).cgColor
        }
        
        colors.insert(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor, at: 0)
        colors.append(UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor)
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        if let pos = currentColorPosition {
            colorView.center.y = pos
        }
    }
    
    @objc
    private func colorWasDragged(_ panGesture: UIPanGestureRecognizer) {
        
        let translation = panGesture.translation(in: self)
        
        if let view = panGesture.view {
            var newY = view.center.y + translation.y
            newY = max(0, min(newY, colorPickerHeight))
            
            view.center = CGPoint(x: view.center.x,
                                  y: newY)
            
            currentColorPosition = view.center.y
            
            let hue = newY / colorPickerHeight
            
            if (hue == 0) {
                currentColorView.backgroundColor = .white
            } else if (hue == 1) {
                currentColorView.backgroundColor = .black
            } else {
                currentColorView.backgroundColor = UIColor(hue: hue,
                                                           saturation: 1.0,
                                                           brightness: 1.0,
                                                           alpha: 1.0)
            }
            
            delegate?.didChooseColor(currentColorView.backgroundColor)
            
            if (panGesture.state == UIGestureRecognizer.State.began && !notAnimated) {
                
                UIView.animate(withDuration: 0.25,
                               delay: 0,
                               usingSpringWithDamping: 0.6,
                               initialSpringVelocity: 0,
                               options: [],
                               animations: {
                                
                                self.colorView.transform = self.transforms
                                self.currentColorView.layer.borderWidth = 1.5
                }) { (didFinish) in
                    if (didFinish) {
                        self.notAnimated = true
                    }
                }
            }
            
            if (panGesture.state == UIGestureRecognizer.State.ended) {
                
                UIView.animate(withDuration: 0.25,
                               delay: 0,
                               usingSpringWithDamping: 0.6,
                               initialSpringVelocity: 0,
                               options: [],
                               animations: {
                    
                    self.colorView.transform = .identity
                    self.currentColorView.layer.borderWidth = 3.0
                    
                }) { (didFinish) in
                    if (didFinish) {
                        self.notAnimated = false
                    }
                }
            }
        }
        
        panGesture.setTranslation(.zero, in: self)
    }
}
