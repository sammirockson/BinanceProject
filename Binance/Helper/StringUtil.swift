//
//  StringUtil.swift
//  cryptowallet
//
//  Created by andy on 2018/7/11.
//  Copyright © 2018年 Cybermiles. All rights reserved.
//

import Foundation



struct StringUtil
{
    
    static let shareInstance = StringUtil()
    
    func safeString(str : String?) -> String
    {
        return "\(str ?? "")"
    }
}



extension  String{
    
    // default .00
    func format2String () -> String?{
        if self.isEmpty || self == ""{
            return ""
        }

        let stringArray : [Substring] = self.split(separator: ".")
        var finalString : String = self
        
        if  stringArray.count > 1 {
            
            //before .
            let firstStr : String = String(stringArray[0])
            let lastStr : String = String(stringArray[1])
            let format = NumberFormatter()
            format.numberStyle = .decimal
            finalString = format.string(from: NSNumber(value: Double(firstStr)!))!
            finalString = finalString + "."
            
            
            //after .
            if lastStr.count >= 2 {
                finalString = finalString + lastStr[..<String.Index.init(encodedOffset: 2)]
            }else if lastStr.count == 1 {
                finalString = finalString + lastStr[..<String.Index.init(encodedOffset: 1)] + "0"
            }
            
        }else {//have no "."
            finalString = finalString + ".00"
        }
        
        return finalString
    }
    
    // default .0000
    func format4String () -> String?{
        if self.isEmpty || self == ""{
            return ""
        }
        
        let stringArray : [Substring] = self.split(separator: ".")
        var finalString : String = self
        
        if  stringArray.count > 1 {
            
            //before .
            let firstStr : String = String(stringArray[0])
            let lastStr : String = String(stringArray[1])
            let format = NumberFormatter()
            format.numberStyle = .decimal
            finalString = format.string(from: NSNumber(value: Double(firstStr)!))!
            finalString = finalString + "."
            
            
            //after .
            if lastStr.count >= 4 {
                finalString = finalString + lastStr[..<String.Index.init(encodedOffset: 4)]
            }else if lastStr.count == 3 {
                finalString = finalString + lastStr[..<String.Index.init(encodedOffset: 3)] + "000"
            }else if lastStr.count == 2 {
                finalString = finalString + lastStr[..<String.Index.init(encodedOffset: 2)] + "00"
            }else if lastStr.count == 1 {
                finalString = finalString + lastStr[..<String.Index.init(encodedOffset: 1)] + "0"
            }
            
        }else {//have no "."
            finalString = finalString + ".0000"
        }
        
        return finalString
    }
    

}
