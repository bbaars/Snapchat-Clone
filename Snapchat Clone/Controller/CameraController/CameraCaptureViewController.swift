//
//  CameraCaptureViewController.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/11/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

class CameraCaptureViewController: UIViewController {
    
    // MARK: - Enums
    private enum Tags {
        static var text = 34
        static var draw = 39
        static var undo = 42
        static var time = 43
    }
    
    private enum Controls {
        case text, draw, time, none
    }
    
    // MARK: - UI Components
    lazy var imageCaptureView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = UserInterface.Elements.cornerRadius
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var closeButton: UIView = {
        let view = UIView.getIconView(withImage: UserInterface.Icons.close)
        view.layer.addShadow()
        view.tintColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
        return view
    }()
    
    private lazy var colorPickerView: UIView = {
        let colorPicker = ColorPickerView()
        colorPicker.delegate = self
        colorPicker.translatesAutoresizingMaskIntoConstraints = false
        colorPicker.isUserInteractionEnabled = true
        return colorPicker
    }()
    
    private lazy var componentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textButton, penButton, timerButton])
        stackView.alignment = .top
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 12
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var textButton: UIView = {
        let textButtonView = UIView.getIconView(withImage: UserInterface.Icons.text, width: 25)
        textButtonView.layer.addShadow()
        textButtonView.tintColor = .white
        textButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                   action: #selector(textButtonPressed)))
        return textButtonView
    }()
    
    private lazy var penButton: UIView = {
        let penButtonView = UIView.getIconView(withImage: UserInterface.Icons.pen, width: 25)
        penButtonView.layer.addShadow()
        penButtonView.tintColor = .white
        penButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                  action: #selector(penButtonPressed)))
        return penButtonView
    }()
    
    private lazy var timerButton: UIView = {
        let penButtonView = UIView.getIconView(withImage: UserInterface.Icons.stopWatch, width: 30)
        penButtonView.layer.addShadow()
        penButtonView.tintColor = .white
        penButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                  action: #selector(stopWatchPressed)))
        return penButtonView
    }()
    
    private lazy var undoButton: UIView = {
        let undoView = UIView.getIconView(withImage: UserInterface.Icons.undo)
        undoView.layer.addShadow()
        undoView.translatesAutoresizingMaskIntoConstraints = false
        undoView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                             action: #selector(undoButtonPressed)))
        return undoView
    }()
    
    private lazy var downloadButton: UIView = {
        let downloadView = UIView.getIconView(withImage: UserInterface.Icons.download, width: 25)
        downloadView.layer.addShadow()
        downloadView.translatesAutoresizingMaskIntoConstraints = false
        downloadView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                 action: #selector(downloadImagePressed)))
        return downloadView
    }()
    
    private lazy var addStoryButton: UIView = {
        let storyView = UIView.getIconView(withImage: UserInterface.Icons.addStory, width: 25)
        storyView.layer.addShadow()
        storyView.translatesAutoresizingMaskIntoConstraints = false
        storyView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                 action: #selector(addStoryButtonPressed)))
        return storyView
    }()
    
    private lazy var sendButton: UIView = {
        let sendView = UIView.getIconView(withImage: UserInterface.Icons.send, width: 25)
        sendView.backgroundColor = UserInterface.Colors.chatBlue
        sendView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendButtonPressed)))
        return sendView
    }()
    
    private lazy var dummyTextButton: UIView = {
        let textButtonView = UIView()
        textButtonView.layer.addShadow()
        return textButtonView
    }()
    
    // MARK : Variables
    
    private var currentControl: Controls = .none
    private var ghostChatTime: Int = 0

    // MARK: - View Controller Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        addConstraints()
        setupGestureRecognizers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // MARK: - Setup Methods
    private func setupView() {
        
        view.addSubview(imageCaptureView)
        
        imageCaptureView.addSubview(closeButton)
        imageCaptureView.addSubview(componentStackView)
        imageCaptureView.addSubview(dummyTextButton)
        imageCaptureView.addSubview(downloadButton)
        imageCaptureView.addSubview(addStoryButton)
        imageCaptureView.addSubview(sendButton)
    }
    
    private func addConstraints() {
        
        imageCaptureView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        imageCaptureView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        imageCaptureView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        imageCaptureView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        downloadButton.leftAnchor.constraint(equalTo: imageCaptureView.leftAnchor, constant: 16).isActive = true
        downloadButton.bottomAnchor.constraint(equalTo: imageCaptureView.bottomAnchor, constant: -16).isActive = true
        downloadButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        downloadButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        addStoryButton.leftAnchor.constraint(equalTo: downloadButton.rightAnchor, constant: 8).isActive = true
        addStoryButton.centerYAnchor.constraint(equalTo: downloadButton.centerYAnchor).isActive = true
        addStoryButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        addStoryButton.heightAnchor.constraint(equalToConstant: 44).isActive = true

        closeButton.topAnchor.constraint(equalTo: imageCaptureView.topAnchor, constant: 16).isActive = true
        closeButton.leftAnchor.constraint(equalTo: imageCaptureView.leftAnchor, constant: 16).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        textButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        textButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        penButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        penButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        timerButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        timerButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        componentStackView.topAnchor.constraint(equalTo: closeButton.topAnchor).isActive = true
        componentStackView.rightAnchor.constraint(equalTo: imageCaptureView.rightAnchor, constant: -12).isActive = true
        
        sendButton.centerYAnchor.constraint(equalTo: downloadButton.centerYAnchor).isActive = true
        sendButton.centerXAnchor.constraint(equalTo: componentStackView.centerXAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        sendButton.layer.cornerRadius = 25
    }
    
    private func setupGestureRecognizers() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(textViewAdded(_:))))
    }
    
    private func resetView() {
        
        currentControl = .none
        
        dummyTextButton.removeFromSuperview()
        colorPickerView.removeFromSuperview()
        
        textButton.tintColor = .white
        penButton.tintColor = .white
        timerButton.tintColor = .white
        (timerButton.subviews[0] as! UIImageView).tintColor = .white
        
        animateControls(views: textButton, penButton, timerButton, isHidden: false)
        
        if let drawingView = view.viewWithTag(Tags.draw) as? AddCustomDrawingView {
            imageCaptureView.sendSubviewToBack(drawingView)
            drawingView.canDraw = false
        }
        
        if let timerView = view.viewWithTag(Tags.time) as? StopWatchView {
            timerView.removeFromSuperview()
        }
        
        (closeButton.subviews[0] as! UIImageView).image = UserInterface.Icons.close
        
        if let undo = imageCaptureView.viewWithTag(Tags.undo) {
            
            UIView.animate(withDuration: 0.2, animations: {
                undo.alpha = 0
            }) { (isFinished) in
                if (isFinished) {
                    undo.removeFromSuperview()
                }
            }
        }
    }
    
    private func addColorPickerView(belowView view: UIView) {
        
        imageCaptureView.addSubview(colorPickerView)
        
        colorPickerView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.maxY + 16).isActive = true
        colorPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        colorPickerView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        colorPickerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func configureViewForText() {
        
        guard currentControl != .text else { resetView() ; return }
        guard currentControl == .none else { return }
        
        currentControl = .text

        animateControls(views: penButton, timerButton, isHidden: true)
        addDummyView(toFrame: textButton.frame)
        addColorPickerView(belowView: textButton)
        
        if let customTextView = view.viewWithTag(Tags.text) as? AddCustomTextView {
            customTextView.beginEditing()
        } else {
        
            let customText = AddCustomTextView()
            customText.tag = Tags.text
            customText.delegate = self
            customText.translatesAutoresizingMaskIntoConstraints = false
            
           addConstraintsToControlViews(view: customText)
        }
    }
    
    private func configureViewForPen() {
        
        guard currentControl != .draw else { resetView() ; return }
        guard currentControl == .none else { return }
        
        currentControl = .draw
        
        animateControls(views: textButton, timerButton, isHidden: true)
        addDummyView(toFrame: penButton.frame)
        addColorPickerView(belowView: penButton)
        
        if let drawingView = view.viewWithTag(Tags.draw) as? AddCustomDrawingView {
            drawingView.canDraw = true
    
            imageCaptureView.bringSubviewToFront(drawingView)
            imageCaptureView.bringSubviewToFront(closeButton)
            imageCaptureView.bringSubviewToFront(componentStackView)
            imageCaptureView.bringSubviewToFront(colorPickerView)
            
            drawingView.didMoveToSuperview()
            
        } else {

            let drawingView = AddCustomDrawingView()
            drawingView.delegate = self
            drawingView.tag = Tags.draw
            drawingView.translatesAutoresizingMaskIntoConstraints = false
            drawingView.isUserInteractionEnabled = true
            
            addConstraintsToControlViews(view: drawingView)
        }
    }
    
    private func configureViewForTime() {
        
        guard currentControl != .time else { resetView() ; return }
        guard currentControl == .none else { return }
        
        currentControl = .time
        
        animateControls(views: textButton, penButton, isHidden: true)
        addDummyView(toFrame: timerButton.frame)
        
        let picker = StopWatchView()
        picker.delegate = self
        picker.reinitView(withStartingTime: ghostChatTime)
        picker.tag = Tags.time
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.isUserInteractionEnabled = true
        
        addConstraintsToControlViews(view: picker)
    }
    
    private func addDummyView(toFrame frame: CGRect) {
        
        updateCloseButton()
        
        componentStackView.insertSubview(dummyTextButton, at: 0)
        dummyTextButton.frame = frame
        dummyTextButton.backgroundColor = .white
        dummyTextButton.layer.cornerRadius = dummyTextButton.frame.width / 2
        
        textButton.tintColor = UIColor.black.withAlphaComponent(0.4)
        penButton.tintColor = UIColor.black.withAlphaComponent(0.4)
        timerButton.tintColor = UIColor.black.withAlphaComponent(0.4)
        
        dummyTextButton.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.dummyTextButton.transform = .identity
        }, completion: nil)
    }
    
    private func addConstraintsToControlViews(view: UIView) {
        
        imageCaptureView.insertSubview(view, belowSubview: closeButton)
        
        view.leftAnchor.constraint(equalTo: imageCaptureView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: imageCaptureView.rightAnchor).isActive = true
        view.topAnchor.constraint(equalTo: imageCaptureView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: imageCaptureView.bottomAnchor).isActive = true
    }
    
    private func animateControls(views: UIView..., isHidden: Bool) {
        for arg in views {
            arg.isHidden = isHidden
        }
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                        
                        self.view.layoutIfNeeded()
        })
    }
    
    private func updateCloseButton() {
        (closeButton.subviews[0] as! UIImageView).image = UserInterface.Icons.back
    }
    
    // MARK: - Objc Methods
    @objc
    private func textViewAdded(_ sender: UITapGestureRecognizer) {
        configureViewForText()
    }
    
    @objc
    private func dismissView() {
        
        if currentControl != .none {
            resetView()
        } else {
            dismiss(animated: false, completion: nil)
        }
        
    }
    
    @objc
    private func textButtonPressed() {
        configureViewForText()
    }
    
    @objc
    private func penButtonPressed() {
        configureViewForPen()
    }
    
    @objc
    private func undoButtonPressed() {
        if let drawing = imageCaptureView.viewWithTag(Tags.draw) as? AddCustomDrawingView, currentControl == .draw {
            drawing.undo()
        }
    }
    
    @objc
    private func stopWatchPressed() {
        configureViewForTime()
    }
    
    @objc
    private func sendButtonPressed() {
        let friendsVC = FriendsViewController()
        friendsVC.modalPresentationStyle = .overCurrentContext
        view.window?.layer.addRightToLeftTransition()
        present(friendsVC, animated: false)
    }
    
    @objc
    private func addStoryButtonPressed() {
        
    }
    
    @objc
    private func downloadImagePressed() {
        
        UIGraphicsBeginImageContextWithOptions(imageCaptureView.frame.size, view.isOpaque, .zero)
        
        if let context = UIGraphicsGetCurrentContext() {
            imageCaptureView.image?.draw(in: self.view.frame)
            
            if let drawing = imageCaptureView.viewWithTag(Tags.draw) {
                drawing.layer.render(in: context)
            }
            
            if let text = imageCaptureView.viewWithTag(Tags.text) {
                text.layer.render(in: context)
            }
            
            // individually render layers as part of the context image.
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            }
        }
        
        UIGraphicsEndImageContext()
    }
    
    @objc
    private func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        if let error = error {
            let alert = UIAlertController(title: "Saving Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Saved!", message: "Your image was successfully saved to your photos album.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            present(alert, animated: true)
        }
    }
}

extension CameraCaptureViewController: StopWatchViewDelegate {

    func didSelect(time: Int) {
        var images = [#imageLiteral(resourceName: "stop-watch-hand1"), #imageLiteral(resourceName: "stop-watch-hand2"), #imageLiteral(resourceName: "stop-watch-hand3"), #imageLiteral(resourceName: "stop-watch-hand4"), #imageLiteral(resourceName: "stop-watch-hand5"), #imageLiteral(resourceName: "stop-watch-hand6"), #imageLiteral(resourceName: "stop-watch-hand7"), #imageLiteral(resourceName: "stop-watch-hand8"), #imageLiteral(resourceName: "stop-watch-hand9"), #imageLiteral(resourceName: "stop-watch-hand10")]
        images = images.map{ $0.withRenderingMode(.alwaysTemplate) }
        
        (timerButton.subviews[0] as! UIImageView).image = images[time]
        (timerButton.subviews[0] as! UIImageView).tintColor = UIColor.black.withAlphaComponent(0.4)
        
        ghostChatTime = time
    }
}

extension CameraCaptureViewController: AddCustomTextViewDelegate {
    
    func didEndEditing() {
        resetView()
    }
    
    func didBeginEditing() {
        addDummyView(toFrame: textButton.frame)
        addColorPickerView(belowView: textButton)
    }
}

extension CameraCaptureViewController: ColorPickerViewDelegate {
    
    func didChooseColor(_ color: UIColor?) {
        if let customText = view.viewWithTag(Tags.text) as? AddCustomTextView, currentControl == .text {
            customText.changeText(to: color)
        } else if let drawing = view.viewWithTag(Tags.draw) as? AddCustomDrawingView, currentControl == .draw {
            drawing.currentColor = color ?? .white
        }
    }
}

extension CameraCaptureViewController : AddCustomDrawingViewDelegate {
    
    func doesHaveDrawings() {
        
        guard imageCaptureView.viewWithTag(Tags.undo) == nil else { return }
        
        imageCaptureView.addSubview(undoButton)
        
        undoButton.alpha = 0
        undoButton.tag = Tags.undo
        undoButton.topAnchor.constraint(equalTo: componentStackView.topAnchor).isActive = true
        undoButton.rightAnchor.constraint(equalTo: componentStackView.leftAnchor, constant: -24).isActive = true
        undoButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        undoButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        UIView.animate(withDuration: 0.3) {
            self.undoButton.alpha = 1.0
        }
    }
    
    func doesNotHaveDrawings() {
        
        if let undo = imageCaptureView.viewWithTag(Tags.undo) {
            
            UIView.animate(withDuration: 0.2, animations: {
                undo.alpha = 0
            }) { (isFinished) in
                if (isFinished) {
                    undo.removeFromSuperview()
                }
            }
        }
    }
}
