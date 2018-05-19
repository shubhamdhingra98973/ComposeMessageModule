//
//  BaseViewController.swift
//  ComposeMessageModule
//
//  Created by NupurMac on 16/05/18.
//  Copyright © 2018 ShubhamMac. All rights reserved.
//

import UIKit
import EZSwiftExtensions


typealias successBlock = (_ result: AnyObject? ) -> ()
class BaseViewController: UIViewController {
    
    //MARK::- OUTLETS
    @IBOutlet weak var tableView : UITableView?
    @IBOutlet weak var collectionView : UICollectionView?
    
    //MARK::- VARIABLES
    var receiverID : [Int] = [8,17]
    var receiverType : [Int] = [3,3]
    var userType : String?
    var userID : String?
    
    
    //MARK::- LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK::- BUTTON ACTIONS
    @IBAction func btnBackAct(_ sender: UIButton) {
        
    }
    
    //MARK::- HANDLE API RESPONSE
    func handleResponse(response : Response, responseBack : successBlock) {
        switch response{
            
        case .success(let responseValue):
            responseBack(responseValue)
            
        case .failure(let msg):
            Messages.shared.show(alert: .oops, message: /msg, type: .warning)
        }
    }
}


//MARK::- Send text Message API
extension BaseViewController {
    
    func sendMessage(subjectLine : String? , body : String? , msgType : String? , byteArray : [UInt8]? , responseBack : @escaping successBlock) {
        var recipentArr = [NSMutableDictionary]()
        
        for (index,id) in receiverID.enumerated() {
            let dict = NSMutableDictionary()
            dict["ReceiverID"] = id
            dict["ReceiverType"] = receiverType[index]
            recipentArr.append(dict)
        }
        if msgType == "1"{
            userType = "1"
            userID = "55"
        }
        
        if msgType == "2" || msgType == "3"{
            userType = "3"
            userID = "8"
        }
        
        let recipentString = Utility.shared.converyToJSONString(array: recipentArr)
        
        APIManager.shared.request(with: HomeEndpoint.sendMessage(MsgType : msgType , UserID: userID , UserType: userType , Subject: subjectLine, Body: body, Device: "2", Attachment: byteArray, Recipient: recipentString)) { (response) in
            
            self.handleResponse(response: response, responseBack: { (response) in
                responseBack(response)
            })
        }
    }
}

