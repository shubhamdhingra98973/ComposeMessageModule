//
//  HeaderViewController.swift
//  ComposeMessageModule
//
//  Created by NupurMac on 15/05/18.
//  Copyright © 2018 ShubhamMac. All rights reserved.
//

import UIKit
import Foundation
import EZSwiftExtensions


class HeaderViewController: UIViewController {

    //MARK::- OUTLETS
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnContact: UIButton!
    
    //MARK::- LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
     }

    //MARK::- BUTTON ACTIONS
    @IBAction func btnBackAct(_ sender: UIButton) {
    }
    
    @IBAction func btnContactAct(_ sender: UIButton) {
        guard let vc  = R.storyboard.main.audioPlayerViewController() else {return}
        ez.topMostVC?.presentVC(vc)
    }
    

}
