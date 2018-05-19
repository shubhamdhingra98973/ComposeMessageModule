
//  Created by NupurMac on 16/05/18.
//  Copyright © 2018 ShubhamMac. All rights reserved.
//


import UIKit
import SwiftyJSON
import ObjectMapper


class UserSingleton: NSObject {
    
    class var shared: UserSingleton {
        
        struct Static {
            static let instance: UserSingleton = UserSingleton()
        }
        return Static.instance
    }
    
    override init(){
        super.init()
    }
    
    deinit {
    }
    var checkNotification: Int?
    var notificationData : JSON?
   // var deviceToken : String?
    
    enum UDKeys: String{
//
//        case WhrzAtUser = "WhrzAtUser"
//
//        case WhrzAtUserLat = "WhrzAtUserLat"
//        case WhrzAtUserLong = "WhrzAtUserLong"
//        case WhrzAtUserLocation = "WhrzAtUserLocation"
        case CheckClickAccessToken = "CheckClickAccessToken"

         func save(_ value: Any) {
            
            switch self{
                
            default:
                UserDefaults.standard.set(value, forKey: self.rawValue)
                UserDefaults.standard.synchronize()
            }
        }
        
        func fetch() -> Any? {
            
            switch self{
                default:
                guard let value = UserDefaults.standard.value(forKey: self.rawValue) else { return nil}
                return value
            }
        }
        
        func remove() {
            UserDefaults.standard.removeObject(forKey: self.rawValue)
        }
        
    }
    
        var accessToken  : String?{
            get{
                guard let accessToken = UDKeys.CheckClickAccessToken.fetch() else{ return "" }
                return accessToken as? String ?? ""
            }
            set{
                if let value = newValue{
                    UDKeys.CheckClickAccessToken.save(value)
                }else{
                    UDKeys.CheckClickAccessToken.remove()
                }
            }
        }
    
    
//    var loggedInUser : RegisterUser? {
//        get{
//            guard let data = UDKeys.WhrzAtUser.fetch() else {
//                let mappedModel = Mapper<RegisterUser>().map(JSON: [:] as! [String : Any])
//                return mappedModel
//            }
//            let mappedModel = Mapper<RegisterUser>().map(JSON: data as! [String : Any])
//            return mappedModel
//        }
//        set{
//            if let value = newValue {
//                UDKeys.WhrzAtUser.save(value.toJSON())
//            }else{
//                UDKeys.WhrzAtUser.remove()
//
//            }
//        }
//    }
//
    
//    var lat : String?{
//        get{
//            guard let lat = UDKeys.WhrzAtUserLat.fetch() else {return ""}
//            return lat as? String ?? ""
//        }
//        set{
//            if let value = newValue{
//                UDKeys.WhrzAtUserLat.save(value)
//            }else{
//                UDKeys.WhrzAtUserLat.remove()
//            }
//        }
//    }
//    var long : String?{
//        get{
//            guard let long = UDKeys.WhrzAtUserLong.fetch() else{return ""}
//            return long as? String ?? ""
//        }
//        set{
//            if let value = newValue{
//                UDKeys.WhrzAtUserLong.save(value)
//            }else{
//                UDKeys.WhrzAtUserLong.remove()
//            }
//        }
//    }
//
//    var location : String?{
//        get{
//            guard let long = UDKeys.WhrzAtUserLocation.fetch() else{return ""}
//            return long as? String ?? ""
//        }
//        set{
//            if let value = newValue{
//                UDKeys.WhrzAtUserLocation.save(value)
//            }else{
//                UDKeys.WhrzAtUserLocation.remove()
//            }
//        }
//    }
    

}

