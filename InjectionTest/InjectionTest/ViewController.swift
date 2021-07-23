//
//  ViewController.swift
//  InjectionTest
//
//  Created by kai jin on 2021/7/22.
//

import UIKit

class ViewController: UIViewController {
    var dataController = DataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dataController.printNetworkProvider()
        //print(dataController.networkProvider) // prints: NetworkProvider()

//        InjectedValues[\.networkProvider] = MockedNetworkProvider()
//        dataController.printNetworkProvider()
        //print(dataController.networkProvider) // prints: MockedNetworkProvider()

        dataController.networkProvider = NetworkProvider()
//        dataController.printNetworkProvider()
        //print(dataController.networkProvider) // prints 'NetworkProvider' as we overwritten the property wrapper wrapped value

//        dataController.performDataRequest() // prints: Data requested using the 'NetworkProvider'
        
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.setTitle("Enter", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(gotoTestPage), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    @objc func gotoTestPage() {
        self.present(TestViewController(), animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    


}

struct DataController {
    @Injected(\.networkProvider) var networkProvider: NetworkProviding
    
    func performDataRequest() {
        networkProvider.requestData()
    }
    
    func printNetworkProvider() {
        print(networkProvider)
    }
}
