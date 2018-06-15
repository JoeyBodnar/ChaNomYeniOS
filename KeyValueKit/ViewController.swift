//
//  ViewController.swift
//  KeyValueKit
//
//  Created by Jason Nam on 14/6/18.
//  Copyright © 2018 KeyValueKit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var homeView = HomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        homeView = HomeView(frame: CGRect(x: 10, y: 30, width: self.view.frame.width - 20, height: 400))
        homeView.setButton.addTarget(self, action: #selector(set), for: UIControlEvents.touchUpInside)
        homeView.getButton.addTarget(self, action: #selector(get), for: UIControlEvents.touchUpInside)
        homeView.removeButton.addTarget(self, action: #selector(remove), for: UIControlEvents.touchUpInside)
        self.view.addSubview(homeView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func set() {
        let key = homeView.keyTextField.text!
        let value = homeView.valueTextField.text!
        let valueEncoded = value.data(using: String.Encoding.utf8)
        KeyValueKit.set(valueEncoded, forKey: key) { (result) in
            print("the result is  \(result)")
            DispatchQueue.main.async {
                self.homeView.resultLabel.text = "The value for key \(key) was saved as \(value)"
                self.homeView.resultLabel.sizeToFit()
            }
        }
    }
    
    @objc func get() {
        print("get was pressed")
        let key = homeView.keyTextField.text!
        KeyValueKit.getValue(forKey: key)  {  (result: Result<Data>) in
            switch result {
            case .success(let data):
                    print("the get value result is \(String(data: data, encoding: .utf8) ?? "")")
                    self.homeView.resultLabel.text = "The value for key \(key) is \(String(data: data, encoding: .utf8) ?? "")"
            default:
                return
            }
            
        }
    }
    
    @objc func remove() {
        print("remove was pressed")
    }


}

