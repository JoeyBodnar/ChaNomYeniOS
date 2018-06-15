//
//  homeView.swift
//  KeyValueKit
//
//  Created by Stephen Bodnar on 6/15/18.
//  Copyright © 2018 KeyValueKit. All rights reserved.
//


import UIKit

protocol HomeViewDelegate {
    func get()
}

class HomeView: UIView {
    var delegate: HomeViewDelegate!
    var getButton = UIButton()
    var setButton = UIButton()
    var removeButton = UIButton()
    
    var keyTextField = UITextField()
    var valueTextField = UITextField()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    func layout() {
        keyTextField.frame = CGRect(x: 0, y: 0, width: self.frame.width / 3, height: 35)
        keyTextField.placeholder = "key"
        self.addSubview(keyTextField)
        
        valueTextField.frame = CGRect(x: 0, y: 70, width: self.frame.width / 3, height: 35)
        valueTextField.placeholder = "value"
        self.addSubview(valueTextField)
        
        getButton.frame = CGRect(x: 0, y: valueTextField.frame.origin.y + valueTextField.frame.height + 5, width: self.frame.width / 3, height: 40)
        getButton.setTitle("get value", for: UIControlState.normal)
        getButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.addSubview(getButton)
        
        setButton.frame = CGRect(x: self.frame.width / 3, y: valueTextField.frame.origin.y + valueTextField.frame.height + 5, width: self.frame.width / 3, height: 40)
        setButton.setTitle("set value", for: UIControlState.normal)
        setButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.addSubview(setButton)
        
        removeButton.frame = CGRect(x:  self.frame.width * 0.667, y: valueTextField.frame.origin.y + valueTextField.frame.height + 5, width: self.frame.width / 3, height: 40)
        removeButton.setTitle("remove value", for: UIControlState.normal)
        removeButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.addSubview(removeButton)
    }

}
