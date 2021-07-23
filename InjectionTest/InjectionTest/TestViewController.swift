//
//  TestViewController.swift
//  InjectionTest
//
//  Created by kai jin on 2021/7/22.
//

import Foundation
import UIKit

class TestViewController: UIViewController {
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.red
        
        var dataController = DataController()
        dataController.printNetworkProvider()
    }
}
