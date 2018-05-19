//
//  APIConstants.swift
//  BusinessDirectory
//
//  Created by Aseem 13 on 04/01/17.
//  Copyright © 2017 Shubham Dhingra All rights reserved.
//


import Foundation

internal struct APIConstants {
    
    static let basePath = "http://webapi.palmboard.in/api/"
    static let sendMessage = "Message/SendMessage"
    static let language = "language"
    static let login = "vendor/login"
    static let status = "Status"
    static let message = "Message"
    static let errorCode = "ErrorCode"

}

enum Keys : String{
    
    //send Message
    case SchoolCode
    case key
    case CountryCode
    case MsgType
    case UserID
    case UserType
    case Subject
    case Body
    case Device
    case IPAddress
    case Attachment
    case Recipient
  
}


enum Validate : String {
    
    case none
    case success = "0"
    case failure = "1"
    case invalidAccessToken = "401"
    case adminBlocked = "403"
    
    func map(response message : String?) -> String? {
        
        switch self {
        case .success:
            return message
        case .failure :
            return message
        case .invalidAccessToken :
            return message
        case .adminBlocked:
            return message
        default:
            return nil
        }
        
    }
}

enum Response {
    case success(AnyObject?)
    case failure(String?)
}

typealias OptionalDictionary = [String : Any]?

struct Parameters {
    
    static let sendMessage : [Keys] = [.SchoolCode , .key , .CountryCode , .MsgType , .UserID , .UserType , .Subject , .Body , .Device , .IPAddress ,.Recipient, .Attachment]
 }





