//
//  SwiftFunctions.swift
//  IOS12TabBarControllerTutorial
//
//  Created by IOS Developer 3 on 7/16/19.
//  Copyright © 2019 fouad zeidan. All rights reserved.
//

import UIKit

class SwiftFunctions: NSObject {

      @objc static  func getWiFiAddress() -> String? {
            var address: String?
            var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
            if getifaddrs(&ifaddr) == 0 {
                var ptr = ifaddr
                while ptr != nil {
                    defer { ptr = ptr?.pointee.ifa_next }

                    guard let interface = ptr?.pointee else { return "" }
                    let addrFamily = interface.ifa_addr.pointee.sa_family
                    if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

    //                     wifi = ["en0"]
    //                     wired = ["en2", "en3", "en4"]
    //                     cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]

                        let name: String = String(cString: (interface.ifa_name))
                        if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
                            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                            getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                            address = String(cString: hostname)
                        }
                    }
                }
                freeifaddrs(ifaddr)
            }
            return address ?? ""
        }
    
    // MARK: - Device Functions
    @objc static func GetDeviceLanguage()->String
    {
         let data = UserDefaults.standard.object(forKey: "Languages") as! NSArray
        return data[0] as! String
    }
    @objc static func GetAuthorization()->String
      {
           let data = UserDefaults.standard.object(forKey: "Authorized") as! NSArray
          return data[0] as! String
      }
    
    static func detectLanguage<T: StringProtocol>(for text: T) -> String? {
        let tagger = NSLinguisticTagger.init(tagSchemes: [.language], options: 0)
        tagger.string = String(text)
        
        if(text != ""){
            guard let languageCode = tagger.tag(at: 0, scheme: .language, tokenRange: nil, sentenceRange: nil) else { return nil }
            return Locale.current.localizedString(forIdentifier: languageCode.rawValue)
        }
        else{
            return "UnAvialable"
        }
    }
        // MARK: - Font Size Functions
    @objc static func GetCustomTitleSemiBoldBodyFont(EngFontNumber:CGFloat,ArFontNumber:CGFloat)->UIFont
       {
           if(SwiftFunctions.GetDeviceLanguage()=="en")
           {
               return  UIFont(name: "OpenSans-Semibold", size: EngFontNumber)!
           }
           else
           {
               return UIFont(name:  "Neo Sans Arabic", size: ArFontNumber)!
           }
           
       }
    
    @objc static func GetCustomTitleBoldBodyFont(EngFontNumber:CGFloat,ArFontNumber:CGFloat)->UIFont
        {
            if(SwiftFunctions.GetDeviceLanguage()=="en")
            {
                return  UIFont(name: "OpenSans-Bold", size: EngFontNumber)!
            }
            else
            {
                return UIFont(name:  "Neo Sans Arabic", size: ArFontNumber)!
            }
            
        }

    @objc static func GetCustomItalicBodyFont(EngFontNumber:CGFloat,ArFontNumber:CGFloat)->UIFont
        {
            if(SwiftFunctions.GetDeviceLanguage()=="en")
            {
                return  UIFont(name: "OpenSans-Italic", size: EngFontNumber)!
            }
            else
            {
                return UIFont(name:  "Neo Sans Arabic", size: ArFontNumber)!
            }
            
        }
     @objc static func GetTitleFont()->UIFont
     {
        if(SwiftFunctions.GetDeviceLanguage()=="en")
        {
            return UIFont(name: "Open Sans", size: 17)!
        }
        else
        {
            return UIFont(name: "Alarabiya Font", size: 22)!
        }
        
    }
    
    @objc static func GetBodyFont()->UIFont
    {
        if(SwiftFunctions.GetDeviceLanguage()=="en")
        {
            return  UIFont(name: "Open Sans", size: 17)!
        }
        else
        {
             return UIFont(name:  "Neo Sans Arabic", size: 14)!
        }
        
    }
    
    @objc static func GetCustomBodyFont(EngFontNumber:CGFloat,ArFontNumber:CGFloat)->UIFont
    {
        if(SwiftFunctions.GetDeviceLanguage()=="en")
        {
            return  UIFont(name: "Open Sans", size: EngFontNumber)!
        }
        else
        {
            return UIFont(name:  "Neo Sans Arabic", size: ArFontNumber)!
        }
        
    }
    
    @objc static func GetCustomTitleFont(EngFontNumber:CGFloat,ArFontNumber:CGFloat)->UIFont
    {
        if(SwiftFunctions.GetDeviceLanguage()=="en")
        {
            return UIFont(name: "Open Sans", size: EngFontNumber)!
        }
        else
        {
            return UIFont(name: "Alarabiya Font", size: ArFontNumber)!
        }
        
    }
    
//   @objc static  func estimatedHeightOfLabel(text: String,view: UIView) -> CGFloat {
//
//        let size = CGSize(width: view.frame.width - 16, height: 1000)
//
//        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
//
//        let attributes = [NSAttributedString.Key.font:UIFont(name: "Helvetica Neue", size: 15)]
//
//        let rectangleHeight = String(text).boundingRect(with: size, options: options, attributes: attributes, context: nil).height
//
//        return rectangleHeight
//    }
        // MARK: - Label Functions
     @objc static func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        //        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    

    
    // MARK: - Api Functions
    @objc  static func WSstartProcess(completionHandler: @escaping (Bool) -> Void) {
        
        
        
        
        let urlPathString: String = "https://otsservices.me/smservices/reg.svc/ses"
        let url = URL(string: urlPathString)!
        var request = URLRequest(url: url)
        
        let number=ObjectiveCFunctions.dateToSecondConvert()
        UserDefaults.standard.set(number.stringValue, forKey: "SecurityNumber")
        UserDefaults.standard.synchronize()
        
        request.setValue(number.stringValue, forHTTPHeaderField: "rt")
        request.setValue(ObjectiveCFunctions.getDeviceID(), forHTTPHeaderField: "did")
        
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                DispatchQueue.main.async {
                    completionHandler(false)
                }
                return
            }
            
            
            if let data = data {
                //                let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                
                DispatchQueue.main.async {
                    WSgetToken(completionHandler: { (result) in
                        
                        completionHandler(result)
                    })
                    
                }
            }
            
            
        }
        task.resume()
    }
    
    @objc static  func WSgetToken(completionHandler: @escaping (Bool) -> Void) {
        
        let urlPathString: String = "https://otsservices.me/smservices/reg.svc/reg"
        let url = URL(string: urlPathString)!
        var request = URLRequest(url: url)
        var number=ObjectiveCFunctions.dateToSecondConvert()
        request.setValue(SwiftFunctions.GetSecurityNumberFromUserDefaults(), forHTTPHeaderField: "rt")
        request.setValue(ObjectiveCFunctions.getDeviceID(), forHTTPHeaderField: "did")
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                DispatchQueue.main.async {
                    completionHandler(false)
                }
                return
            }
            
            
            if let data = data {
                do {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        
                        
                        if((convertedJsonIntoDict.object(forKey: "Tok")) != nil)
                        {
                            let AllDeptResp = convertedJsonIntoDict.object(forKey: "Tok") as! NSArray
                            if(AllDeptResp.count > 0)
                            {
                                print(AllDeptResp)
                                SwiftFunctions.SaveTokensToUserDefaults(TokensArray: AllDeptResp)
                                completionHandler(true)
                            }
                            else
                            {completionHandler(false)}
                        }
                        
                        DispatchQueue.main.async {
                            // completionHandler(data as! Bool)
                        }
                    }
                    
                    
                    
                }catch let error as NSError {
                    DispatchQueue.main.async {
                        //  completionHandler(Result.failure(error as NSError))
                        
                    }
                }
                
                
            }
            else
            {completionHandler(false)}
        }
        task.resume()
    }
    
    // MARK: -  Token Functions and UserDefaults
    
    @objc static func SaveTokensToUserDefaults(TokensArray:NSArray)
    {
//        AppDelegate.sharedDelegate().TokenArray = TokensArray.mutableCopy() as! NSMutableArray
        if(TokensArray.count != 0)
        {
            UserDefaults.standard.set(TokensArray, forKey: "Tokens")
            UserDefaults.standard.synchronize()
        }
    }
    
    @objc static func GetTokensFromUserDefaults() -> NSMutableArray
    {
        let TokenDefaults = (UserDefaults.standard.array(forKey: "Tokens"))
        
        //        if let PickedArray :NSArray = (UserDefaults.standard.array(forKey: "Tokens")! as NSArray) {
        //            print(PickedArray)
        //            return PickedArray.mutableCopy() as! NSMutableArray
        //        }
        if ( TokenDefaults != nil )
        {
            let  PickedArray :NSArray = Array(UserDefaults.standard.array(forKey: "Tokens")!) as NSArray
            return PickedArray.mutableCopy() as! NSMutableArray
        }
        
        return NSMutableArray()
    }
    
    @objc static func GetSecurityNumberFromUserDefaults() -> String
    {
        if let SecurityNumber = UserDefaults.standard.string(forKey: "SecurityNumber") {
            print(SecurityNumber)
            return SecurityNumber as String
        }
        
        return ""
    }
    
    
    @objc static func CheckForDuplicates(HasDuplicatesArray:NSMutableArray)->NSMutableArray
    {
        var dic1 = ["project_code":1, "lob": "lob_1"] as [String : Any]
        var dic2 = ["project_code":1, "lob": "lob_2"] as [String : Any]
        var dic3 = ["project_code":2, "lob": "lob_1"] as [String : Any]
        var dic4 = ["project_code":3, "lob": "lob_1"] as [String : Any]

        var hasDuplicates = NSArray(objects: dic1,dic2,dic3,dic4)

        var duplicates    = NSMutableArray()
        var noDuplicates  = NSMutableArray()

        var dics = NSMutableDictionary()
        
        for dics in hasDuplicates{

            
            
            if noDuplicates.contains(dics){

                if !duplicates.contains(dics){
                    duplicates.add(dics)
                }
            }
            else{
                noDuplicates.add(dics)
            }
        }

        print(duplicates)
        print(noDuplicates)
        
        


//        var duplicates    = NSMutableArray()
//        var noDuplicates  = NSMutableArray()
//
//        for dics in HasDuplicatesArray{
//
//            if noDuplicates.contains(dics){
//
//                if !duplicates.contains(dics){
//                    duplicates.add(dics)
//                }
//            }
//            else{
//                noDuplicates.add(dics)
//            }
//        }
//
//        print(duplicates)
//        print(noDuplicates)
        
        return noDuplicates
    }
}
