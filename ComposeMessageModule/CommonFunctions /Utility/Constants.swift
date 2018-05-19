//
//  Constants.swift
//  HutchDecor
//
//  Created by NupurMac on 16/05/18.
//  Copyright © 2018 ShubhamMac. All rights reserved.
//


import UIKit
import EZSwiftExtensions
import RMMapper
import ObjectMapper

internal struct Padding {
    static let XL : CGFloat = 8.0
    static let XXL : CGFloat = 16.0
    static let XXXL : CGFloat = 24.0
    static let XXXXL : CGFloat = 32.0
}


struct HelperNames {
    static let timezone = "Asia/Kolkata"
    static let token = "Token"
    static let language = "language"
    static let itunesLink = "itms://itunes.apple.com/us/app/apple-store/id1278594992?mt=8"
}


struct Noti {
    static let dict = "NotificationInfo"
    static let type = "type"
    static let senderId = "sender_id"
    static let postNot = "Index1"
}


enum Defaults : String{
    
    case login
    case accessToken
    case gamePlatforms
    case games
    
    //    func get() -> Any?{
    //        switch self {
    //        case .login:
    //            return UserDefaults.standard.rm_customObject(forKey: self.rawValue) as? LoginModal
    //        case .accessToken:
    //            return (Defaults.login.get() as? LoginModal)?.accessToken
    //
    //        case .gamePlatforms,.games:
    //
    //            guard let data = UserDefaults.standard.rm_customObject(forKey: self.rawValue) else {return nil}
    //            return Mapper<GamesModal>().map(JSONObject: data as! [String : Any])?.data as [MyGames]?
    //
    //        }
    //    }
}


struct Screen {
    static let HEIGHT = UIScreen.main.bounds.size.height
    static let WIDTH = UIScreen.main.bounds.size.width
    static let HEIGHTRATIO = WIDTH * 0.5625
}

enum DocType : String {
    
    case doc1 = "doc1"
    case doc2 = "doc2"
    case doc3 = "doc3"
    
    var get : String {
        return self.rawValue
    }
}
enum PackageType : String{
    case branch = "BRANCH"
    case advertisement = "ADVERTISEMENT"
    
    var id : String {
        return self.rawValue
    }
}
enum TimeFormat : String {
    case hours = "HOURS"
    case days = "DAYS"
    
    var get : String {
        return self.rawValue
    }
}

internal struct Languages {
    static let Arabic = "ar"
    static let English = "en"
}

enum DateFormat : String{
    
    case type1 = "dd/MM"
    case type2 = "MMM, dd"
    case type3 = "MM/dd/YYYY"
    case type4 = "MMMM dd yyyy"
    var get : String {
        return self.rawValue
    }
}

enum States : String {
    case yes
    case no
}
enum StoreStatus : String{
    
    case Approved = "APPROVED"
    case Rejected = "REJECTED"
    case Pending = "PENDING"
    
    var id : String {
        return self.rawValue
    }
    
}

enum Lang : String {
    case en = "ENGLISH"
    case ar = "ARABIC"
    
    var id : String {
        return  self.rawValue
    }
}

enum CategoryType : String {
    case Products = "PRODUCTS"
    case Services = "SERVICES"
    
    var id : String {
       return self.rawValue
    }
}


enum VendorType : String {
    case entity = "ENTITY"
    case individual = "INDIVIDUAL"
    var id : String {
        return self.rawValue
    }
}
