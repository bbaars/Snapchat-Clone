//
//  FlashMode.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/10/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit
import AVFoundation

struct FlashMode {
        
    /// The current state of the cameras flash
    static var flashMode: AVCaptureDevice.FlashMode = .off
    
    static func toggleFlash() {
        flashMode = flashMode == .off ? .on : .off
    }
    
    /// The icon describing the state of the flash
    static var flashIcon: UIImage {
        return flashMode == .off ? UserInterface.Icons.noFlash : UserInterface.Icons.flash
    }
}
