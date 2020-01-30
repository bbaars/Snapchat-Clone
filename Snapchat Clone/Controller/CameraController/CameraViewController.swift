//
//  CameraViewController.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 2/23/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBOutlet weak var capturePreviewView: UIView!
    
    private var cameraHandler: CameraHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cameraHandler = CameraHandler()
        cameraHandler.delegate = self
        cameraHandler.setup { (error) in
            if let error = error {
                print(error)
            }
            
            DispatchQueue.main.async {
                try? self.cameraHandler.showPreview(on: self.capturePreviewView)
            }
        }
    }
    
    public func flipCamera() {
        do {
            try cameraHandler.flipCamera()
        } catch let error {
            print(error)
        }
        
        print("FLIPPED")
    }
    
    public func toggleFlash() {
        cameraHandler.toggleFlash()
    }
    
    public func takePhoto() {
        cameraHandler.takePhoto()
    }
}

extension CameraViewController: CameraHandlerDelegate {
    func didTakePhoto(with image: UIImage) {
        let cameraCapture = CameraCaptureViewController()
        cameraCapture.imageCaptureView.image = image
        cameraCapture.modalPresentationStyle = .fullScreen
        
        self.present(cameraCapture, animated: false, completion: nil)
    }
}
