//
//  UserInterface.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/3/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

struct UserInterface {
    struct Elements {
        static let cornerRadius: CGFloat = 25
    }
    
    struct Colors {
        static let chatBlue = UIColor(red: 0.23, green: 0.66, blue: 0.96, alpha: 1.0)
        static let discoverPurple = UIColor(red: 0.59, green: 0.23, blue: 0.96, alpha: 1.0)
        static let snapYellow = UIColor(red: 1.0, green: 0.98, blue: 0, alpha: 1.0)
        static let memoriesRed = UIColor(red: 0.97, green: 0.12, blue: 0.29, alpha: 1.0)
        
        static let color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    struct Fonts {
        static let avenirNext = "Avenir Next"
        static let avenirNextDemiBold = "AvenirNext-DemiBold"
        static let avenirNextMedium = "AvenirNext-Medium"
    }
    
    struct SearchBarText {
        static let chat = "Friends"
        static let filter = "Search"
        static let discover = "Discover"
    }
    
    enum Icons {
        
        // computed property -> Calculate it at the time of the call.
        static var close: UIImage {
            return UIImage(named: "close")!
        }
        
        static var flash: UIImage {
            return UIImage(named: "flash")!
        }
        
        static var noFlash: UIImage {
            return UIImage(named: "flash-off")!
        }
        
        static var text: UIImage {
            return UIImage(named: "text")!.withRenderingMode(.alwaysTemplate)
        }
        
        static var pen: UIImage {
            return UIImage(named: "pen")!.withRenderingMode(.alwaysTemplate)
        }
        
        static var back: UIImage {
            return UIImage(named: "back")!
        }
        
        static var undo: UIImage {
            return UIImage(named: "undo")!
        }
        
        static var stopWatch: UIImage {
            return UIImage(named: "stop-watch-hand")!.withRenderingMode(.alwaysTemplate)
        }
        
        static var download: UIImage {
            return UIImage(named: "download")!
        }
        
        static var send: UIImage {
            return UIImage(named: "send-button")!
        }
        
        static var addStory: UIImage {
            return UIImage(named: "add-story")!
        }
        
        static var search: UIImage {
            return UIImage(named: "search")!
        }
    }
}
