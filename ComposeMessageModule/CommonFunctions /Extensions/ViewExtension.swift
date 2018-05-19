//
//  ViewExtension.swift
//  cozo
//
//  Created by Sierra 4 on 05/05/17.
//  Copyright © 2017 monika. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

protocol StringType { var get: String { get } }

extension String: StringType { var get: String { return self } }

extension Optional where Wrapped: StringType {
    func unwrap() -> String {
        return self?.get ?? ""
    }
}


extension UIButton {
    
    @IBInspectable
    open var exclusiveTouchEnabled : Bool {
        get {
            return self.isExclusiveTouch
        }
        set(value) {
            self.isExclusiveTouch = value
        }
    }
}



extension NSObject {
    var appDelegate:AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
}

extension UIView{
    func showAnimate()
    {
        self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1.0
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.removeFromSuperview()
            }
        });
    }
}

private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
}

extension String {
    func safelyLimitedTo(length n: Int)->String {
        let c = self.characters
        if (c.count <= n) { return self }
        return String( Array(c).prefix(upTo: n) )
    }
}



infix operator =>
infix operator =|
infix operator =<

typealias OptionalJSON = [String : JSON]?
//
//    func =>(key : ParamKeys, json : OptionalJSON) -> String?{
//        return json?[key.rawValue]?.stringValue
//    }
//
//    func =<(key : ParamKeys, json : OptionalJSON) -> [String : JSON]?{
//        return json?[key.rawValue]?.dictionaryValue
//    }
//
//    func =|(key : ParamKeys, json : OptionalJSON) -> [JSON]?{
//        return json?[key.rawValue]?.arrayValue
//    }
//

prefix operator /
prefix func /(value : String?) -> String {
    return value.unwrap()
}


enum XibError : Error {
    case XibNotFound
    case None
}

extension UIView {
    class func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func loadViewFromNib(withIdentifier identifier : String) throws -> UIView? {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName:identifier, bundle: bundle)
        let xibs = nib.instantiate(withOwner: self, options: nil)
        
        if xibs.count == 0 {
            return nil
        }
        guard let firstXib = xibs[0] as? UIView else{
            throw XibError.XibNotFound
        }
        return firstXib
    }
}



//MARK::- Extension
// 1) convertImageToBase64String
// 2) convertImageToByteArray



extension UIImage {
    
    //convertImageToBase64String
    func convertImageToBase64() -> String {
        let imageData = UIImageJPEGRepresentation(self, 0.1)!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
    
//    //convertImageToByteArray
//    func covertImageToByteArray() -> String {
//
//        let base64String = self.convertImageToBase64()
//        let bytes = base64String.utf8.description
//
//        // Get the String.UTF8View.
//       // let bytes = base64String.utf8
//
////        //convert into byte array
////        var buffer = [UInt8](bytes)
////        buffer[0] = buffer[0] + UInt8(1)
////
//        return bytes
//
//    }
//
    func covertImageToByteArray() -> [UInt8] {

        let base64String = self.convertImageToBase64()

        // Get the String.UTF8View.
        let bytes = base64String.utf8

        //convert into byte array
        var buffer = [UInt8](bytes)
        buffer[0] = buffer[0] + UInt8(1)

        return buffer

    }
}








