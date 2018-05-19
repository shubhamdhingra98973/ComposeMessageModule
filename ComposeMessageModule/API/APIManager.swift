//
//  APIManager.swift
//  BusinessDirectory
//
//  Created by Aseem 13 on 04/01/17.
//  Copyright © 2017 Shubham Dhingra All rights reserved.
//
import Foundation
import SwiftyJSON

class APIManager : NSObject{
    
    typealias Completion = (Response) -> ()
    static let shared = APIManager()
    let delegate = UIApplication.shared.delegate as? AppDelegate
    private lazy var httpClient : HTTPClient = HTTPClient()
    
    func request(with api : Router , completion : @escaping Completion )  {
        
        if isLoaderNeeded(api: api) {
            Utility.shared.loader()
        }
        
        httpClient.postRequest(withApi: api, success: {[weak self] (data) in
            Utility.shared.removeLoader()
            
            guard let response = data else {
                completion(Response.failure(.none))
                return
            }
            
            let json = JSON(response)
            print(json)
           
            let responseType = Validate(rawValue: json[APIConstants.errorCode].stringValue) ?? .failure
            switch responseType {
            case .success:
                let object : AnyObject?
                object = api.handle(data: response)
                completion(Response.success(object))

            case .failure:
                completion(Response.failure(json[APIConstants.message].stringValue))
            default : break
            }
            
        }, failure: { (message) in
            
            Utility.shared.removeLoader()
            Messages.shared.show(alert: .oops, message: /message, type: .warning)
        })
    }
    
    //Request With Image
    func request(withImage api : Router , image : UIImage? , completion: @escaping Completion){
        
        if isLoaderNeeded (api: api) {
            Utility.shared.loader()
        }
        
        httpClient.postRequestWithImage(withApi: api, image: image, success: {[weak self] (data) in
            Utility.shared.removeLoader()
            guard let response = data else {
                completion(Response.failure(.none))
                return
            }
            let json = JSON(response)
            print(json)
            
            let responseType = Validate(rawValue: json[APIConstants.errorCode].stringValue) ?? .failure
            switch responseType {
            case .success:
                let object : AnyObject?
                object = api.handle(data: response)
                completion(Response.success(object))
                
            case .failure:
                completion(Response.failure(json[APIConstants.message].stringValue))
            default : break
            }
           
            }, failure: { (message) in
                
                Utility.shared.removeLoader()
                Messages.shared.show(alert: .oops, message: /message, type: .warning)
        })
    }
 
    func isLoaderNeeded(api : Router) -> Bool{
        
        switch api.route {
        default: return true
        }
    }
    
    
    
    
}
