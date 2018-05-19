






import UIKit
import Toaster
import EZSwiftExtensions


typealias AlertBlock = (_ success: AlertTag) -> ()
enum AlertTag {
    case done
    case yes
    case no
}

class AlertsClass: NSObject, FCAlertViewDelegate{
  
    
    static let shared = AlertsClass()
    var responseBack : AlertBlock?
    
    var alertView: FCAlertView = {
        let alert = FCAlertView()
        alert.dismissOnOutsideTouch = true
        
        return alert
    }()
    
    override init() {
        super.init()
    }
    
    
    //MARK: Alert Method
    func showAlert(with message : String){
        ToastCenter.default.cancelAll()
        let toast = Toast(text: message)
        ToastView.appearance().textColor = UIColor.black
        ToastView.appearance().backgroundColor = UIColor.groupTableViewBackground
        toast.show()
    }
    
    //MARK: Alert Controller
    
    func showAlertController(withTitle title : String?, message : String, buttonTitles : [String], responseBlock : @escaping AlertBlock){
        
        alertView = FCAlertView()
        alertView.delegate = self
        responseBack = responseBlock
        alertView.colorScheme = UIColor.flatGreen
        alertView.numberOfButtons = 2
        buttonTitles.count > 0 ? (alertView.hideDoneButton = true) : (alertView.hideDoneButton = false)
        
        alertView.showAlert(inView: ez.topMostVC, withTitle: title, withSubtitle: message, withCustomImage: nil, withDoneButtonTitle: nil, andButtons: buttonTitles.count > 0 ? buttonTitles : nil)
        
    }
    
    func alertView(_ alertView: FCAlertView, clickedButtonIndex index: Int, buttonTitle title: String) {
        
        switch index {
        case 0:
            responseBack?(.yes)
        case 1:
            responseBack?(.no)
        default: return
        }
    }
    
}



