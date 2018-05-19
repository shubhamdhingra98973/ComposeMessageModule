//
//  Validation.swift
//  Paramount
//
//  Created by cbl24 on 15/02/17.
//  Copyright © 2017 Codebrew. All rights reserved.
//

import UIKit

extension String {
    
    enum FieldType : String{
        
        case firstName
        case lastName
        case name
        case middleName
        case email
        case password
        case newpassword
        case info
        case mobile
        case country
        case state
        case city
        case designation
        case address
        case building
        case amount 
        case extensionn
        case image
        case regNo
        case personnelId
        case zipCode
        case district
        case buildingNo
        case date
        case bookTime
        case serviceCharge
        case serviceOrder
        
        
        func value() -> String? {
            switch self {
            case .firstName :  return R.string.localizable.firstName()
            case .middleName : return R.string.localizable.middleName()
            case .name : return R.string.localizable.name()
            case .lastName :  return R.string.localizable.lastName()
            case .email :  return R.string.localizable.email()
            case .password :  return R.string.localizable.password()
            case .newpassword :  return R.string.localizable.newpassword()
            case .info :  return R.string.localizable.info()
            case .mobile :  return R.string.localizable.mobile()
            case .country : return R.string.localizable.country()
            case .state : return R.string.localizable.state()
            case .city : return R.string.localizable.city()
            case .designation : return R.string.localizable.designation()
            case .address : return R.string.localizable.address()
            case .building : return R.string.localizable.building()
            case .amount : return R.string.localizable.building()
            case .extensionn : return R.string.localizable.building()
            case .image : return R.string.localizable.image()
            case .regNo : return R.string.localizable.commRegNo()
            case .personnelId : return R.string.localizable.authPersonnelId()
            case .zipCode : return R.string.localizable.zipCode()
            case .district : return R.string.localizable.district()
            case .buildingNo : return R.string.localizable.buildingNo()
            case .date : return R.string.localizable.dob()
            case .bookTime : return R.string.localizable.bookingTime()
            case .serviceCharge : return R.string.localizable.serviceCharge()
            case .serviceOrder : return R.string.localizable.serviceOrder()
     
            }
            
        }
    }
    
    enum Status : String {
        
        case empty
        case allSpaces
        case valid
        case inValid
        case allZeros
        case hasSpecialCharacter
        case notANumber
        case emptyCountrCode
        case mobileNumberLength
        case pwd
        case pinCode
        case zip
        case currency
        case misMatchPassword
        case image
        
        
        func value() -> String? {
            switch self {
            case .empty : return R.string.localizable.validEmpty()
            case .allSpaces : return R.string.localizable.validAllSpaces()
            case .valid : return nil
            case .inValid : return R.string.localizable.inValid()
            case .allZeros : return R.string.localizable.validAllZeros()
            case .hasSpecialCharacter : return R.string.localizable.validHasSpecialCharacter()
            case .notANumber  : return R.string.localizable.validNotANumber()
            case .emptyCountrCode : return R.string.localizable.validEmptyCountrCode()
            case .mobileNumberLength : return R.string.localizable.validMobileNumberLength()
            case .pwd : return R.string.localizable.validPwd()
            case .pinCode : return R.string.localizable.validPinCode()
            case .zip : return R.string.localizable.validZip()
            case .currency : return R.string.localizable.validCurrency()
            case .misMatchPassword : return R.string.localizable.validMatchPassword()
            case .image : return R.string.localizable.validImage()
                
            }
        }
        func message(type : FieldType) -> String? {
            
            switch self {
            case .hasSpecialCharacter: return /type.value() + /self.value()
            case .valid: return nil
            case .emptyCountrCode: return /self.value()
            case .pwd : return self.value()
            case .image : return self.value()
            case .mobileNumberLength : return /self.value()
            case .pinCode , .zip : return self.value()
            case .notANumber : return /type.value() + /self.value()
            default: return /self.value() + /type.value()
            }
        }
    }
    
    // **** validateEmailForm
    func validateEmailForm(email : String? , password : String? , confirmPassword : String?) -> Bool{
        
        if  !isValid(type : .email, info : email) || !isValid(type : .password, info : password){
            return false
        }
        else if password != confirmPassword {
            Messages.shared.show(alert: .oops, message: R.string.localizable.validMatchPassword(), type: .warning)
            //AlertsClass.shared.showAlert(with: Status.misMatchPassword.rawValue)
            return false
        }
        return true
    }
    
    // **** validatePhoneNumber
    func validatePhoneNumber(phone : String?) -> Bool{
        if isValid(type : .mobile , info : phone){
            return true
        }
        return false
    }
    
    
    func validateUpdateProfile(firstName : String? ,middleName : String? , lastName : String?) -> Bool{
        if !isValid(type : .firstName, info : firstName) || !isValid(type : .middleName , info : middleName) || !isValid(type : .lastName, info : lastName){
            return false
        }
        return true
    }
    
    
    func  validateCreateStoreOne(company : String? , name : String? , RegNo : String? , PersonnelId : String? ,dob : String?, email : String? , PhoneNo : String? ) -> Bool {
        if company == R.string.localizable.chooseCountry(){
            Messages.shared.show(alert: .oops, message: R.string.localizable.validCountry(), type: .warning)
            return false
        }
        else if  VendorType.entity.id == Utility.shared.getVendorType() {
            if !isValid(type : .name ,info : name) || !isValid(type : .regNo , info : RegNo ) || !isValid(type : .personnelId , info : PersonnelId){
                return false
            }
            
        }
        else if  VendorType.individual.id == Utility.shared.getVendorType()
        {
        if !isValid(type : .personnelId , info : PersonnelId) || !isValid(type : .date ,info : dob){
            return false
        }
        }
         if  !isValid(type : .mobile , info : PhoneNo) || !isValid(type : .email ,info : email){
            return false
        }
        return true
    }
    
    /** START **/
    /*** CODE TO CHECK THAT THE COUNTRY IS BELONG TO ARABIC REGION *****/
   
    func isValidateCountry(_ country : String?) -> Bool {
      
        if !isValid(type : .country , info : country){
        return false
        }
        else {
        return checkServiceCountry(country)
        }
      }
        
    func checkServiceCountry(_ country : String?) -> Bool{
        let arabCountries = Arrays.arabCountries.get() as! [String]
        var status : Bool = false
          for (_ ,value) in arabCountries.enumerated() {
            status = value.lowercased() == country?.lowercased() ? true : false
            if status == true {
                return status
            }
        }
        Messages.shared.show(alert: .oops, message: R.string.localizable.validateArabCountry(), type: .warning)
        return status
        }
    
    /** END **/
    func  validateCreateStoreForm(city : String? , district : String? , buildingNo  : String? , zipCode : String?) -> Bool {
        
        if !isValid(type : .city  ,info : city) || !isValid(type : .district , info : district ) || !isValid(type : .buildingNo , info : buildingNo) || !isValid(type : .zipCode , info : zipCode){
            return false
        }
        return true
    }
    /* Branch Communication validation */
    func validateCommunication(reviewE : String? , reviewA : String? , fbLink : String? , instaLink : String? , twitLink : String? , googleLink : String? , linkedinLink : String? , uTubeLink : String? , pinterestLink : String? , phoneNo1 : String? , phoneNo2 : String? , email1 : String? , email2 : String?) -> Bool{
        
        //if description no in english
        if  isValid(type : .info , info : reviewE) {
            return false
        }
        
        return true
    }
    
    
    
    /********* BRANCH SERVICE *******/
    
    func isValidServices(isStoreService : Bool?, isHomeService : Bool? , storeHours : String? , homeHours : String? , minServiceOrder : String? , serviceCharge : String? , bussinessSince : String?) -> Bool {
        if !(/isStoreService)  && !(/isHomeService) {
            Messages.shared.show(alert: .oops, message: R.string.localizable.validateOneService(),  type: .warning)
            return true
        }
        if /isStoreService{
            if !isValid(type : .bookTime , info : storeHours)  {return true}
        }
        if /isHomeService{
            if !isValid(type : .bookTime , info : homeHours) || !isValid(type : .serviceOrder , info : minServiceOrder) || !isValid(type : .serviceCharge , info : serviceCharge) {
                return true
        }
        }
        if !isValid(type : .date , info : bussinessSince){
                return true
        }
        return false
        }
    
    /*** BRANCH PAYMENT *****/
    
    func isValidatePayment(isCod : Bool? , isOnline : Bool? , image : UIImage?) -> Bool{
        if !(/isCod) && !(/isOnline) {
            Messages.shared.show(alert: .oops, message: R.string.localizable.validatePaymentMethod(), type: .warning)
            return false
        }
        if !"".isValidTermsAndConditions(image: image){
            return false
        }
   return true
    }
    func validateUploadDoc(image : UIImage?) -> Bool{
        if !isValidTermsAndConditions(image : image){
            return false
        }
        return true
    }
    
    
    func validatenName(storeName : String?) -> Bool {
        if !isValid(type : .name , info : storeName)
        {
            return false
        }
        return true
    }
    func validatePhone(phone : String?) -> Bool{
        if isValid(type : .mobile , info : phone){
            return true
        }
        return false
    }
    
    func isValidTermsAndConditions(image : UIImage?) -> Bool {
        
        if image == R.image.ic_rect() {
            Messages.shared.show(alert: .oops, message: R.string.localizable.validateTermsAndCond(), type: .warning)
            return false
        }
        return true
    }
    
    
//    func validateImage(image : UIImage?) -> Bool{
//        if !isValid(type: .image , info : image) {
//            return false
//        }
//        return true
//    }

    
    
    //}
    func validateName(first : String? , last : String?) -> Bool{
        if isValid(type : .firstName , info : first) && isValid(type : .lastName , info : last){
            return true
        }
        return false
    }
    
    
    
    func validateChangePassword(old : String? , new : String? , confirm : String?) -> Bool{
        
        if old == ""{
            // Alerts.shared.show(alert: .error, message: AlertMessage.enterOldPassword.rawValue , type : .info)
            return false
        }else if !isValid(type: .password, info: new){
            return false
        }else if new != confirm{
            // Alerts.shared.show(alert: .error, message: AlertMessage.matchConfirmAndNew.rawValue , type : .info)
            return false
        }else if new == old{
            // Alerts.shared.show(alert: .error, message:AlertMessage.matchOldAndNew.rawValue , type : .info)
            return false
        }
        else{
            return true
        }
    }
    
    func validateForgetPassword(new : String? , confirm : String?) -> Bool{
        
        if !isValid(type : .newpassword , info : new){
            return false
        }else if new != confirm{
            //Alerts.shared.show(alert: .error, message: AlertMessage.matchConfirmAndNew.rawValue , type : .info)
            return false
        }
        return true
        
    }
    
    
    
    
    func login(email : String?) -> Bool {
        if  isValid(type: .email, info: email)
        {
            return true
        }
        return false
    }
    
    func signup(firstname : String?, lastname : String?, email : String?, password : String?) -> Bool{
        if isValid(type: .firstName, info: firstname) && isValid(type: .lastName, info: lastname) && isValid(type: .email, info: email) && isValid(type: .password, info: password) {
            return true
        }
        return false
    }
    

    private func isValid(type : FieldType , info: String?) -> Bool {
        guard let validStatus = info?.handleStatus(fieldType : type) else {
            return true
        }
        
        let errorMessage = validStatus
        print(errorMessage)
        Messages.shared.show(alert: .oops, message: errorMessage, type: .warning)
        //AlertsClass.shared.showAlert(with: errorMessage)
        return false
    }
    
    func handleStatus(fieldType : FieldType) -> String? {
        
        switch fieldType {
        case .firstName , .lastName , .name :
            return  isValidName.message(type: fieldType)
        case .middleName :
            return isValidMiddleName.message(type: fieldType)
        case .email:
            return  isValidEmail.message(type: fieldType)
        case .password , .newpassword:
            return  isValid(password: 6, max: 15).message(type: fieldType)
        case .info:
            return  isValidInformation.message(type: fieldType)
        case .mobile:
            return  isValidPhoneNumber.message(type: fieldType)
        case .zipCode :
            return isValidZipCode.message(type:fieldType)
        case .amount ,.serviceOrder ,.serviceCharge , .bookTime:
            return  isValidAmount.message(type: fieldType)
        case .extensionn :
            return isValidExtension.message(type: fieldType)
        case .city , .district :
            return isValidWord.message(type:fieldType)
//        case   .designation  ,.personnelId ,.regNo:
//            return  isValidInformation.message(type: fieldType)
            // case .cardNumber:
            //      return  isValidCardNumber(length: 16).message(type: fieldType)
            
        default:
            return  isValidInformation.message(type: fieldType)
        }
    }
    
    
    
    var isNumber : Bool {
        if let _ = NumberFormatter().number(from: self) {
            return true
        }
        return false
    }
    
    var hasSpecialCharcters : Bool {
        return rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil || rangeOfCharacter(from: CharacterSet.letters.inverted) != nil
    }
    
    var hasSpecialCharactersWithNumber : Bool {
         return rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil
    }
    var isEveryCharcterZero : Bool{
        var count = 0
        self.characters.forEach {
            if $0 == "0"{
                count += 1
            }
        }
        if count == self.characters.count{
            return true
        }else{
            return false
        }
    }
    
    public var length: Int {
        return self.characters.count
    }
    
    public var isEmail: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let firstMatch = dataDetector?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: length))
        return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
    }
    
    public var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmed.isEmpty
        }
    }
    
    func isValid(password min: Int , max: Int) -> Status {
        if length < 0 { return .empty }
        if isBlank  { return .allSpaces }
        if characters.count >= min && characters.count <= max{
            return .valid
        }
        return .pwd
    }
    
    var isValidEmail : Status {
        if length < 0 { return .empty }
        if isBlank { return .allSpaces }
        if isEmail { return .valid }
        return .inValid
    }
    
    func isValidImage(image : UIImage?) -> Bool{
        if image == R.image.ic_profile_placeholder(){
            Messages.shared.show(alert: .oops, message: R.string.localizable.validImage(), type: .warning)
            return false
        }
        return true
    }
    
 
    
    var isValidInformation : Status {
        if length < 0 { return .empty }
        if isBlank { return .allSpaces }
        return .valid
    }
    
    var isValidExtension : Status {
        if hasSpecialCharcters { return .hasSpecialCharacter }
        if self.characters.count < 6  && isNumber { return .valid }
        if self.characters.count == 0 { return .valid }
        return .inValid
    }

    var isValidPhoneNumber : Status {
        
        if length <= 0 { return .empty }
        if isBlank { return .allSpaces }
        if isEveryCharcterZero { return .allZeros }
        if !isNumber() { return .inValid }
        if characters.count >= 6 && self.characters.count <= 15 { return .valid
        }
        else{
            return .mobileNumberLength
        }
    }
    
    var isValidName : Status {
        if length < 0 { return .empty }
        if isBlank { return .allSpaces }
        if hasSpecialCharcters { return .hasSpecialCharacter }
        
        return .valid
    }
    
    //Validation for City Country District
    var isValidWord : Status {
        if length < 0 { return .empty }
        if isBlank { return .allSpaces }
        if hasSpecialCharcters{ return .inValid}
        return .valid
    }
    
    var isValidMiddleName : Status {
        if hasSpecialCharcters { return .hasSpecialCharacter }
        return .valid
    }
    
    func isValidCardNumber(length max:Int ) -> Status {
        if length < 0 { return .empty }
        if isBlank { return .allSpaces }
        if hasSpecialCharcters { return .hasSpecialCharacter }
        if isEveryCharcterZero { return .allZeros }
        if characters.count >= 16 && characters.count <= max{
            return .valid
        }
        return .inValid
    }
    
    var isValidCVV : Status {
        if hasSpecialCharcters { return .hasSpecialCharacter }
        if isEveryCharcterZero { return .allZeros }
        if isNumber{
            if self.characters.count >= 3 && self.characters.count <= 4{
                return .valid
            }else{ return .inValid }
        }else { return .notANumber }
    }
    
    var isValidZipCode : Status {
        if length == 0 { return .empty }
        if isEveryCharcterZero { return .allZeros }
        if isBlank { return .allSpaces }
        if !isNumber{ return .inValid }
        if hasSpecialCharactersWithNumber {return.zip}
        if length > 6 {return .pinCode}
        
        return .valid
    }
    
    var isValidAmount :  Status {
        if length < 0 { return .empty }
        if isBlank { return .allSpaces }
        if !isNumber{ return .notANumber }
        return .valid
    }
    
}

