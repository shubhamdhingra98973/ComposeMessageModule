  //
  //  Utility.swift
  //  ComposeMessageModule
  //
  //  Created by NupurMac on 16/05/18.
  //  Copyright © 2018 Shubham. All rights reserved.
  //

  
  import UIKit
  import EZSwiftExtensions
  import CoreLocation
  import NVActivityIndicatorView
  
  typealias AWSBucketBlock = (_ assetName : String?,_ thumb : String?) -> ()
  typealias success = (_ coordinates: CLLocationCoordinate2D, _ fullAddress: String?, _ name : String?, _ city : String?,_ state : String?, _ subLocality: String?, _ postalCode : String? ,_ country : String? ) -> ()
  
  enum DateType{
    case time
    case date
  }
  
  class Utility: NSObject , NVActivityIndicatorViewable {
    
    static let shared = Utility()
    let geoCoder = CLGeocoder()
    var responseBack : success?
    let formatter = DateFormatter()
    
    
    static func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
        
    }
    
    override init() {
        super.init()
        //LocationManager.shared.updateLocation()
        
    }
    
    //MARK: Loader
    func loader()  {
        Utility.appDelegate().window?.rootViewController?.startAnimating(nil, message: nil, messageFont: nil, type: .ballSpinFadeLoader, color: UIColor.white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil)
    }
    
    func removeLoader()  {
        Utility.appDelegate().window?.rootViewController?.stopAnimating()
    }
    
    //MARK: JSON Converiosn to String
    
    func converyToJSONString (array : [Any]?) -> String{
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: array ?? [], options: JSONSerialization.WritingOptions.prettyPrinted)
            
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                return JSONString
            }
            
        } catch {}
        return ""
    }
 
    
    //MARK: Convert milliSec to Date
    func convertSecondToDate(second : Int?, type : DateType) -> String{
        
        guard let sec = second else {return String()}
        let dateVar = Date.init(timeIntervalSince1970: TimeInterval(sec / 1000))
        formatter.dateFormat = type == .date ? "dd MMMM yyyy" : "dd MMM yyyy"
        return formatter.string(from: dateVar)
        
    }
    
    
    //MARK: Location Function
    func stringToDate(_ dateString: String? , _ withFormat : String?) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        if let date = inputFormatter.date(from: /dateString) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = withFormat
            
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    
    
    func setUpPlaceholderFont(placeholderText : String) -> NSAttributedString{
        var attributedString = NSAttributedString()
        if let font = UIFont(name: "Ubuntu-Italic", size: 17.0){
            
            let attributes = [
                NSAttributedStringKey.font : font
            ]
            attributedString = NSAttributedString(string: placeholderText,attributes: attributes)
            
        }
        return attributedString
    }
    
    func setUpTextViewPlaceholder(_ txtView : UITextView) -> UILabel {
        
        let placeholderLabel = UILabel()
        placeholderLabel.text = "Your Message"
        placeholderLabel.font = UIFont(name: "Ubuntu-Italic", size: 17.0)
        placeholderLabel.sizeToFit()
        placeholderLabel.textColor = UIColor.flatGray
        placeholderLabel.frame.origin = CGPoint(x: 2, y: (txtView.font?.pointSize)! / 2)
        return placeholderLabel
    }
    
    func strToDate(_ strDate : String?) -> Date?{
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "h:mm a"
        
        if let date = inputFormatter.date(from: /strDate){
            return date
        }
        return nil
    }
 }
  extension NSMutableDictionary
  {
    func toJson() -> String {
        do {
            let data = self
            
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted)
            var string = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) ?? ""
            string = string.replacingOccurrences(of: "\n", with: "") as NSString
            print(string)
            string = string.replacingOccurrences(of: "\\", with: "") as NSString
            print(string)
            //            string = string.replacingOccurrences(of: "\"", with: "") as NSString
            string = string.replacingOccurrences(of: " ", with: "") as NSString
            print(string)
            return string as String
        }
        catch let error as NSError{
            print(error.description)
            return ""
        }
    }
  }

  extension UIViewController : NVActivityIndicatorViewable{
    
  }
  
  

