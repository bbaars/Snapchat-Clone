//
//  ChatViewController.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 2/23/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, ColorView, SearchBarText {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    var controllerBackgroundColor: UIColor {
        return UserInterface.Colors.chatBlue
    }
    
    var searchBarText: String {
        return UserInterface.SearchBarText.chat
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableViewTopConstraint.constant = 100
        tableView.layer.cornerRadius = UserInterface.Elements.cornerRadius
    }
}

extension ChatViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: StoryboardStrings.TableViewCells.chat.rawValue, for: indexPath) as? ChatTableViewCell {
            
            
            return cell
        }
        
        return UITableViewCell()
    }
}
