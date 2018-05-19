//
//  Enums.swift
//  ComposeMessageModule
//
//  Created by NupurMac on 17/05/18.
//  Copyright © 2018 ShubhamMac. All rights reserved.
//

import Foundation
import UIKit

enum MsgConstants : String {
    
    case subjLine = "Subject Line"
    case browseFlyerMsg = "Browse Flyer Message"
    
    var get : String {
        return self.rawValue
    }
}


