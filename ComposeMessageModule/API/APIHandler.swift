//
//  APIHandler.swift
//  BusinessDirectory
//
//  Created by Aseem 13 on 04/01/17.
//  Copyright © 2017 Shubham Dhingra All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

enum ResponseKeys : String {
    case data
    
}

extension HomeEndpoint {
    
    func handle(data : Any) -> AnyObject?
    {
        //let parameters = JSON(data)
        
        switch self {
        case .sendMessage(_):
            let json = JSON(data)
            return json[APIConstants.message].stringValue as AnyObject
//        case .getMainCategory(_):
//            let object = Mapper<CategoryModal>().map(JSONObject: data)
//            return object
        default :
            return "" as? AnyObject
        }
    }
    
}

