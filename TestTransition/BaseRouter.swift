//
//  BaseRouter.swift
//  TestTransition
//
//  Created by Felipe Correa on 2/12/19.
//  Copyright © 2019 Felipe Correa. All rights reserved.
//

import UIKit

/// Class used as base for all routers
/// This class is responsible for coordinate the controller's navigation flow
class BaseRouter {
    weak var viewController: UIViewController!
    
//    let disposeBag = DisposeBag()
    
    var navigationController: UINavigationController? {
        return self.viewController.navigationController
    }
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Navigation methods
    
    func push(viewController: UIViewController, animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: animated)
        }
    }
    
    func push(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.push(viewController: viewController, animated: animated)
        CATransaction.commit()
    }
    
    func pop(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pop(animated: animated)
        CATransaction.commit()
    }
    
    func pop(animated: Bool) {
        // navigate here
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: animated)
        }
    }
    
    func present(viewController: UIViewController, withNavigationCtrl navigation: Bool = false) {
        var ctrlToShow = viewController //The controller to be shown
        if navigation { //if is needed to create a nav ctrl, enters here
            let navCtrl = UINavigationController(rootViewController: viewController)
            navCtrl.navigationBar.isTranslucent = false
            ctrlToShow = navCtrl
        }
        DispatchQueue.main.async {
            self.viewController.present(ctrlToShow, animated: true, completion: nil)
        }
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.viewController.dismiss(animated: animated, completion: completion)
        }
    }
}
