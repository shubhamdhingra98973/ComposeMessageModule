//
//  TextViewController.swift
//  ComposeMessageModule
//
//  Created by NupurMac on 15/05/18.
//  Copyright © 2018 ShubhamMac. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class TextViewController: BaseViewController {

    //MARK::- OUTLETS
    @IBOutlet weak var txtSubjLine : UITextField?
    @IBOutlet weak var txtMessage : UITextView?
    @IBOutlet weak var btnSend : UIButton?
    
    //MARK::- VARIABLES
     var placeholderLabel : UILabel!
   
    //MARK::- LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        onViewDidLoad()
        placeholderLabel = Utility.shared.setUpTextViewPlaceholder(txtMessage!)
        txtMessage?.addSubview(placeholderLabel)
        placeholderLabel.isHidden = !(/txtMessage?.text.isEmpty)
    }
    
    func onViewDidLoad(){
        txtMessage?.delegate = self
        txtSubjLine?.delegate = self
        txtSubjLine?.attributedPlaceholder = Utility.shared.setUpPlaceholderFont(placeholderText: MsgConstants.subjLine.get)
    }
    
    //MARK::- BUTTON ACTIONS
    @IBAction func btnSendAct(_ sender: UIButton) {
        
        sendMessage(subjectLine: txtSubjLine?.text, body: txtMessage?.text,msgType: "1", byteArray: nil) { (response) in
            if let str = response as? String {
               Messages.shared.show(alert: .success , message: str, type: .success)
           }
        }
    }
}

//MARK::- API - (SEND MESSGAGE)

extension TextViewController {
    
//    func sendTextMessage() {
//        var attachment , msgType : String?
//
//        if let vc = ez.topMostVC  as? ComposeMsgViewController {
//            if vc.selectedIndex == 0 {
//                attachment = nil
//            }
//            msgType = (vc.selectedIndex + 1).toString
//        }
//
//        var recipentArr = [NSMutableDictionary]()
//
//        for (index,id) in receiverID.enumerated() {
//            let dict = NSMutableDictionary()
//            dict["ReceiverID"] = id
//            dict["ReceiverType"] = receiverType[index]
//            recipentArr.append(dict)
//        }
//
//        let recipentString = Utility.shared.converyToJSONString(array: recipentArr)
//
//        APIManager.shared.request(with: HomeEndpoint.sendMessage(MsgType : msgType , UserID: "55", UserType: "1" , Subject: txtSubjLine?.text, Body: txtMessage?.text, Device: "2", Attachment: attachment, Recipient: recipentString)) { (response) in
//            switch response {
//            case .success(let val):
//                if let str = val as? String {
//                    Messages.shared.show(alert: .success , message: str, type: .success)
//                }
//            case .failure :
//                break
//            }
//        }
//    }
}


//MARK ::- CheckSendButtonState
extension TextViewController {
    
    func checkSendButtonState() {
        if !(/txtMessage?.text.trimmed().isEmpty) && !(/txtSubjLine?.text?.trimmed().isEmpty){
            btnSend?.isHidden = false
        }
        else {
            btnSend?.isHidden = true
        }
    }
}


//MARK::- TextViewDelegate
extension TextViewController : UITextViewDelegate {
   
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        checkSendButtonState()
    }
}

//MARK::- TextFieldDelegate
extension TextViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        btnSend?.isHidden = (/txtSubjLine?.text?.count == 0)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
          checkSendButtonState()
    }
}

