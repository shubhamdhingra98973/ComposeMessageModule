//
//  ImageViewController.swift
//  ComposeMessageModule
//
//  Created by NupurMac on 15/05/18.
//  Copyright © 2018 ShubhamMac. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class ImageViewController: BaseViewController {
    
    //MARK::- OUTLETS
    @IBOutlet weak var txtSubjLine : UITextField?
    @IBOutlet weak var lblMessage : UILabel?
    @IBOutlet weak var btnSend : UIButton?
    @IBOutlet weak var imgSelect :  UIImageView?
    @IBOutlet weak var imgWidthConst : NSLayoutConstraint?
    
    //MARK::- VARIABLES
    var placeholderLabel : UILabel!
    var pickedImage : UIImage?
    
    //MARK::- LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        onViewDidLoad()
    }
    
    func onViewDidLoad(){
        txtSubjLine?.delegate = self
        txtSubjLine?.attributedPlaceholder = Utility.shared.setUpPlaceholderFont(placeholderText: MsgConstants.subjLine.get)
    }
}


//MARK::- BUTTON ACTIONS
extension ImageViewController {
    
    @IBAction func btnSendAct(_ sender: UIButton) {
        
        sendMessage(subjectLine: txtSubjLine?.text, body: lblMessage?.text, msgType: "2", byteArray:  self.pickedImage?.covertImageToByteArray()
            
        ) { (response) in
            if let str = response as? String {
                Messages.shared.show(alert: .success , message: str, type: .success)
            }
        }
    }
    
    @IBAction func btnBrowseAct(_ sender: UIButton) {
        pickImage()
    }
}


//MARK::- FUNCTIONS

extension ImageViewController {
    func pickImage() {
        
        CameraGalleryPickerBlock.shared.pickerImage(pickedListner: {[weak self](image , filename) in
            self?.pickedImage = image
            if self?.pickedImage != nil {
                self?.imgWidthConst?.constant =  40.0
                self?.lblMessage?.text = filename
                self?.lblMessage?.font =  R.font.ubuntuItalic(size: 17.0)
                self?.imgSelect?.image = self?.pickedImage
                self?.checkSendButtonState()
            }}) {}
    }
}


//MARK ::- CheckSendButtonState
extension ImageViewController {
    
    func checkSendButtonState() {
        if !(/lblMessage?.text == MsgConstants.browseFlyerMsg.get) && !(/txtSubjLine?.text?.trimmed().isEmpty){
            btnSend?.isHidden = false
        }
        else {
            btnSend?.isHidden = true
        }
    }
}


//MARK::- TextFieldDelegate
extension ImageViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkSendButtonState()
    }
}


