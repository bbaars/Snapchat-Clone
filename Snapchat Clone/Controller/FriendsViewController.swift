//
//  FriendsViewController.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/27/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

//class FriendsDataSource: TableArrayDataSource<FriendViewModel, FriendTableViewCell> { }

class FriendsViewController: UIViewController {
    
    // MARK: - Variables
    private let sectionHeaders: [String] = ["STORIES", "BEST FRIENDS", "RECENTS", "GROUPS", "ALL FRIENDS"]
    private let sectionHeaderHeight: CGFloat = 35.0
    
    private var currentlySelectedFriends = [IndexPath]()
    
//    private var friendDataSource: FriendsDataSource?
    private var selectedIndexPath: IndexPath? = nil
    
    private var initialTouchPoint: CGPoint = .zero
    
    private lazy var viewModels: [[FriendViewModel]] = {
        let sectionArray = Array.init(repeating: FriendViewModel(name: "Brandon Baars", avatarImage: #imageLiteral(resourceName: "avatar15")), count: sectionHeaders.count)
        let viewModels = Array.init(repeating: sectionArray, count: 5)
        return viewModels
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.register(FriendTableViewCell.self, forCellReuseIdentifier: String(describing: FriendTableViewCell.self))
        return tv
    }()
    
    private lazy var backButton: UIView = {
        let backView = UIView.getIconView(withImage: UserInterface.Icons.back)
        backView.tintColor = .white
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backButtonPressed)))
        return backView
    }()
    
    private lazy var searchIcon: UIView = {
        let searchView = UIView.getIconView(withImage: UserInterface.Icons.search)
        return searchView
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.font = UIFont(name: UserInterface.Fonts.avenirNextDemiBold, size: 21.0)
        textField.attributedPlaceholder = NSAttributedString(string: "Search",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.view.backgroundColor = .darkText
        
        view.addSubview(tableView)
        view.addSubview(backButton)
        view.addSubview(searchIcon)
        view.addSubview(searchTextField)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0).isActive = true
        
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        backButton.leftAnchor.constraint(equalTo: tableView.leftAnchor).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        searchIcon.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        searchIcon.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 8).isActive = true
        searchIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        searchIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        searchTextField.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        searchTextField.leftAnchor.constraint(equalTo: searchIcon.rightAnchor, constant: 8).isActive = true
        searchTextField.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        
//        friendDataSource = setupDataSource()
    }
    
//    private func setupDataSource() -> FriendsDataSource {
//        let sectionArray = Array.init(repeating: FriendViewModel(name: "Brandon Baars", avatarImage: #imageLiteral(resourceName: "avatar15")), count: sectionHeaders.count)
//        let viewModels = Array.init(repeating: sectionArray, count: 5)
//
//        let headerViews = (0..<sectionHeaders.count).map { sectionOfHeader -> UIView in
//            let headerView = UIView(frame: CGRect(x: 8, y: 0, width: self.tableView.bounds.width, height: self.sectionHeaderHeight))
//            headerView.backgroundColor = .clear
//
//            let headerLabel = UILabel(frame: CGRect(x: 8, y: 10, width: 200, height: 20))
//            headerLabel.font = UIFont(name: UserInterface.Fonts.avenirNextDemiBold, size: 13)
//            headerLabel.text = sectionHeaders[sectionOfHeader]
//            headerLabel.textColor = .white
//
//            headerView.addSubview(headerLabel)
//
//            return headerView
//        }
//
//        let dataSource = FriendsDataSource(tableView: tableView, array: viewModels, cellHeight: 50, sectionHeaderViews: headerViews)
//
//        dataSource.selectionHandler = { [weak self] indexPath in
//
//            if let cell = self?.tableView.cellForRow(at: indexPath) as? FriendTableViewCell {
//                if let _ = self?.currentlySelectedFriends.firstIndex(of: indexPath) {
//                    cell.setCellToSelected(isShowing: false)
//                    self?.currentlySelectedFriends.removeAll { (indexpath) -> Bool in
//                        indexPath == indexpath
//                    }
//                    self?.manage(cell: cell, forIndexPath: indexPath, isSelected: false)
//                } else {
//                    cell.setCellToSelected(isShowing: true)
//                    self?.currentlySelectedFriends.append(indexPath)
//                    self?.manage(cell: cell, forIndexPath: indexPath, isSelected: true)
//                }
//            }
//        }
//
//        return dataSource
//    }

    @objc
    private func backButtonPressed() {
        self.view.window?.layer.addLeftToRightTransition()
        self.dismiss(animated: false, completion: nil)
    }
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: FriendTableViewCell.self)) as? FriendTableViewCell {
            cell.configureCell(with: viewModels[indexPath.section][indexPath.row], at: indexPath)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FriendTableViewCell {
            if let _ = currentlySelectedFriends.firstIndex(of: indexPath) {
                cell.setCellToSelected(isShowing: false)
                currentlySelectedFriends.removeAll { (indexpath) -> Bool in
                    indexPath == indexpath
                }
                manage(cell: cell, forIndexPath: indexPath, isSelected: false)
            } else {
                cell.setCellToSelected(isShowing: true)
                currentlySelectedFriends.append(indexPath)
                manage(cell: cell, forIndexPath: indexPath, isSelected: true)
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 8, y: 0, width: tableView.bounds.width, height: sectionHeaderHeight))
        headerView.backgroundColor = .clear

        let headerLabel = GenericLabel(frame: CGRect(x: 8, y: 15, width: tableView.bounds.width, height: 20), font: UserInterface.Fonts.avenirNextDemiBold, fontSize: 13)
        headerLabel.translatesAutoresizingMaskIntoConstraints = true
        headerLabel.text = sectionHeaders[section]
        headerLabel.textColor = .white

        headerView.addSubview(headerLabel)

        return headerView
    }
}

extension FriendsViewController {
    private func round(cellsCornersFor cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
        var path = UIBezierPath()
        let maskLayer = CAShapeLayer()
        
        if (indexPath.row == 0) {
            path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 7, height: 7))
        } else if indexPath.row == viewModels[indexPath.section].count - 1 {
            path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 7, height: 7))
        } else {
            path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [], cornerRadii: CGSize(width: 7, height: 7))
        }
        
        maskLayer.path = path.cgPath
        cell.layer.mask = maskLayer
    }
    
    private func manage(cell: UITableViewCell, forIndexPath indexPath: IndexPath, isSelected: Bool) {
        if let sendToView = view.viewWithTag(32) as? SelectedFriendsView {
            if (isSelected) {
                sendToView.add(name: "Brandon Baars \(indexPath.section) \(indexPath.row)")
            } else {
                sendToView.remove(name: "Brandon Baars \(indexPath.section) \(indexPath.row)")
            }
        } else {
            
            let sendToView = SelectedFriendsView(frame: CGRect(x: 0,
                                                               y: view.frame.maxY - 80,
                                                               width: view.frame.width,
                                                               height: 80))
            sendToView.tag = 32
            view.addSubview(sendToView)
            
            sendToView.add(name: "Brandon Baars \(indexPath.section) \(indexPath.row)")
        }
    }
}
