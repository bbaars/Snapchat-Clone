//
//  StopWatchView.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/22/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

protocol StopWatchViewDelegate {
    func didSelect(time: Int)
}

class StopWatchView: UIView {

    private lazy var timePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.showsSelectionIndicator = true
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        return picker
    }()
    
    public var delegate: StopWatchViewDelegate?

    // Option-5
    public var startingTime: Int = 1 {
        didSet {
            if (startingTime > times.count) {
                startingTime = oldValue
            }
            delegate?.didSelect(time: startingTime)
        }
    }
    private var times: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "∞"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func reinitView(withStartingTime time: Int) {
        self.startingTime = time > times.count ? times.count - 1 : time
        timePicker.selectRow(startingTime, inComponent: 0, animated: false)
    }
    
    public func setupView() {
        
        let blurEffectView = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffectView)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(visualEffectView)
        addSubview(timePicker)
        
        visualEffectView.contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        visualEffectView.contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        visualEffectView.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        visualEffectView.contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        timePicker.topAnchor.constraint(equalTo: self.topAnchor, constant: -200).isActive = true
        timePicker.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        timePicker.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 200).isActive = true
        timePicker.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        
        addSubview(backgroundView)
        
        backgroundView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        backgroundView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        backgroundView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 125.0).isActive = true
        
        let secondsLabel = UILabel()
        secondsLabel.font = UIFont(name: UserInterface.Fonts.avenirNext, size: 20)
        secondsLabel.text = "seconds"
        secondsLabel.textColor = .white
        secondsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundView.addSubview(secondsLabel)
        
        backgroundView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|",
                                                                     options: [],
                                                                     metrics: nil,
                                                                     views: ["v0": secondsLabel]))
        backgroundView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]-60-|",
                                                                     options: [],
                                                                     metrics: nil,
                                                                     views: ["v0": secondsLabel]))
    }
}

extension StopWatchView : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 125.0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return times.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        startingTime = row
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel = view as? UILabel
        
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: UserInterface.Fonts.avenirNextDemiBold, size: 100)
            pickerLabel?.textAlignment = .center 
            pickerLabel?.layer.addShadow()
        }
        
        pickerLabel?.textColor = .white
        pickerLabel?.text = times[row]
        
        return pickerLabel!
    }
}
