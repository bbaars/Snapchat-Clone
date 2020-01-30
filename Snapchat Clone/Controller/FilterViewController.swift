//
//  FilterViewController.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 2/23/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, SearchBarText {

    var searchBarText: String {
        return UserInterface.SearchBarText.filter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
