//
//  ViewControllerExtension.swift
//  CheckClick
//
//  Created by OSX on 13/10/17.
//  Copyright © 2017 OSX. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UIViewController Extensions
extension UIViewController{
    
    //MARK: - Add ChildViewController
    func addViewAsChildViewController(childViewController : UIViewController , containerView: UIView){
        
//        childViewController.willMove(toParentViewController: nil)
//         childViewController.view.removeFromSuperview()
//         childViewController.removeFromParentViewController()
         addChildViewController(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        childViewController.didMove(toParentViewController: self)
    }
    
    //MARK: - Remove Child View Controller
    func removeViewAsChildViewController(childViewController: UIViewController){
        childViewController.willMove(toParentViewController: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParentViewController()
    }
//
//    func addRemove(oldController: UIViewController , newController: UIViewController , containerView: UIView ){
//
//        self.removeViewAsChildViewController(childViewController: oldController)
//        self.addViewAsChildViewController(childViewController: newController, containerView: containerView)
//    }
}
