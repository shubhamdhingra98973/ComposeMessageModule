


import UIKit
import EZSwiftExtensions
import Photos

class CameraGalleryPickerBlock: NSObject , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    typealias onPicked = (UIImage, String) -> ()
    typealias onCanceled = () -> ()
    
    
    var pickedListner : onPicked?
    var canceledListner : onCanceled?
    
    static let shared = CameraGalleryPickerBlock()
    
    override init(){
        super.init()
    }
    
    deinit{
        
    }
    func pickerImage(pickedListner : @escaping onPicked , canceledListner : @escaping onCanceled){
        
        
        UtilityFunctions.sharedInstance.showActionSheetWithStringButtons(buttons: [R.string.localizable.camera() , R.string.localizable.gallery()], success: {[unowned self] (str) in
            
            
            if str == R.string.localizable.camera(){
                
                UtilityFunctions.sharedInstance.isCameraPermission(actionOkButton: { (isOk) in
                    if !isOk{
                        
                        ez.runThisInMainThread {
                            self.showAlert(R.string.localizable.settings(), R.string.localizable.settingsCameraApp())
                        }
                        
                    }else {
                        self.pickedListner = pickedListner
                        self.canceledListner = canceledListner
                        self.showCameraOrGallery(type: str)
                    }
                    
                })
            }else {
                
                
                UtilityFunctions.sharedInstance.accessToPhotos(actionOkButton: { (isOk) in
                    
                    if !isOk{
                        ez.runThisInMainThread {
                           self.showAlert(R.string.localizable.settings(), R.string.localizable.settingsGalleryApp())
                        }
                    }else {
                        self.pickedListner = pickedListner
                        self.canceledListner = canceledListner
                        
                        self.showCameraOrGallery(type: str)
                    }
                })
            }
        })
    }
    
    func showAlert(_ title : String? , _ message : String?){
        
        AlertsClass.shared.showAlertController(withTitle: /title, message: /message, buttonTitles: [R.string.localizable.settings(),R.string.localizable.cancel()]) { (value) in
            let type = value as AlertTag
            switch type {
            case .yes:
                self.openSettings()
            default:
                return
            }
        }
    }
    
    
    func showCameraOrGallery(type : String){
        
        let picker : UIImagePickerController = UIImagePickerController()
        picker.sourceType = /type == R.string.localizable.camera() ? UIImagePickerControllerSourceType.camera : UIImagePickerControllerSourceType.photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        ez.runThisInMainThread {
            ez.topMostVC?.present(picker, animated: true, completion: nil)
        }
        
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        if let listener = canceledListner{
            listener()
        }
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        var fileName : String?
        if let image : UIImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            //self.cropImage(image: image)
            guard let data = UIImageJPEGRepresentation(image, 1) else { return }
             let intMBData = data.count/1024/1024
            if (intMBData < 5){
            
            
            }
            if let imageURL = info[UIImagePickerControllerReferenceURL] as? URL {
                let result = PHAsset.fetchAssets(withALAssetURLs: [imageURL], options: nil)
                let assets = result.firstObject
                if let filename =  assets?.value(forKey: "filename") {
                    fileName = filename as? String
                }
            }
            
            if let listener = pickedListner{
                listener(image , /fileName)
            }
        }
        
    }
    
    
    func openSettings(){
        
        let settingsUrl = NSURL(string:UIApplicationOpenSettingsURLString)! as URL
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
            
            let settingsUrl = URL(string: UIApplicationOpenSettingsURLString)
            if let url = settingsUrl {
                UIApplication.shared.openURL(url)
            }
            
        }
        
    }
}

//
//    func cropImage(image : UIImage){
//
//        let vc = TOCropViewController(image:image )
//        vc.delegate = self
//
//        ez.runThisAfterDelay(seconds: 0.5) {
//             ez.topMostVC?.presentVC(vc)
//        }
//
//
//
//    }





//extension CameraGalleryPickerBlock : TOCropViewControllerDelegate{
//
//    func cropViewController(_ cropViewController: TOCropViewController, didCropToImage image: UIImage, rect cropRect: CGRect, angle: Int) {
//
//        if let listener = pickedListner{
//
//            listener(image)
//            cropViewController.dismissVC(completion: nil)
//        }
//
//    }
//
//}

