//
//  Login.swift
//  CardsDelivery
//
//  Created by IOS Developer 3 on 1/18/19.
//  Copyright © 2019 Softech. All rights reserved.
//

import UIKit
import SVProgressHUD
//var transitionController: TabBarTransitions!


class Login: UIViewController,UITextFieldDelegate,UIScrollViewDelegate {
    
    @IBOutlet var emailsdsds: UIImageView!
    @IBOutlet var ViewContainer:UIView!
    @IBOutlet var EmailView : UIView!
    @IBOutlet var EmailImageView : UIImageView!
    @IBOutlet var PasswordView : UIView!
    @IBOutlet var PasswordImageView : UIImageView!
    @IBOutlet var ForgottenPasswordButton : UIButton!
    @IBOutlet var scrollView:UIScrollView!
    @IBOutlet var IconeImageView:UIImageView!
    @IBOutlet var emailTextField:UITextField!
    @IBOutlet var passwordTextField:UITextField!
    @IBOutlet var loginBtn:UIButton!
    @IBOutlet weak var RememberMeButton: UIButton!
    @IBOutlet weak var switchDemo: UISwitch!
    
    @IBOutlet weak var WelcomBackLabel: UILabel!
    @IBOutlet weak var LogInTocontinue: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    //     @IBOutlet var
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.WelcomBackLabel.font = SwiftFunctions.GetCustomTitleSemiBoldBodyFont(EngFontNumber: 23, ArFontNumber: 32)
        self.LogInTocontinue.font = SwiftFunctions.GetCustomBodyFont(EngFontNumber: 13, ArFontNumber: 16)
        
        emailTextField.attributedPlaceholder = NSAttributedString(string:"Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 165.0/255.0, green: 177/255.0, blue: 196/255.0, alpha: 1)])
        passwordTextField.attributedPlaceholder = NSAttributedString(string:"Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 165.0/255.0, green: 177/255.0, blue: 196/255.0, alpha: 1)])
        passwordTextField.isSecureTextEntry = true
        
        switchDemo.transform = CGAffineTransform(scaleX: 0.60, y: 0.60)
        
        //        let TokensArray : NSMutableArray = SwiftFunctions.GetTokensFromUserDefaults() as! NSMutableArray
        //
        //        if(TokensArray.count < 10)
        //        {
        //            DispatchQueue.global(qos: .background).async {
        //                // Background Thread
        //                DispatchQueue.main.async {
        //                    // Run UI Updates or call completion block
        //                    SVProgressHUD.show()
        //                }
        //            }
        //
        //            SwiftFunctions.WSstartProcess(completionHandler: { result in
        //
        //                DispatchQueue.global(qos: .background).async {
        //                    // Background Thread
        //                    DispatchQueue.main.async {
        //                        // Run UI Updates or call completion block
        //                        SVProgressHUD.dismiss()
        //                    }
        //                }
        //            })
        //        }
        
        //        self.emailTextField.delegate=self
        //        self.passwordTextField.delegate=self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.CloseKeyboard(_:)))
        scrollView.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(Login.keyboardWillShow), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Login.keyboardWillHide), name: UIWindow.keyboardWillHideNotification, object: nil)
        
        //        self.loginBtn.backgroundColor=UIColor(displayP3Red: 166.0/255.0, green: 26.0/255.0, blue: 26.0/255.0, alpha: 1)
        //        self.navigationController?.navigationBar.barTintColor=UIColor(displayP3Red: 166.0/255.0, green: 26.0/255.0, blue: 26.0/255.0, alpha: 1)
        //        UINavigationBar.appearance().backgroundColor =UIColor(white)
        
        //        self.DrawUnderlineOftextFields(DrawView: EmailView)
        
        //        self.DrawUnderlineOftextFields(DrawView: PasswordView)
        
        self.EmailView.layer.cornerRadius = 25
        self.PasswordView.layer.cornerRadius = 25
        
        self.loginBtn.layer.cornerRadius = 25.0
        
        self.emailTextField.text = UserDefaults.standard.string(forKey: "UserName") ?? ""
        
        self.passwordTextField.text = UserDefaults.standard.string(forKey: "UserPass") ?? ""
        if((UserDefaults.standard.string(forKey: "UserPass") ?? "") != "")
        {
            //            self.RememberMeButton.isSelected = true
            self.switchDemo.isOn = true
        }
        else{
            self.switchDemo.isOn = false
        }
        
        print( self.passwordTextField.text as? String ?? "")
        
        
        
        
    }
    
    // MARK: - Gesture Functions
    
    @objc func CloseKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // MARK: - ButtonPressed Functions
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if( passwordTextField.text?.isEmpty == false  && emailTextField.text?.isEmpty==false)
        {
            
            self.WSLogin()
            
        } else {
            print("textField is empty")
        }
        //        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        //
        //        let viewC:HomePageViewController = ((storyBoard.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController))
        //
        //        viewC.modalPresentationStyle = .fullScreen
        //        self.present(viewC, animated: true, completion: nil)
    }
    
    @IBAction func BackButton(_ sender: Any) {
        SVProgressHUD.dismiss()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func RememberMeButtonPressed(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if(sender.isSelected == false)
        {
            UserDefaults.standard.set("", forKey: "UserPass")
            self.passwordTextField.text = ""
        }
    }
    @IBAction func RemeberSwitch(_ sender: Any) {
        
        //        switchDemo.isSelected = !switchDemo.isSelected
        
        if(switchDemo.isOn  == false)
        {
            UserDefaults.standard.set("", forKey: "UserPass")
            self.passwordTextField.text = ""
        }
    }
    
    // MARK: - Api Functions
    
    
    
    
    //     @objc func WSLogin()
    //    {
    //            DispatchQueue.global(qos: .background).async {
    //                // Background Thread
    //                DispatchQueue.main.async {
    //                    // Run UI Updates or call completion block
    //                    SVProgressHUD.show()
    //                }
    //            }
    //
    //
    //            let TokensArray : NSMutableArray = SwiftFunctions.GetTokensFromUserDefaults() as! NSMutableArray
    //
    //            if(TokensArray.count != 0)
    //            {
    //                var IP : String = ""
    //                //            do{
    //                //                let IPs = try String(contentsOf: NSURL(string: "https://icanhazip.com/")! as URL , encoding: String.Encoding.utf8)
    //                //                let trimmedString = IPs.trimmingCharacters(in: .whitespacesAndNewlines)
    //                //                IP=trimmedString
    //                //                print(IP)
    //                //            }
    //                //            catch let error as NSError {
    //                //                print(error)
    //                //
    //                //            }
    //
    //                let TokenDictionary :NSDictionary = TokensArray.lastObject as! NSDictionary
    //                TokensArray.removeLastObject()
    //                SwiftFunctions.SaveTokensToUserDefaults(TokensArray: TokensArray)
    //
    //                let Key = "\(ObjectiveCFunctions.getDeviceID())\(SwiftFunctions.GetSecurityNumberFromUserDefaults())"
    //                let OPrivateKey = ObjectiveCFunctions.decodeKeys(TokenDictionary.object(forKey: "OPrivateKey") as! String, Key)
    //                let OPublicKey = ObjectiveCFunctions.decodeKeys(TokenDictionary.object(forKey: "OPublicKey") as! String, Key)
    //                let PrivateKey = ObjectiveCFunctions.decodeKeys(TokenDictionary.object(forKey: "PrivateKey") as! String, Key)
    //                let PublicKey = ObjectiveCFunctions.decodeKeys(TokenDictionary.object(forKey: "PublicKey") as! String, Key)
    //                let nonce = ObjectiveCFunctions.generateNonce()
    //
    //
    //                let Url = String(format: "https://otsservices.me/Deliverservice/mawcf.svc/Authenticate")
    //                guard let serviceUrl = URL(string: Url) else { return }
    //
    //                //            let Keys = NSArray(array: ["APPID","Name","Password"])
    //                //
    //                //            let Objects = NSArray(array: [ObjectiveCFunctions.encryptData(PublicKey, PrivateKey, "10", nonce),ObjectiveCFunctions.encryptData(PublicKey, PrivateKey, self.emailTextField.text!, nonce),ObjectiveCFunctions.encryptData(PublicKey, PrivateKey, ObjectiveCFunctions.sha1(self.passwordTextField.text!), nonce)])
    //
    //
    //                let parameterDictionary : NSDictionary =
    //                    [
    //                        //                    "APPID":ObjectiveCFunctions.encryptData(PublicKey, PrivateKey, "10", nonce),
    //                        //                    "Name":ObjectiveCFunctions.encryptData(PublicKey, PrivateKey, self.emailTextField.text ?? "", nonce),
    //                        //                    "Password":ObjectiveCFunctions.encryptData(PublicKey, PrivateKey, ObjectiveCFunctions.sha1(self.passwordTextField.text ?? ""), nonce),
    //
    //                        "AutoID":"",
    //                        "Count":0,
    //                        "Criterias":"",
    //                        "Service_Flag": "AUTHENTICATE",
    //                        "Exception":"",
    //                        "Permission":"",
    //                        "Result":"",
    //                        "Status":"",
    //                        "TimeElapsed":"",
    //                        "isProxy":""
    //                ]
    //
    //                let jsonData = try! JSONSerialization.data(withJSONObject: parameterDictionary, options: [])
    //                let parameterDictionaryString = String(data: jsonData, encoding: .utf8)!
    //                let EncryptedJson = ObjectiveCFunctions.encryptData(PublicKey, PrivateKey, parameterDictionaryString, nonce)
    //                let mainDictionary : [String : String] = ["Msg" : EncryptedJson ]
    //
    //
    //                //            if(Keys.count==Objects.count)
    //                //            {
    //                //                let parameterDictionary = NSDictionary(objects: Objects as! [Any], forKeys: Keys as! [NSCopying] )
    //
    //
    //                var request = URLRequest(url: serviceUrl)
    //                request.httpMethod = "POST"
    //                request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
    //                request.setValue("\(TokenDictionary.object(forKey: "Tok")!)", forHTTPHeaderField: "key")
    //                request.setValue(ObjectiveCFunctions.getDeviceID(), forHTTPHeaderField: "did")
    //                request.setValue(ObjectiveCFunctions.convertNonce(toString: nonce), forHTTPHeaderField: "nonce")
    //                request.setValue("\(TokenDictionary.object(forKey: "Tok")!)", forHTTPHeaderField: "Token")
    //                request.setValue("EN", forHTTPHeaderField: "LANG")
    //                request.setValue(ObjectiveCFunctions.encryptData(PublicKey, PrivateKey, self.emailTextField.text ?? "", nonce), forHTTPHeaderField: "USER")
    //                request.setValue("\(ObjectiveCFunctions.dateToSecondConvert())", forHTTPHeaderField: "CDT")
    //                request.setValue(ObjectiveCFunctions.encryptData(PublicKey, PrivateKey, ObjectiveCFunctions.sha1(self.passwordTextField.text ?? ""), nonce), forHTTPHeaderField: "PASSWORD")
    //                request.setValue("IOS", forHTTPHeaderField: "DEVICE")
    //                request.setValue("IPHONE", forHTTPHeaderField: "BROWSER")
    //                request.setValue("MOBILE", forHTTPHeaderField: "DEVICE_TYPE")
    //                request.setValue(ObjectiveCFunctions.encryptData(PublicKey, PrivateKey, "\(IP)", nonce), forHTTPHeaderField: "IP")
    //                request.setValue("AIzaSyAvobF41VHh8b9p75bwJm6ncI_E9j99Rs8", forHTTPHeaderField: "APIKey")
    //
    //
    //
    //
    //                guard let httpBody = try? JSONSerialization.data(withJSONObject: mainDictionary, options: []) else {
    //                    return
    //                }
    //
    //                //            guard let httpBody = try? JSONSerialization.jsonObject(with: mainDictionary, options: []) else {
    //                //                return
    //                //            }
    //                request.httpBody = httpBody
    //
    //                let session = URLSession.shared
    //                session.dataTask(with: request) { (data, response, error) in
    //                    if let response = response {
    //                        print(response)
    //                    }
    //                    if let data = data {
    //                        do {
    //                            let avatar = NSString(data: data, encoding: String.Encoding.utf8.rawValue);
    //
    //                            let json:NSDictionary = try (JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary)!
    //                            //                            let json = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
    //                            print("AUTHENTICATE %@",json)
    //
    //
    //                            if ((json.object(forKey: "Msg")) != nil)
    //                            {
    //                                let httpResponse = response as? HTTPURLResponse
    //                                let nonceHeader = httpResponse?.allHeaderFields["nonce"] as? String
    //                                //                                let nounceData = Data()
    //                                //                                let nounceString = Data(nonceHeader!.utf8).base64EncodedString()
    //                                let nounceData = Data(base64Encoded: nonceHeader!)
    //                                let TokenHeader = httpResponse?.allHeaderFields["key"] as? String
    //
    //                                let TokensArrayForDecreption : NSMutableArray = SwiftFunctions.GetTokensFromUserDefaults() as! NSMutableArray
    //                                //                            let TempArray=TokensArrayForDecreption
    //                                if(TokensArrayForDecreption.count != 0)
    //                                {
    //                                    var TokenFound = false
    //                                    for i in 0..<TokensArrayForDecreption.count
    //                                    {
    //                                        if(i<TokensArrayForDecreption.count)
    //                                        {
    //                                            let TokenDictionary :NSDictionary = TokensArrayForDecreption[i] as! NSDictionary
    //                                            let TokenFromDIc = "\(TokenDictionary.object(forKey: "Tok") as? Int ?? 0)"
    //                                            if(TokenFromDIc == TokenHeader)
    //                                            {
    //                                                TokenFound = true
    //                                                TokensArrayForDecreption.removeObject(at: i)
    //                                                SwiftFunctions.SaveTokensToUserDefaults(TokensArray: TokensArrayForDecreption)
    //
    //                                                let DecryptedJson = ObjectiveCFunctions.decreptData(ObjectiveCFunctions.decodeKeys(TokenDictionary.object(forKey: "OPublicKey") as! String, Key), ObjectiveCFunctions.decodeKeys(TokenDictionary.object(forKey: "OPrivateKey") as! String, Key), json.object(forKey: "Msg") as? String ?? "", nounceData ?? Data())
    //                                                print("AUTHENTICATE %@",DecryptedJson)
    //
    //                                                //                                        var jsonString = dictionary.object(forKey: "Result") as? String ?? ""
    //                                                //
    //                                                do{
    //                                                    if let json = DecryptedJson.data(using: String.Encoding.utf8){
    //                                                        if let jsonDataDictionary = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? NSDictionary{
    //
    //                                                            if (jsonDataDictionary.count != 0)
    //                                                            {
    //                                                                var ResultString = jsonDataDictionary.object(forKey: "Result") as? String ?? ""
    //                                                                do{
    //                                                                    if let jsonResult = ResultString.data(using: String.Encoding.utf8){
    //                                                                        if let jsonResultDictionary = try JSONSerialization.jsonObject(with: jsonResult, options: .allowFragments) as? NSDictionary{
    //
    //                                                                            if (jsonResultDictionary.count != 0)
    //                                                                            {
    //                                                                                if((jsonResultDictionary.object(forKey: "Error_ID") as? String) != "2")
    //                                                                                {
    //                                                                                    DispatchQueue.global(qos: .background).async {
    //                                                                                        // Background Thread
    //                                                                                        DispatchQueue.main.async {
    //
    //                                                                                            //                                                                                        UserDefaults.standard.set(true, forKey: "isSysAdmin") //Bool
    //                                                                                            UserDefaults.standard.set(self.emailTextField.text, forKey: "UserName") //UserName
    //                                                                                            //                                                                                        UserDefaults.standard.set(true, forKey: "UpdateWall")
    //                                                                                            UserDefaults.standard.set((jsonResultDictionary.object(forKey: "APIKey") as? String ?? ""), forKey: "APIKey")
    //                                                                                            UserDefaults.standard.synchronize()
    //
    //                                                                                            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    //
    //                                                                                            let viewC:HomePageViewController = ((storyBoard.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController))
    //
    //                                                                                            viewC.modalPresentationStyle = .fullScreen
    //                                                                                            self.present(viewC, animated: true, completion: nil)
    //
    //
    //
    //                                                                                        }
    //                                                                                    }
    //
    //                                                                                }
    //                                                                                else{
    //                                                                                    self.AlertShow(MessageToShow: "Login UnSuccessful")
    //                                                                                }
    //
    //
    //                                                                            }
    //                                                                        }
    //                                                                    }
    //                                                                }catch {
    //                                                                    print(error.localizedDescription)
    //                                                                }
    //                                                                //
    //
    //
    //                                                            }
    //                                                        }
    //                                                    }
    //                                                }catch {
    //                                                    print(error.localizedDescription)
    //                                                }
    //
    //                                            }
    //                                        }
    //                                    }
    //
    //                                    if(TokenFound==false)
    //                                    {
    //                                        SwiftFunctions.WSstartProcess(completionHandler: { result in
    //
    //                                            if(result==true)
    //                                            {
    //                                                DispatchQueue.global(qos: .background).async {
    //                                                    // Background Thread
    //                                                    DispatchQueue.main.async {
    //                                                        // Run UI Updates or call completion block
    //                                                        SVProgressHUD.dismiss()
    //                                                        self.WSLogin()
    //                                                    }
    //                                                }
    //
    //                                            }
    //                                        })
    //                                    }
    //                                }
    //
    //                            }
    //                            else
    //                            {
    //                                self.AlertShow(MessageToShow: "Login UnSuccessful")
    //                            }
    //
    //                        } catch {
    //                            print(error)
    //                            self.AlertShow(MessageToShow: "Login UnSuccessful")
    //                        }
    //
    //
    //                    }
    //
    //                    DispatchQueue.global(qos: .background).async {
    //                        // Background Thread
    //                        DispatchQueue.main.async {
    //                            // Run UI Updates or call completion block
    //                            SVProgressHUD.dismiss()
    //                        }
    //                    }
    //                }.resume()
    //                //            }
    //            }
    //            else
    //            {
    //
    //                SwiftFunctions.WSstartProcess(completionHandler: { result in
    //
    //                    if(result==true)
    //                    {
    //                        DispatchQueue.global(qos: .background).async {
    //                            // Background Thread
    //                            DispatchQueue.main.async {
    //                                // Run UI Updates or call completion block
    //                                SVProgressHUD.dismiss()
    //                                self.WSLogin()
    //                            }
    //                        }
    //
    //                    }
    //                })
    //            }
    //        }
    @objc func WSLogin()
    {
        DispatchQueue.global(qos: .background).async {
            // Background Thread
            DispatchQueue.main.async {
                // Run UI Updates or call completion block
                SVProgressHUD.show()
            }
        }
        
        //
        //        let TokensArray : NSMutableArray = SwiftFunctions.GetTokensFromUserDefaults() as! NSMutableArray
        //
        //        if(TokensArray.count != 0)
        //        {
        var IP : String = ""
        guard let wifiIp = SwiftFunctions.getWiFiAddress() else {
            
            DispatchQueue.global(qos: .background).async {
                // Background Thread
                DispatchQueue.main.async {
                    // Run UI Updates or call completion block
                    SVProgressHUD.dismiss()
                    self.AlertShow(MessageToShow: "Internet Unavailable")
                }
            }
            
            
            
            return
            
        }
        IP = wifiIp
        
        
        //            let TokenDictionary :NSDictionary = TokensArray.lastObject as! NSDictionary
        //            TokensArray.removeLastObject()
        //            SwiftFunctions.SaveTokensToUserDefaults(TokensArray: TokensArray)
        //            
        //            let Key = "\(ObjectiveCFunctions.getDeviceID())\(SwiftFunctions.GetSecurityNumberFromUserDefaults())"
        //            let OPrivateKey = ObjectiveCFunctions.decodeKeys(TokenDictionary.object(forKey: "OPrivateKey") as! String, Key)
        //            let OPublicKey = ObjectiveCFunctions.decodeKeys(TokenDictionary.object(forKey: "OPublicKey") as! String, Key)
        //            let PrivateKey = ObjectiveCFunctions.decodeKeys(TokenDictionary.object(forKey: "PrivateKey") as! String, Key)
        //            let PublicKey = ObjectiveCFunctions.decodeKeys(TokenDictionary.object(forKey: "PublicKey") as! String, Key)
        //            let nonce = ObjectiveCFunctions.generateNonce()
        
        //"http://www.peeeeopleofarabia.com/RestPeople/MA/MAWcf.svc/Authenticate")
        //            let Url = String(format: "https://otsservices.me/Deliverservice/mawcf.svc/Authenticate")
        let Url = String(format: "https://m.peoplemon.com/MA/MAWcf.svc/Authenticate")
//        let Url = String(format: "https://m.peoplemon.com/MaWcf.svc/Authenticate")
        guard let serviceUrl = URL(string: Url) else { return }
        
        //            let Keys = NSArray(array: ["APPID","Name","Password"])
        //
        //            let Objects = NSArray(array: [ObjectiveCFunctions.encryptData(PublicKey, PrivateKey, "10", nonce),ObjectiveCFunctions.encryptData(PublicKey, PrivateKey, self.emailTextField.text!, nonce),ObjectiveCFunctions.encryptData(PublicKey, PrivateKey, ObjectiveCFunctions.sha1(self.passwordTextField.text!), nonce)])
        
        
        let parameterDictionary : NSDictionary =
            [
                
                
                //                    "AutoID":"",
                //                    "Count":0,
                //                    "Criterias":"",
                //                    "Service_Flag": "AUTHENTICATE",
                //                    "Exception":"",
                //                    "Permission":"",
                //                    "Result":"",
                //                    "Status":"",
                //                    "TimeElapsed":"",
                //                    "isProxy":""
                
                "Service_Flag":"AUTHENTICATE"
        ]
        
        //            let jsonData = try! JSONSerialization.data(withJSONObject: parameterDictionary, options: [])
        //            let parameterDictionaryString = String(data: jsonData, encoding: .utf8)!
        //            let EncryptedJson = ObjectiveCFunctions.encryptData(PublicKey, PrivateKey, parameterDictionaryString, nonce)
        //            let mainDictionary : [String : String] = ["Msg" : EncryptedJson ]
        
        
        //            if(Keys.count==Objects.count)
        //            {
        //                let parameterDictionary = NSDictionary(objects: Objects as! [Any], forKeys: Keys as! [NSCopying] )
        
        
        //            var request = URLRequest(url: serviceUrl)
        //            request.httpMethod = "POST"
        //            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        //            request.setValue("\(TokenDictionary.object(forKey: "Tok")!)", forHTTPHeaderField: "key")
        //            request.setValue(ObjectiveCFunctions.getDeviceID(), forHTTPHeaderField: "did")
        //            request.setValue(ObjectiveCFunctions.convertNonce(toString: nonce), forHTTPHeaderField: "nonce")
        //            request.setValue("\(TokenDictionary.object(forKey: "Tok")!)", forHTTPHeaderField: "Token")
        //            request.setValue("EN", forHTTPHeaderField: "LANG")
        //            request.setValue(ObjectiveCFunctions.encryptData(PublicKey, PrivateKey, self.emailTextField.text ?? "", nonce), forHTTPHeaderField: "USER")
        //            request.setValue("\(ObjectiveCFunctions.dateToSecondConvert())", forHTTPHeaderField: "CDT")
        //            request.setValue(ObjectiveCFunctions.encryptData(PublicKey, PrivateKey, ObjectiveCFunctions.sha1(self.passwordTextField.text ?? ""), nonce), forHTTPHeaderField: "PASSWORD")
        //            request.setValue("IOS", forHTTPHeaderField: "DEVICE")
        //            request.setValue("IPHONE", forHTTPHeaderField: "BROWSER")
        //            request.setValue("MOBILE", forHTTPHeaderField: "DEVICE_TYPE")
        //            request.setValue(ObjectiveCFunctions.encryptData(PublicKey, PrivateKey, "\(IP)", nonce), forHTTPHeaderField: "IP")
        //            request.setValue("AIzaSyAvobF41VHh8b9p75bwJm6ncI_E9j99Rs8", forHTTPHeaderField: "APIKey")
        
        //            var request = URLRequest(url: serviceUrl)
        //            request.httpMethod = "POST"
        //            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        //            request.setValue("AIzaSyAvobF41VHh8b9p75bwJm6ncI_E9j99Rs8", forHTTPHeaderField: "APIKey")
        //            if(SwiftFunctions.GetDeviceLanguage() == "en" ){
        //                request.setValue("EN", forHTTPHeaderField: "LANG")
        //            }
        //            else{
        //                request.setValue("AR", forHTTPHeaderField: "LANG")
        //            }
        //            request.setValue("PostManDemo", forHTTPHeaderField: "USER")
        //            request.setValue("\(ObjectiveCFunctions.dateToSecondConvert())", forHTTPHeaderField: "CDT")
        //            request.setValue("IOS", forHTTPHeaderField: "DEVICE")
        //            request.setValue("IPHONE", forHTTPHeaderField: "BROWSER")
        //            request.setValue("MOBILE", forHTTPHeaderField: "DEVICE_TYPE")
        //            request.setValue("\(IP)", forHTTPHeaderField: "IP")
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("EN", forHTTPHeaderField: "LANG")
        request.setValue(self.emailTextField.text ?? "", forHTTPHeaderField: "USER")
        request.setValue("\(ObjectiveCFunctions.dateToSecondConvert())", forHTTPHeaderField: "CDT")
        request.setValue(ObjectiveCFunctions.sha1(self.passwordTextField.text ?? ""), forHTTPHeaderField: "PASSWORD")
        request.setValue("IOS", forHTTPHeaderField: "DEVICE")
        request.setValue("IPHONE", forHTTPHeaderField: "BROWSER")
        request.setValue("MOBILE", forHTTPHeaderField: "DEVICE_TYPE")
        request.setValue("\(IP)", forHTTPHeaderField: "IP")
        request.setValue("AIzaSyAvobF41VHh8b9p75bwJm6ncI_E9j99Rs8", forHTTPHeaderField: "APIKey")
        request.setValue("200", forHTTPHeaderField: "APP_ID")
        request.setValue(ObjectiveCFunctions.getDeviceID(), forHTTPHeaderField: "DEVICE_ID")
        request.setValue(UserDefaults.standard.string(forKey: "NotificationToken") ?? "", forHTTPHeaderField: "TOKEN_ID")
        //            print(UserDefaults.standard.string(forKey: "NotificationToken") as? String ?? "")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        
        //            guard let httpBody = try? JSONSerialization.jsonObject(with: mainDictionary, options: []) else {
        //                return
        //            }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let avatar = NSString(data: data, encoding: String.Encoding.utf8.rawValue);
                    
                    let dictionary:NSDictionary = try (JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary)!
                    //                            let json = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                    print("AUTHENTICATE %@",dictionary)
                    
                    
                    if (dictionary.count != 0)
                    {
                        if ((dictionary.object(forKey: "Result") is NSNull) == false)
                        {
                            //
                            var jsonString = dictionary.object(forKey: "Result") as? String ?? ""
                            //
                            do{
                                if let json = jsonString.data(using: String.Encoding.utf8){
                                    if let jsonDataDictionary = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? NSDictionary{
                                        
                                        if (jsonDataDictionary.count != 0)
                                        {
                                            if((dictionary.object(forKey: "Service_Flag") as? String) == "LOGIN_SUCCESS")
                                            {
                                                
                                                
                                                DispatchQueue.global(qos: .background).async {
                                                    // Background Thread
                                                    DispatchQueue.main.async {
                                                        
                                                        if(self.switchDemo.isOn)
                                                        {
                                                            UserDefaults.standard.set(self.passwordTextField.text, forKey: "UserPass")
                                                        }
                                                        
                                                        UserDefaults.standard.set(self.emailTextField.text, forKey: "UserName") //UserName
                                                        //                                                                                        UserDefaults.standard.set(true, forKey: "UpdateWall")
                                                        UserDefaults.standard.set((jsonDataDictionary.object(forKey: "APIKey") as? String ?? ""), forKey: "APIKey")
                                                        UserDefaults.standard.set((jsonDataDictionary.object(forKey: "IS_SYSTEM_ADMIN") as? String ?? ""), forKey: "IS_SYSTEM_ADMIN")
                                                        UserDefaults.standard.synchronize()
                                                     
                                                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                        var tableViewController = mainStoryboard.instantiateViewController(withIdentifier: "MyNavigationController") as! UITabBarController
                                                        
//                                                        transitionController = TabBarTransitions(in: tableViewController)
                                                        
//                                                        AppDelegate.sharedDelegate().window?.rootViewController = tableViewController
                                                        
                                                        
                                                        
                                                    }
                                                }
                                                
                                            }
                                            else{
                                                self.AlertShow(MessageToShow: "Login UnSuccessful")
                                            }
                                            
                                        }
                                        else{
                                            DispatchQueue.global(qos: .background).async {
                                                // Background Thread
                                                DispatchQueue.main.async {
                                                    SVProgressHUD.dismiss()
                                                    self.AlertShow(MessageToShow: "Somthing went wrong")
                                                    
                                                }
                                            }
                                        }
                                    }
                                    else{
                                        DispatchQueue.global(qos: .background).async {
                                            // Background Thread
                                            DispatchQueue.main.async {
                                                SVProgressHUD.dismiss()
                                                self.AlertShow(MessageToShow: "Somthing went wrong")
                                                
                                                
                                            }
                                        }
                                    }
                                }
                                
                            }catch {
                                print(error.localizedDescription)
                                self.AlertShow(MessageToShow: "Somthing went wrong")
                                
                                
                            }
                        }
                    }
                        
                    else
                    {
                        self.AlertShow(MessageToShow: "Login UnSuccessful")
                    }
                    
                } catch {
                    print(error)
                    self.AlertShow(MessageToShow: "Login UnSuccessful")
                }
                
                
            }
            
            DispatchQueue.global(qos: .background).async {
                // Background Thread
                DispatchQueue.main.async {
                    // Run UI Updates or call completion block
                    SVProgressHUD.dismiss()
                }
            }
        }.resume()
        //            }
        //        }
        //        else
        //        {
        //
        //            SwiftFunctions.WSstartProcess(completionHandler: { result in
        //
        //                if(result==true)
        //                {
        //                    DispatchQueue.global(qos: .background).async {
        //                        // Background Thread
        //                        DispatchQueue.main.async {
        //                            // Run UI Updates or call completion block
        //                            SVProgressHUD.dismiss()
        //                            self.WSLogin()
        //                        }
        //                    }
        //
        //                }
        //            })
        //        }
    }
    
    
    // MARK: - UITextField Functions
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        //        if(textField==self.emailTextField)
        //        {
        //            if(ObjectiveCFunctions.validateEmail(self.emailTextField.text!))
        //            {
        //
        //            }
        //
        //        }
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //        self.view.endEditing(true)
        return true
    }
    
    // MARK: - Draw Functions
    
    func DrawUnderlineOftextFields(DrawView : UIView)
    {
        DrawView.layer.cornerRadius = 25.0
        DrawView.layer.borderWidth = 1.0
        DrawView.layer.borderColor = UIColor(displayP3Red: 51/255.0, green: 63/255.0, blue: 76/255.0, alpha: 1).cgColor
    }
    
    
    
    // MARK: - KeyBoard Functions
    @objc func keyboardWillShow(notification: Notification) {
        //        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
        //            print("notification: Keyboard will show")
        //            if self.scrollView.frame.origin.y == 0{
        //                self.scrollView.frame.origin.y -= keyboardSize.height/2
        //            }
        //        }
        
        print(scrollView.contentSize.height)
        print(scrollView.bounds.size.height)
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height+50)
        scrollView.setContentOffset(bottomOffset, animated: true)
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        //        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
        //             print("notification: Keyboard will show")
        //            if self.scrollView.frame.origin.y != 0 {
        //                self.scrollView.frame.origin.y += keyboardSize.height/2
        //            }
        //        }
        
        let bottomOffset = CGPoint(x: 0, y: 0)
        scrollView.setContentOffset(bottomOffset, animated: true)
    }
    
    // MARK: - Alert
    
    func AlertShow(MessageToShow : String)
    {
        DispatchQueue.global(qos: .background).async {
            // Background Thread
            DispatchQueue.main.async {
                // Run UI Updates or call completion block
                let alertController = UIAlertController(title: "", message: MessageToShow, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
