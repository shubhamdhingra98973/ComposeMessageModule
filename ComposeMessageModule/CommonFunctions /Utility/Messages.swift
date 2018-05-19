
//  Alerts.swift

//  Created by NupurMac on 16/05/18.
//  Copyright © 2018 ShubhamMac. All rights reserved.
//


import UIKit
import SwiftMessages

enum Alert : String{
    case success = "Success"
    case oops = "Alert"
    case login = "Login Successfull"
    case ok = "Ok"
    case cancel = "Cancel"
    case error = "Error"
    case warning = "Warning"
}

enum Type{
    case success
    case warning
    case error
    case info
}

class Messages : NSObject {
    
    static let shared = Messages()
    
    
    //MARK: - Show Alert
    func show(alert title : Alert , message : String , type : Type){

        var alertConfig = SwiftMessages.defaultConfig
        alertConfig.presentationStyle = .top
        alertConfig.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        alertConfig.duration = .seconds(seconds: 2.0)
        
        let alertView = MessageView.viewFromNib(layout: .messageView)
        alertView.button?.isHidden = true
        alertView.configureDropShadow()
        alertView.titleLabel?.font = R.font.ubuntuLight(size: 16)
        alertView.bodyLabel?.text = message
        alertView.bodyLabel?.font = R.font.ubuntuLight(size: 14)
        alertView.configureContent(title: title.rawValue, body: message)
        
        switch type {
        case .error:
            alertView.configureTheme(.error)
        case .info:
            alertView.configureTheme(.info)
        case .success:
            alertView.configureTheme(.success)
            alertView.backgroundView.backgroundColor = UIColor.successColor
        case .warning:
            alertView.configureTheme(.warning)
            alertView.backgroundView.backgroundColor = UIColor.flatStepProgress
            
        }
        
        alertView.titleLabel?.textColor = UIColor.white
        alertView.bodyLabel?.textColor = UIColor.white
        
        SwiftMessages.show(config: alertConfig, view: alertView)
      
    }
}

