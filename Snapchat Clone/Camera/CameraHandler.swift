//
//  CameraHandler.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/9/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import AVFoundation
import Foundation
import UIKit

protocol CameraHandlerDelegate: AnyObject {
    func didTakePhoto(with image: UIImage)
}

class CameraHandler: NSObject {
    private enum CameraPosition {
        case front, back
    }
    
    enum CameraHandlerError: Error {
        case captureSessionAlreadyRunning
        case captureSessionIsMissing
        case inputsAreInvalid
        case noCamerasAvailable
        case unknown
    }
    
    // MARK: - Private Variables
    private var currentCameraPosition: CameraPosition = .back
    
    private var captureSession: AVCaptureSession?
    private var frontFacingCamera: AVCaptureDevice?
    private var backFacingCamera: AVCaptureDevice?
    private var photoOutput: AVCapturePhotoOutput?
    
    
    // MARK: - Public Variables
    public var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    public weak var delegate: CameraHandlerDelegate?
    
    // starting/setting up the camera is a very intensive process. Do not put it in init code.
    func setup(completion: @escaping (_ error: Error?) -> ()) {
        
        // 1. Creating a capture session
        // 2. Obtaining capture devices
        // 3. Creating inputs with the capture devices
        // 4. Configuring photo output
        
        func createCaptureSession() {
            self.captureSession = AVCaptureSession()
            self.captureSession?.sessionPreset = AVCaptureSession.Preset.photo
        }
        
        func configureCaptureDevices() throws {
            frontFacingCamera = getDevice(for: .front)
            backFacingCamera = getDevice(for: .back)
            
            try frontFacingCamera?.lockForConfiguration()
            frontFacingCamera?.ramp(toVideoZoomFactor: 2.0, withRate: 1.0)
            frontFacingCamera?.unlockForConfiguration()
        }
        
        func configureDevicesInputs() throws {
            do {
                if let backCamera = backFacingCamera, let input = try getInput(for: backCamera) {
                    captureSession?.addInput(input)
                }
                
                else if let frontCamera = frontFacingCamera, let input = try getInput(for: frontCamera) {
                    captureSession?.addInput(input)
                }
            } catch let error {
                print(error)
                throw CameraHandlerError.noCamerasAvailable
            }
        }
        
        func configurePhotoOutput() throws {
            guard let captureSession = self.captureSession else { throw CameraHandlerError.captureSessionIsMissing }
            
            self.photoOutput = AVCapturePhotoOutput()
            if let output = photoOutput, captureSession.canAddOutput(output) {
                captureSession.addOutput(output)
            }
            
            captureSession.startRunning()
        }
        
        DispatchQueue.init(label: "CameraSetup").async {
            do {
                self.captureSession?.beginConfiguration()
                createCaptureSession()
                try configureCaptureDevices()
                try configureDevicesInputs()
                try configurePhotoOutput()
                self.captureSession?.commitConfiguration()
                
                completion(nil)
                
            } catch let error {
                print(error)
                completion(error)
            }
        }
    }
    
    public func showPreview(on view: UIView) throws {
        guard let captureSession = self.captureSession else { throw CameraHandlerError.captureSessionIsMissing }

        self.cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.cameraPreviewLayer?.connection?.videoOrientation = .portrait
        
        if let previewLayer = cameraPreviewLayer {
            view.layer.insertSublayer(previewLayer, at: 0)
            self.cameraPreviewLayer?.frame = view.frame
        }
    }
    
    public func flipCamera() throws {
        guard let captureSession = self.captureSession, captureSession.isRunning else { throw CameraHandlerError.captureSessionIsMissing }
        
        captureSession.beginConfiguration()

        for input in captureSession.inputs {
            captureSession.removeInput(input)
        }
    
        if currentCameraPosition == .back {
            
            if let frontCamera = frontFacingCamera, let input = try getInput(for: frontCamera) {
                captureSession.addInput(input)
            }
            
            currentCameraPosition = .front
            
        } else if currentCameraPosition == .front {
            if let backCamera = backFacingCamera, let input = try getInput(for: backCamera) {
                captureSession.addInput(input)
            }

            currentCameraPosition = .back
        }
        
        captureSession.commitConfiguration()
    }
    
    public func toggleFlash() {
        FlashMode.toggleFlash()
    }
    
    public func takePhoto() {
        let imageSettings = AVCapturePhotoSettings()
        
        if let photoOutput = photoOutput, photoOutput.supportedFlashModes.contains(FlashMode.flashMode) {
            imageSettings.flashMode = FlashMode.flashMode
        } else {
            imageSettings.flashMode = .off
        }
        
        photoOutput?.capturePhoto(with: imageSettings, delegate: self)
    }
    
    private func getDevice(for position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        return AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: position)
    }
    
    private func getInput(for deviceInput: AVCaptureDevice) throws -> AVCaptureDeviceInput? {
        guard let captureSession = self.captureSession else { throw CameraHandlerError.captureSessionIsMissing }
        
        let cameraInput = try AVCaptureDeviceInput(device: deviceInput)
        if captureSession.canAddInput(cameraInput) {
            return cameraInput
        }
        
        return nil
    }
}

extension CameraHandler: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            return print(error)
        }
        
        // grab the image data from the file data representation
        if let imageData = photo.fileDataRepresentation(), let image = UIImage(data: imageData) {
            delegate?.didTakePhoto(with: image)
        }
    }
}
