//
//  AddCustomDrawingView.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/18/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

protocol AddCustomDrawingViewDelegate {
    func doesHaveDrawings()
    func doesNotHaveDrawings()
}

class AddCustomDrawingView: UIView {
    
    public var currentColor = UIColor.white
    public var canDraw: Bool = true
    
    private var lastTouchedPoint = CGPoint.zero
    private var brushWidth: CGFloat = 6
    private var swiped = false
    
    private var allDrawingPathImages = [UIImage]()
    
    public var delegate: AddCustomDrawingViewDelegate?
    
    public var getFinalImage: UIImage? {
        return allDrawingPathImages.last
    }
    
    private lazy var drawingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.shouldRasterize = true
        imageView.layer.rasterizationScale = UIScreen.main.scale
        imageView.layer.contentsScale = UIScreen.main.scale
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        
        addSubview(drawingImage)
        
        drawingImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        drawingImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        drawingImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        drawingImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if (!allDrawingPathImages.isEmpty) {
            delegate?.doesHaveDrawings()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        swiped = false
        lastTouchedPoint = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        swiped = true
        
        let currentPoint = touch.location(in: self)
        
        drawLine(from: lastTouchedPoint, to: currentPoint)
        
        lastTouchedPoint = currentPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !swiped {
            drawLine(from: lastTouchedPoint, to: lastTouchedPoint)
        }
        
        UIGraphicsBeginImageContext(drawingImage.frame.size)
        drawingImage.image?.draw(in: self.frame, blendMode: .normal, alpha: 1.0)
        let nextSavedImage = UIGraphicsGetImageFromCurrentImageContext()
        allDrawingPathImages.append(nextSavedImage!)
        drawingImage.image = nextSavedImage
        UIGraphicsEndImageContext()
        
        delegate?.doesHaveDrawings()
    }
    
    private func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        
        guard canDraw else { return }
        
        UIGraphicsBeginImageContext(self.frame.size)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        drawingImage.image?.draw(in: self.frame)
        
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(brushWidth)
        context.setStrokeColor(currentColor.cgColor)
        
        context.strokePath()
        
        drawingImage.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }
    
    public func undo() {
        
        if (allDrawingPathImages.isEmpty) { delegate?.doesNotHaveDrawings() ; return }
        
        allDrawingPathImages.removeLast()
        drawingImage.image = allDrawingPathImages.last
        
        if (allDrawingPathImages.isEmpty) {
            delegate?.doesNotHaveDrawings()
        }
    }
}
