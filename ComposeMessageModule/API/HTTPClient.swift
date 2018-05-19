//
//  HTTPClient.swift
//  BusinessDirectory
//
//  Created by Aseem 13 on 04/01/17.
//  Copyright © 2017 Shubham Dhingra All rights reserved.
//

import Foundation
import Alamofire

typealias HttpClientSuccess = (Any?) -> ()
typealias HttpClientFailure = (String) -> ()

class HTTPClient {
    
    func JSONObjectWithData(data: NSData) -> Any? {
        do { return try JSONSerialization.jsonObject(with: data as Data, options: []) }
        catch { return .none }
    }
    
    func postRequest(withApi api : Router , success : @escaping HttpClientSuccess , failure : @escaping HttpClientFailure ){
        
        let fullPath = api.baseURL + api.route
        print(fullPath)
         print(api.parameters ?? "")
//         var recipentArr = [NSMutableDictionary]()
//         let receiverID : [Int] = [8,17,55]
//         let receiverType : [Int] = [3,3,1]
//        
//        for (index,id) in receiverID.enumerated() {
//            let dict = NSMutableDictionary()
//            dict["ReceiverID"] = id
//            dict["ReceiverType"] = receiverType[index]
//            recipentArr.append(dict)
//        }
//        
//        var parameters = [String: Any]()
//        parameters["SchoolCode"]  = "FSPSGN"
//        parameters["key"]   = "jg98ATQO6XksZUmA5Ni7yw=="
//        parameters["CountryCode"]    = 91
//        parameters["IPAddress"]    = "192.168.103.106"
//        parameters["Body"]  = "9A66B38D-9039-4B8C-B635-EC5F4F509EBB.PNG"
//        parameters["UserID"] = "8"
//        parameters["UserType"] = "3"
//        parameters["MsgType"] = "2"
//        parameters["Subject"] = "district"
//        parameters["Device"] = "2"
//        parameters["Recipient"] = Utility.shared.converyToJSONString(array: recipentArr)
//       
//        
//        // Get the String.UTF8View.
//        let bytes = Stringss.getbase64().utf8
//        print(bytes)
//        
//        var buffer = [UInt8](bytes)
//        
//        
//        buffer[0] = buffer[0] + UInt8(1)
//        parameters["Attachment"] = buffer
//        print(buffer)
//        
//        // Get a string from the byte array.
//        if let result = String(bytes: buffer, encoding: String.Encoding.ascii) {
//            print(result)
//             //parameters["Attachment"] = result
//        }
//        
//        print("parameters ===> \(parameters)")
//        
        
        Alamofire.request(fullPath, method: api.method, parameters: api.parameters, encoding: URLEncoding.default, headers: [:]).responseJSON { (response) in
            
            switch response.result {
            case .success(let data):
                
                
                success(data)
            case .failure(let error):
                failure(error.localizedDescription)
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Server Error: " + str)
                }
                debugPrint(error as Any)
                print("===========================\n\n")
            }
        }
    }
    

    
    
    func postRequestWithImage(withApi api : Router, image : UIImage?, success : @escaping HttpClientSuccess , failure : @escaping HttpClientFailure){
        
        guard let params = api.parameters else {failure("empty"); return}
        let fullPath = api.baseURL + api.route
        print(fullPath)
        print(api.parameters ?? "")
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if let img = image {
                let imageData = UIImageJPEGRepresentation(img , 0.5)
                multipartFormData.append(imageData!, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
            }
            
            for (key, value) in params {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
        },to: fullPath ,method : api.method, headers : headerNeeded(api: api) ? api.header : nil) { (encodingResult) in
            switch encodingResult {
            case .success(let upload,_,_):
                
                upload.responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        success(data)
                    case .failure(let error):
                        failure(error.localizedDescription)
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    func postRequestWithDocument(withApi api : Router,documentUrl : URL?, success : @escaping HttpClientSuccess , failure : @escaping HttpClientFailure){
        
        guard let params = api.parameters else {failure("empty"); return}
        let fullPath = api.baseURL + api.route
        //print(fullPath)
        //print(params)
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if let url = documentUrl {
                guard let data = try? Data(contentsOf: url) else {
                    return
                }
                multipartFormData.append(data, withName: "file", fileName: "Notes.pdf", mimeType: "application/pdf")
            }
            
            for (key, value) in params {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue
                    )!, withName: key)
            }
            
        }, to: fullPath) { (encodingResult) in
            switch encodingResult {
            case .success(let upload,_,_):
                
                upload.responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        success(data)
                    case .failure(let error):
                        failure(error.localizedDescription)
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }

    func headerNeeded(api : Router) -> Bool{
        switch api.route {
        default: return false
        }
    }
    
 
}

