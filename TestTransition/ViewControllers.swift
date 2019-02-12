//
//  ViewController.swift
//  TestTransition
//
//  Created by Felipe Correa on 2/12/19.
//  Copyright © 2019 Felipe Correa. All rights reserved.
//

import UIKit

protocol HomeRoutable {
    func presentWelcome()
    func pushFlow(completion: (() -> Void)?)
}

class HomeRouter: BaseRouter, HomeRoutable {
    func presentWelcome() {
        let welcome = WelcomeViewController.instantiate(fromAppStoryboard: .Main)
//        welcome.modalPresentationStyle = .custom
//        welcome.modalTransitionStyle = .crossDissolve
        welcome.continueClosure = {
            self.pushFlow(completion: {
                welcome.dismiss(animated: true, completion: nil)
            })        }
        self.present(viewController: welcome, withNavigationCtrl: true)
    }
    
    func pushFlow(completion: (() -> Void)?) {
        let flow = FlowViewController.instantiate(fromAppStoryboard: .Main)
        self.push(flow, animated: true, completion: completion)
    }
}

class HomeViewController: UIViewController {
    
    var router: HomeRoutable!

    override func viewDidLoad() {
        super.viewDidLoad()
        router = HomeRouter(viewController: self)
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func welcomeAction(_ sender: Any) {
        self.router.presentWelcome()
    }
    
    @IBAction func flowAction(_ sender: Any) {
        self.router.pushFlow(completion: nil)
    }
}

class WelcomeViewController: UIViewController {
    
    var continueClosure: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func continueAction(_ sender: Any) {
        continueClosure?()
    }
    
}

class FlowViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}

