//
//  Login.swift
//  APISampleClass
//
//  Created by Aseem 13 on 04/01/17.
//  Copyright © 2017 Shubham Dhingra All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON
//import EZSwiftExtensions

protocol Router {
    var route : String { get }
    var baseURL : String { get }
    var parameters : OptionalDictionary { get }
    var method : Alamofire.HTTPMethod { get }
    func handle(data : Any) -> AnyObject?
    var header : [String: String] {get}
}

extension Sequence where Iterator.Element == Keys {
    
    func map(values: [Any?]) -> OptionalDictionary {
        
        var params = [String : Any]()
        
        for (index,element) in zip(self,values) {
            if element as? String != "" || ((element as? [UInt8]) != nil){
                params[index.rawValue] = element
            }
        }
        return params
     }
}


enum HomeEndpoint {
    case sendMessage(MsgType : String? , UserID : String? , UserType : String? , Subject : String? , Body : String? , Device : String? , Attachment : [UInt8]? , Recipient : String?)
    }


extension HomeEndpoint : Router{
    
    var route : String  {
        
        switch self {
        case .sendMessage(_) : return APIConstants.sendMessage
        }
    }
    
    var parameters: OptionalDictionary{
        return format()
        
    }
    
    func format() -> OptionalDictionary {
        //    let  deviceType = "IOS", version = ez.appVersion
        //          let  appdelegate = UIApplication.shared.delegate as? AppDelegate, deviceType = "IOS", version = ez.appVersion
        let schoolCode : String = "FSPSGN"
        let key : String = "jg98ATQO6XksZUmA5Ni7yw=="
        let CountryCode : String = "+91"
        let ipaddress : String = "192.168.103.106"
        switch self {
            case .sendMessage(let MsgType,let UserID,let UserType ,let Subject,let Body
                , let Device, let Attachment, let Recipient):
                return Parameters.sendMessage.map(values: [schoolCode, key, CountryCode, MsgType, UserID, UserType, Subject, Body, Device, ipaddress, Recipient, Attachment])
        }
    }
    
    var method : Alamofire.HTTPMethod {
        switch self {
        
        default : return .post
        }
    }
    
    var baseURL: String{
        return APIConstants.basePath
    }
    
    var header : [String: String]{
        
//        if let accessToken = UserSingleton.shared.accessToken?.get{
//            print("Authorization \(accessToken)")
//            return ["authorization" : "Bearer \(accessToken)"]
//        }
        
        return [:]
    }
    
    
}

