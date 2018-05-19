//
//  DateExtension.swift
//  CheckClick
//
//  Created by OSX on 31/10/17.
//  Copyright © 2017 OSX. All rights reserved.
//

import Foundation

extension Date {
    
    
    func dateToString(formatType : String?) -> String?{
        let formatter = DateFormatter()
        formatter.dateFormat = formatType
       // guard let date = date else{return ""}
        return formatter.string(from: self)
    }
    

    
   
}
