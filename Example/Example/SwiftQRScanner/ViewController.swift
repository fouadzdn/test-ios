//
//  ViewController.swift
//  SwiftQRScanner
//
//  Created by vinodiOS on 12/05/2017.
//  Copyright (c) 2017 vinodiOS. All rights reserved.
//

import UIKit
import SwiftQRScanner
import SVProgressHUD
import SDWebImage

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITabBarControllerDelegate {
    
    @IBOutlet weak var ListingTableView: UITableView!
    
    var ListingArray = NSMutableArray()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.topItem?.title="Shayeek"
        self.title = "Events"
        

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self, selector: #selector(ReloadHomePageTable), name: NSNotification.Name(rawValue: "ReloadHomePageTable"), object: nil)
        self.tabBarController?.delegate = self
        
       
        self.ListingTableView.register(UINib(nibName: "HomePageTableViewCell", bundle: .main), forCellReuseIdentifier: "HomePageTableViewCell")
        
        self.WSGetTickets()
        self.FetchListing()
       
    }
    
    @IBAction func scanQRCode(_ sender: Any) {
        
        //QRCode scanner without Camera switch and Torch
        //let scanner = QRCodeScannerController()
        
        //QRCode with Camera switch and Torch
        let scanner = QRCodeScannerController(cameraImage: UIImage(named: "camera"), cancelImage: UIImage(named: "cancel"), flashOnImage: UIImage(named: "flash-on"), flashOffImage: UIImage(named: "flash-off"))
        scanner.delegate = self
        self.present(scanner, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Services Functions
    func FetchListing()
    {
        
        DispatchQueue.global(qos: .background).async {
            // Background Thread
            DispatchQueue.main.async {
                SVProgressHUD.show(withStatus: "Fetching List")
            }
        }
        
     
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
        
        
        let parameterDictionary : NSDictionary = [:]
        
        
        
        
        print("FetchListing %@",parameterDictionary)
        
        
        
        let Url = String(format: "https://www.mypdv.com/Rest/MyPDVSERVWs/Common.svc/Events")
        
        guard let serviceUrl = URL(string: Url) else { return }
        
        
        
        
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        //        request.setValue(UserDefaults.standard.string(forKey: "APIKey"), forHTTPHeaderField: "APIKey")
        //        if(SwiftFunctions.GetDeviceLanguage() == "en" ){
        //            request.setValue("EN", forHTTPHeaderField: "LANG")
        //        }
        //        else{
        //            request.setValue("AR", forHTTPHeaderField: "LANG")
        //        }
        //        request.setValue(UserDefaults.standard.string(forKey: "UserName"), forHTTPHeaderField: "USER")
        //        request.setValue("\(ObjectiveCFunctions.dateToSecondConvert())", forHTTPHeaderField: "CDT")
        //        request.setValue("IOS", forHTTPHeaderField: "DEVICE")
        //        request.setValue("IPHONE", forHTTPHeaderField: "BROWSER")
        //        request.setValue("MOBILE", forHTTPHeaderField: "DEVICE_TYPE")
        //        request.setValue("\(IP)", forHTTPHeaderField: "IP")
        //        request.setValue(ObjectiveCFunctions.getDeviceID(), forHTTPHeaderField: "DEVICE_ID")
        //        request.setValue(UserDefaults.standard.string(forKey: "UserName"), forHTTPHeaderField: "USER_ID")
        //        //        request.setValue("SEARCHMEMBER", forHTTPHeaderField: "FORM_NAME")
        //        //        request.setValue("/MA/MaWcf.svc/Search", forHTTPHeaderField: "REST_SERVICE")
        //        //        request.setValue("0", forHTTPHeaderField: "PROXY")
        //        //        request.setValue("SEARCHMEMBER", forHTTPHeaderField: "FORM_NAME")
        //        //        request.setValue("SEARCHMEMBER", forHTTPHeaderField: "FORM_NAME")
        //        //        request.setValue("100", forHTTPHeaderField: "APP_ID")
        
        
        
        do {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
                return
            }
            
            request.httpBody = httpBody
            
            let session = URLSession.shared
            //            session.configuration.timeoutIntervalForRequest = 1000
            //            session.configuration.timeoutIntervalForResource = 1000
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        
                        let avatar = NSString(data: data, encoding: String.Encoding.utf8.rawValue);
                        
                        var dictionary:NSDictionary = try (JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary)!
                       
                        print("FetchListing %@",dictionary)
                        
                        if (dictionary.count != 0)
                        {
                            
                            if let LsitArr = dictionary.object(forKey: "List") as? NSMutableArray {
                                
                                self.ListingArray = LsitArr as? NSMutableArray ?? NSMutableArray()
                               
                           
                            }
                            
                            DispatchQueue.global(qos: .background).async {
                                // Background Thread
                                DispatchQueue.main.async {
                                    // Run UI Updates or call completion block
                                    
                                    self.ListingTableView.reloadData()
                                    
                                    SVProgressHUD.dismiss()
                                    
                                    
                                }
                            }
                      
                            
                        }
                        else
                        {
                            
                            
                            DispatchQueue.global(qos: .background).async {
                                // Background Thread
                                DispatchQueue.main.async {
                                    // Run UI Updates or call completion block
                                    
                                    SVProgressHUD.dismiss()
                                    self.ListingTableView.reloadData()
//                                    self.AlertShow(MessageToShow: "No more Entries")
                                    
                                }
                            }
                            
                        }
                        
                        
                        
                    } catch {
                        //                            print(error)
                        DispatchQueue.global(qos: .background).async {
                            // Background Thread
                            DispatchQueue.main.async {
                                
                                SVProgressHUD.dismiss()
                                self.AlertShow(MessageToShow: "Could not complete try again")
                                
                            }
                        }
                    }
                    
                    
                }
                else{
                    DispatchQueue.global(qos: .background).async {
                        // Background Thread
                        DispatchQueue.main.async {
                            
                            SVProgressHUD.dismiss()
                            
                            self.AlertShow(MessageToShow: "Could not complete try again")
                            
                            
                        }
                    }
                }
            }.resume()
            //
            //
        } catch {
            DispatchQueue.global(qos: .background).async {
                // Background Thread
                DispatchQueue.main.async {
                    // Run UI Updates or call completion block
                    SVProgressHUD.dismiss()
                    self.AlertShow(MessageToShow: "Could not complete try again")
                    
                }
            }
        }
        
        
        
    }
    
    func WSValidateQRCode(QRContent:String)
    {
        
        DispatchQueue.global(qos: .background).async {
            // Background Thread
            DispatchQueue.main.async {
                SVProgressHUD.show(withStatus: "Validating Ticket")
            }
        }
        
     
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
        
        
        let parameterDictionary : NSDictionary = [
            "UserID":DatabaseCalls.GetDataFromLocal(WordId: "UserName") as? String ?? "",
            "PassCode":QRContent
            
     
    ]
        
        
        
        
        print("WSValidateQRCode %@",parameterDictionary)
        
        
        
        let Url = String(format: "https://www.mypdv.com/Rest/MyPDVSERVWs/Common.svc/ValidateQRCode")
        
        guard let serviceUrl = URL(string: Url) else { return }
        
        
        
        
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        //        request.setValue(UserDefaults.standard.string(forKey: "APIKey"), forHTTPHeaderField: "APIKey")
        //        if(SwiftFunctions.GetDeviceLanguage() == "en" ){
        //            request.setValue("EN", forHTTPHeaderField: "LANG")
        //        }
        //        else{
        //            request.setValue("AR", forHTTPHeaderField: "LANG")
        //        }
        //        request.setValue(UserDefaults.standard.string(forKey: "UserName"), forHTTPHeaderField: "USER")
        //        request.setValue("\(ObjectiveCFunctions.dateToSecondConvert())", forHTTPHeaderField: "CDT")
        //        request.setValue("IOS", forHTTPHeaderField: "DEVICE")
        //        request.setValue("IPHONE", forHTTPHeaderField: "BROWSER")
        //        request.setValue("MOBILE", forHTTPHeaderField: "DEVICE_TYPE")
        //        request.setValue("\(IP)", forHTTPHeaderField: "IP")
        //        request.setValue(ObjectiveCFunctions.getDeviceID(), forHTTPHeaderField: "DEVICE_ID")
        //        request.setValue(UserDefaults.standard.string(forKey: "UserName"), forHTTPHeaderField: "USER_ID")
        //        //        request.setValue("SEARCHMEMBER", forHTTPHeaderField: "FORM_NAME")
        //        //        request.setValue("/MA/MaWcf.svc/Search", forHTTPHeaderField: "REST_SERVICE")
        //        //        request.setValue("0", forHTTPHeaderField: "PROXY")
        //        //        request.setValue("SEARCHMEMBER", forHTTPHeaderField: "FORM_NAME")
        //        //        request.setValue("SEARCHMEMBER", forHTTPHeaderField: "FORM_NAME")
        //        //        request.setValue("100", forHTTPHeaderField: "APP_ID")
        
        
        
        do {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
                return
            }
            
            request.httpBody = httpBody
            
            let session = URLSession.shared
            //            session.configuration.timeoutIntervalForRequest = 1000
            //            session.configuration.timeoutIntervalForResource = 1000
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        
                        let avatar = NSString(data: data, encoding: String.Encoding.utf8.rawValue);
                        
                        var dictionary:NSDictionary = try (JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary)!
                       
                        print("WSValidateQRCode %@",dictionary)
                        
                        if (dictionary.count != 0)
                        {
                            var ErrorDic = dictionary.object(forKey: "Error") as? NSDictionary ?? NSDictionary()
                            var SavedSearchesArray = DatabaseCalls.GetDataFromLocal(WordId: "ScannedQR") as! NSMutableArray

                                var EditedDic = dictionary.mutableCopy() as! NSMutableDictionary
                                EditedDic.setValue("\(NSDate().dateStringWithFormat(format: "yyyy-MM-dd HH:mm:ss"))", forKey: "Date")
                            EditedDic.setValue(ErrorDic.object(forKey: "ErrorDesc"), forKey: "ErrorDesc")
                            

                                SavedSearchesArray.add(EditedDic)
                                
                                DatabaseCalls.SaveDataToLocal(WordId: "ScannedQR", DataArray: SavedSearchesArray)
                            
                            
                           
                                DispatchQueue.global(qos: .background).async {
                                    // Background Thread
                                    DispatchQueue.main.async {
                                        // Run UI Updates or call completion block
                                        
//                                        self.ListingTableView.reloadData()
                                        
                                        SVProgressHUD.dismiss()
                                        var ErrorDic = dictionary.object(forKey: "Error") as? NSDictionary ?? NSDictionary()
                                        self.AlertShow(MessageToShow: ErrorDic.object(forKey: "ErrorDesc") as? String ?? "")
                                        NotificationCenter.default.post(name: Notification.Name("ReloadTable"), object: nil)
                                        
                                        
                                    }
                                }
                            
                            
                            
                      
                            
                        }
                        else
                        {
                            
                            
                            DispatchQueue.global(qos: .background).async {
                                // Background Thread
                                DispatchQueue.main.async {
                                    // Run UI Updates or call completion block
                                    
                                    SVProgressHUD.dismiss()
                                    var ErrorDic = dictionary.object(forKey: "Error") as? NSDictionary ?? NSDictionary()
                                    self.AlertShow(MessageToShow: ErrorDic.object(forKey: "ErrorDesc")  as? String ?? "")
                                    NotificationCenter.default.post(name: Notification.Name("ReloadTable"), object: nil)
                                    
                                }
                            }
                            
                        }
                        
                        
                        
                    } catch {
                        //                            print(error)
                        DispatchQueue.global(qos: .background).async {
                            // Background Thread
                            DispatchQueue.main.async {
                                
                                SVProgressHUD.dismiss()
                                self.AlertShow(MessageToShow: "Could not complete try again")
                                NotificationCenter.default.post(name: Notification.Name("ReloadTable"), object: nil)
                                
                            }
                        }
                    }
                    
                    
                }
                else{
                    DispatchQueue.global(qos: .background).async {
                        // Background Thread
                        DispatchQueue.main.async {
                            
                            SVProgressHUD.dismiss()
                            
                            self.AlertShow(MessageToShow: "Could not complete try again")
                            NotificationCenter.default.post(name: Notification.Name("ReloadTable"), object: nil)
                            
                            
                        }
                    }
                }
            }.resume()
            //
            //
        } catch {
            DispatchQueue.global(qos: .background).async {
                // Background Thread
                DispatchQueue.main.async {
                    // Run UI Updates or call completion block
                    SVProgressHUD.dismiss()
                    self.AlertShow(MessageToShow: "Could not complete try again")
                    NotificationCenter.default.post(name: Notification.Name("ReloadTable"), object: nil)
                    
                }
            }
        }
        
        
        
    }
    
    func WSGetTickets()
    {
        
        DispatchQueue.global(qos: .background).async {
            // Background Thread
            DispatchQueue.main.async {
                SVProgressHUD.show(withStatus: "Fetching List")
            }
        }
        
     
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
        
        
        let parameterDictionary : NSArray = [[
            "Event":"",
                "EventDate":"",
                "Id":"",
                "Location":"",
                "LoginUser":"",
                "Option":"",
                "PDFPath":"",
                "PhoneNo":"",
                "QRCode":"",
                "QRPath":"",
                "SalesMan":"",
                "isUsed":""
        ]]
        
        
        
        
        print("WSGetTickets %@",parameterDictionary)
        
        
        
        let Url = String(format: "https://www.mypdv.com/Rest/MyPDVSERVWs/Common.svc/SyncTickets")
        
        guard let serviceUrl = URL(string: Url) else { return }
        
        
        
        
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        //        request.setValue(UserDefaults.standard.string(forKey: "APIKey"), forHTTPHeaderField: "APIKey")
        //        if(SwiftFunctions.GetDeviceLanguage() == "en" ){
        //            request.setValue("EN", forHTTPHeaderField: "LANG")
        //        }
        //        else{
        //            request.setValue("AR", forHTTPHeaderField: "LANG")
        //        }
        //        request.setValue(UserDefaults.standard.string(forKey: "UserName"), forHTTPHeaderField: "USER")
        //        request.setValue("\(ObjectiveCFunctions.dateToSecondConvert())", forHTTPHeaderField: "CDT")
        //        request.setValue("IOS", forHTTPHeaderField: "DEVICE")
        //        request.setValue("IPHONE", forHTTPHeaderField: "BROWSER")
        //        request.setValue("MOBILE", forHTTPHeaderField: "DEVICE_TYPE")
        //        request.setValue("\(IP)", forHTTPHeaderField: "IP")
        //        request.setValue(ObjectiveCFunctions.getDeviceID(), forHTTPHeaderField: "DEVICE_ID")
        //        request.setValue(UserDefaults.standard.string(forKey: "UserName"), forHTTPHeaderField: "USER_ID")
        //        //        request.setValue("SEARCHMEMBER", forHTTPHeaderField: "FORM_NAME")
        //        //        request.setValue("/MA/MaWcf.svc/Search", forHTTPHeaderField: "REST_SERVICE")
        //        //        request.setValue("0", forHTTPHeaderField: "PROXY")
        //        //        request.setValue("SEARCHMEMBER", forHTTPHeaderField: "FORM_NAME")
        //        //        request.setValue("SEARCHMEMBER", forHTTPHeaderField: "FORM_NAME")
        //        //        request.setValue("100", forHTTPHeaderField: "APP_ID")
        
        
        
        do {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
                return
            }
            
            request.httpBody = httpBody
            
            let session = URLSession.shared
            //            session.configuration.timeoutIntervalForRequest = 1000
            //            session.configuration.timeoutIntervalForResource = 1000
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        
                        let avatar = NSString(data: data, encoding: String.Encoding.utf8.rawValue);
                        
//                        var dictionary:NSDictionary = try (JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary) as? NSDictionary ?? NSDictionary()
//
//                        print("WSGetTickets %@",dictionary)
                        
                        if let jsonDataArray = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSArray
                        {
                            print("WSGetTickets %@",jsonDataArray)
                            
                            if(jsonDataArray.count != 0 )
                            {
                                DatabaseCalls.SaveDataToLocal(WordId: "AllTickets", DataArray: jsonDataArray.mutableCopy())
                            }
//
                            DispatchQueue.global(qos: .background).async {
                                // Background Thread
                                DispatchQueue.main.async {
                                    // Run UI Updates or call completion block

//                                    self.ListingTableView.reloadData()

                                    SVProgressHUD.dismiss()


                                }
                            }
                      
                            
                        }
                        else
                        {
                            
                            
                            DispatchQueue.global(qos: .background).async {
                                // Background Thread
                                DispatchQueue.main.async {
                                    // Run UI Updates or call completion block
                                    
                                    SVProgressHUD.dismiss()
//                                    self.ListingTableView.reloadData()
//                                    self.AlertShow(MessageToShow: "No more Entries")
                                    
                                }
                            }
                            
                        }
                        
                        
                        
                    } catch {
                        //                            print(error)
                        DispatchQueue.global(qos: .background).async {
                            // Background Thread
                            DispatchQueue.main.async {
                                
                                SVProgressHUD.dismiss()
//                                self.AlertShow(MessageToShow: "Could not complete try again")
                                
                            }
                        }
                    }
                    
                    
                }
                else{
                    DispatchQueue.global(qos: .background).async {
                        // Background Thread
                        DispatchQueue.main.async {
                            
                            SVProgressHUD.dismiss()
                            
//                            self.AlertShow(MessageToShow: "Could not complete try again")
                            
                            
                        }
                    }
                }
            }.resume()
            //
            //
        } catch {
            DispatchQueue.global(qos: .background).async {
                // Background Thread
                DispatchQueue.main.async {
                    // Run UI Updates or call completion block
                    SVProgressHUD.dismiss()
//                    self.AlertShow(MessageToShow: "Could not complete try again")
                    
                }
            }
        }
        
        
        
    }
    
    func WSSyncTickets(ChangedTicketsArray:NSMutableArray)
    {
        
        DispatchQueue.global(qos: .background).async {
            // Background Thread
            DispatchQueue.main.async {
                SVProgressHUD.show(withStatus: "Synching Tickets")
            }
        }
        
     
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
        
        
        let parameterDictionary : NSMutableArray = ChangedTicketsArray
        
        
        
        
        print("WSSyncTickets %@",parameterDictionary)
        
        
        
        let Url = String(format: "https://www.mypdv.com/Rest/MyPDVSERVWs/Common.svc/SyncTickets")
        
        guard let serviceUrl = URL(string: Url) else { return }
        
        
        
        
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")

        do {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
                return
            }
            
            request.httpBody = httpBody
            
            let session = URLSession.shared
            //            session.configuration.timeoutIntervalForRequest = 1000
            //            session.configuration.timeoutIntervalForResource = 1000
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        
                        let avatar = NSString(data: data, encoding: String.Encoding.utf8.rawValue);
                        
//                        var dictionary:NSDictionary = try (JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary) as? NSDictionary ?? NSDictionary()
//
//                        print("WSGetTickets %@",dictionary)
                        
                        if let jsonDataArray = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSArray
                        {
                            print("WSSyncTickets %@",jsonDataArray)
                            
                            if(jsonDataArray.count != 0 )
                            {
                                DatabaseCalls.SaveDataToLocal(WordId: "ChangedTickets", DataArray: NSMutableArray())
                                DatabaseCalls.SaveDataToLocal(WordId: "AllTickets", DataArray: jsonDataArray.mutableCopy())
                                
                                DispatchQueue.global(qos: .background).async {
                                    // Background Thread
                                    DispatchQueue.main.async {
                                        // Run UI Updates or call completion block

    //                                    self.ListingTableView.reloadData()

                                        SVProgressHUD.dismiss()
                                        self.AlertShow(MessageToShow: "Sync Complete")


                                    }
                                }
                            }
//
                            else
                            {
                                
                                
                                DispatchQueue.global(qos: .background).async {
                                    // Background Thread
                                    DispatchQueue.main.async {
                                        // Run UI Updates or call completion block
                                        
                                        SVProgressHUD.dismiss()
    //                                    self.ListingTableView.reloadData()
                                        self.AlertShow(MessageToShow: "Couldn't Complete Sync")
                                        
                                    }
                                }
                                
                            }
                            
                            
                          
                      
                            
                        }
                        else
                        {
                            
                            
                            DispatchQueue.global(qos: .background).async {
                                // Background Thread
                                DispatchQueue.main.async {
                                    // Run UI Updates or call completion block
                                    
                                    SVProgressHUD.dismiss()
//                                    self.ListingTableView.reloadData()
                                    self.AlertShow(MessageToShow: "Couldn't Complete Sync")
                                    
                                }
                            }
                            
                        }
                        
                        
                        
                    } catch {
                        //                            print(error)
                        DispatchQueue.global(qos: .background).async {
                            // Background Thread
                            DispatchQueue.main.async {
                                
                                SVProgressHUD.dismiss()
                                self.AlertShow(MessageToShow: "Couldn't Complete Sync")
                                
                            }
                        }
                    }
                    
                    
                }
                else{
                    DispatchQueue.global(qos: .background).async {
                        // Background Thread
                        DispatchQueue.main.async {
                            
                            SVProgressHUD.dismiss()
                            
                            self.AlertShow(MessageToShow: "Couldn't Complete Sync")
                            
                            
                        }
                    }
                }
            }.resume()
            //
            //
        } catch {
            DispatchQueue.global(qos: .background).async {
                // Background Thread
                DispatchQueue.main.async {
                    // Run UI Updates or call completion block
                    SVProgressHUD.dismiss()
                    self.AlertShow(MessageToShow: "Couldn't Complete Sync")
                    
                }
            }
        }
        
        
        
    }
    
    // MARK: - Ticket Validation Functions
    func ValidateOfflineTicket(ResultString : String)
    {
        DispatchQueue.global(qos: .background).async {
            // Background Thread
            DispatchQueue.main.async {
                SVProgressHUD.show(withStatus: "Validating Ticket")
            }
        }
        
        
        var CHeckBool = self.CheckIfTicketInChangedArray(ResultString: ResultString)
        
        if(CHeckBool == false)
        {
        self.CheckIfTicketInAllArray(ResultString: ResultString)
        }
        else{
            DispatchQueue.global(qos: .background).async {
                // Background Thread
                DispatchQueue.main.async {
                    // Run UI Updates or call completion block
                    SVProgressHUD.dismiss()
                    self.AlertShow(MessageToShow: "QRCode already in use")
                }
            }
        }
        
    }
    
    
    func CheckIfTicketInAllArray(ResultString : String)
    {
        var AllTicketsArray =  DatabaseCalls.GetDataFromLocal(WordId: "AllTickets") as? NSMutableArray ?? NSMutableArray()
        
        if(AllTicketsArray.count != 0)
        {
            var Found = "false"
            for i in 0..<AllTicketsArray.count
            {
                var TicketDic = (AllTicketsArray[i] as? NSDictionary ?? NSDictionary()).mutableCopy() as? NSMutableDictionary ?? NSMutableDictionary()
                if((TicketDic.object(forKey: "QRCode") as? String ?? "") == ResultString )
                {
                    Found = "true"
                    
                    if((TicketDic.object(forKey: "isUsed") as? String ?? "") == "0")
                    {
                    TicketDic.setValue("1", forKey: "isUsed")
                    
                    var ChangedTicketAray =  DatabaseCalls.GetDataFromLocal(WordId: "ChangedTickets") as? NSMutableArray ?? NSMutableArray()
                    ChangedTicketAray.add(TicketDic)
                    
//                        AllTicketsArray[i] = TicketDic
//                        print(AllTicketsArray)
//
//                        DatabaseCalls.SaveDataToLocal(WordId: "AllTickets", DataArray: AllTicketsArray)
                    DatabaseCalls.SaveDataToLocal(WordId: "ChangedTickets", DataArray: ChangedTicketAray)
                    }
                    else{
                        DispatchQueue.global(qos: .background).async {
                            // Background Thread
                            DispatchQueue.main.async {
                                // Run UI Updates or call completion block
                                SVProgressHUD.dismiss()
                                self.AlertShow(MessageToShow: "QRCode already in use")
                            }
                        }
                    }
                }
            }
            
            if(Found == "false")
            {
                DispatchQueue.global(qos: .background).async {
                    // Background Thread
                    DispatchQueue.main.async {
                        // Run UI Updates or call completion block
                        SVProgressHUD.dismiss()
                        self.AlertShow(MessageToShow: "Ticket Was Not Found")
                    }
                }
            }
            if(Found == "true")
            {
                DispatchQueue.global(qos: .background).async {
                    // Background Thread
                    DispatchQueue.main.async {
                        // Run UI Updates or call completion block
                        SVProgressHUD.dismiss()
                        self.AlertShow(MessageToShow: "Validation successful ")
                    }
                }
            }
        }
        else
        {
            DispatchQueue.global(qos: .background).async {
                // Background Thread
                DispatchQueue.main.async {
                    // Run UI Updates or call completion block
                    SVProgressHUD.dismiss()
                    self.AlertShow(MessageToShow: "Cannot Validate Offline")
                }
            }
        }
    }
    
    func CheckIfTicketInChangedArray(ResultString : String) -> Bool
    {
        var CHangedTicketsArray =  DatabaseCalls.GetDataFromLocal(WordId: "ChangedTickets") as? NSMutableArray ?? NSMutableArray()
        
        if(CHangedTicketsArray.count != 0)
        {
            var Found = "false"
            for i in 0..<CHangedTicketsArray.count
            {
                var TicketDic = (CHangedTicketsArray[i] as? NSDictionary ?? NSDictionary()).mutableCopy() as? NSMutableDictionary ?? NSMutableDictionary()
                if((TicketDic.object(forKey: "QRCode") as? String ?? "") == ResultString )
                {
                    Found = "true"
                    
               return true
                }
            }
            
            if(Found == "false")
            {
                return false
            }
  
        }
        return false
    }
    // MARK: - Table view functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      
        return self.ListingArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomePageTableViewCell") as! HomePageTableViewCell
        if(tableView == self.ListingTableView)
        {
            
            if(self.ListingArray.count>indexPath.row)
            {
                cell.selectionStyle = .none
//                cell.ContainerView.
                cell.ContainerView.layer.cornerRadius = 10
                var Dictionary = self.ListingArray[indexPath.row] as? NSDictionary ?? NSDictionary()
                
                cell.ListingImageView.sd_setImage(with: URL(string: Dictionary.object(forKey: "ImgPath") as? String ?? "" ) as URL?, placeholderImage: nil)
                cell.InfoListingButton.addTarget(self, action: #selector(self.OpenInfoListing(sender:)), for: .touchUpInside)
                
                
                let GlobalString = NSMutableAttributedString(string: "" )
                
                if((Dictionary.object(forKey: "Title") as? String ?? "" ) != "")
                {
                    var CONTENTS = "\(Dictionary.object(forKey: "Title") as? String ?? "" ) "
                    var Key =  (Dictionary.object(forKey: "Title") as? String ?? "" )
                    var range = (CONTENTS as NSString).range(of: Key)
                    let myString = NSMutableAttributedString(string: CONTENTS)
                    myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white , range: range)
                    myString.addAttribute(NSAttributedString.Key.font, value: SwiftFunctions.GetCustomTitleSemiBoldBodyFont(EngFontNumber: 16,ArFontNumber:15) , range: range)
//                    myString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12) , range: range)
                    
                    GlobalString.append(myString)
                }
                
                
                if((Dictionary.object(forKey: "Desc") as? String ?? "" ) != "")
                {
                    var CONTENTS = "\n\(Dictionary.object(forKey: "Desc") as? String ?? "" )\n"
                    var Key =  (Dictionary.object(forKey: "Desc") as? String ?? "" )
                    var range = (CONTENTS as NSString).range(of: Key)
                    let myString = NSMutableAttributedString(string: CONTENTS)
                    myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray , range: range)
                    myString.addAttribute(NSAttributedString.Key.font, value: SwiftFunctions.GetCustomBodyFont(EngFontNumber: 13,ArFontNumber:15) , range: range)
                    
//                    myString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 14) , range: range)
                    
                    GlobalString.append(myString)
                }
                
                
                cell.TitleAndDescLabel.attributedText = GlobalString
                
                cell.LocationLabel.text = (Dictionary.object(forKey: "Location") as? String ?? "" )
                cell.LocationLabel.font = SwiftFunctions.GetCustomBodyFont(EngFontNumber: 13,ArFontNumber:15)
                
                cell.PriceLabel.text = "   \(Dictionary.object(forKey: "Price") as? String ?? "" )   "
                cell.PriceLabel.font = SwiftFunctions.GetCustomBodyFont(EngFontNumber: 13,ArFontNumber:15)
                cell.PriceLabel.layer.cornerRadius = 5
                cell.PriceLabel.backgroundColor = UIColor(hexFromString: "#425D9A")
                
            }
        }
        return cell
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var DictionaryDetails = self.ListingArray[indexPath.row] as? NSDictionary ?? NSDictionary()
        let vc = HomePageDetailsViewController(nibName: "HomePageDetailsViewController", bundle: nil)
//        vc.modalPresentationStyle = .fullScreen
        vc.DictionaryDetails = DictionaryDetails
//        self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if(tableView == self.ListingTableView)
//        {        let headerView = UIView()
//           
//            var TitleLabel = UILabel(frame: CGRect(x: 7, y: 0, width: self.ListingTableView.frame.size.width, height: 30))
//            TitleLabel.text = "Deal of The Day"
//            headerView.addSubview(TitleLabel)
//            return headerView
//        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if(tableView == self.ListingTableView)
//        {
//            if(self.ListingArray.count>0)
//            {
//                return 44
//            }
//            else{
//                return 0
//            }
//        }
        return 0
        }
    
    // MARK: - TabBarCnntroller
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            let tabBarIndex = tabBarController.selectedIndex
                      if tabBarIndex == 1 {
            
//
//                        let scanner = QRCodeScannerController(cameraImage: UIImage(named: "camera"), cancelImage: UIImage(named: "cancel"), flashOnImage: UIImage(named: "flash-on"), flashOffImage: UIImage(named: "flash-off"))
//                        scanner.delegate = self
//                //        self.present(scanner, animated: true, completion: nil)
//                        self.navigationController?.pushViewController(scanner, animated: true)
//
                        
            
                      }
            
        }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        // If your view controller is emedded in a UINavigationController you will need to check if it's a UINavigationController and check that the root view controller is your desired controller (or subclass the navigation controller)
        if viewController is QRScannerViewController {

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let scanner = QRCodeScannerController(cameraImage: UIImage(named: "camera"), cancelImage: UIImage(named: "cancel"), flashOnImage: UIImage(named: "flash-on"), flashOffImage: UIImage(named: "flash-off"))
            scanner.delegate = self
    //        self.present(scanner, animated: true, completion: nil)
            self.navigationController?.pushViewController(scanner, animated: true)
            
//            }
            
//            var vc = AddTaskViewController(nibName: "AddTaskViewController", bundle: nil)
//
//            self.navigationController?.pushViewController(vc, animated: true)

            return false
        }

        // Tells the tab bar to select other view controller as normal
        return true
    }
    
    // MARK: - Buttons Pressed
    @objc private func OpenInfoListing(sender: UIButton) {
        
        
        let vc = TicketListingViewController(nibName: "TicketListingViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    // MARK: - Alert
    
    func AlertShow(MessageToShow : String)
    {
        DispatchQueue.global(qos: .background).async {
            // Background Thread
            DispatchQueue.main.async {
                // Run UI Updates or call completion block
                let alertController = UIAlertController(title: "", message: MessageToShow, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "ok", style: .default, handler: { _ in
                    
                    
                })
                alertController.addAction(OKAction)
                //                let CancelAction = UIAlertAction(title: "cancel".localized(), style: .cancel, handler: nil)
                //                alertController.addAction(CancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    func ValidateTicketAlert(MessageToShow : String,Result : String)
    {
        DispatchQueue.global(qos: .background).async {
            // Background Thread
            DispatchQueue.main.async {
                // Run UI Updates or call completion block
                let alertController = UIAlertController(title: "", message: MessageToShow, preferredStyle: .alert)
                let OfflineAction = UIAlertAction(title: "Offline", style: .default, handler: { _ in
                    
                    self.navigationController?.popViewController(animated: true)
                    self.ValidateOfflineTicket(ResultString : Result)
                    
                    
                })
                alertController.addAction(OfflineAction)
                
                let OnlineAction = UIAlertAction(title: "Online", style: .default, handler: { _ in
                    
                    self.navigationController?.popViewController(animated: true)
                    self.WSValidateQRCode(QRContent: Result)
                })
                alertController.addAction(OnlineAction)
                
                
               
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    @objc func ReloadHomePageTable(notification : NSNotification)
    {
        self.FetchListing()
    }
    

}

extension ViewController: QRScannerCodeDelegate {

    func qrScanner(_ controller: UIViewController, scanDidComplete result: String) {
        print("result:\(result)")
        
        
        if((DatabaseCalls.GetDataFromLocal(WordId: "IS_SYSTEM_ADMIN") as? String) == "1")
        {
        self.ValidateTicketAlert(MessageToShow: "Would you like to validate the ticket?",Result: result)
        }
        else{
        self.navigationController?.popViewController(animated: true)
        self.WSValidateQRCode(QRContent: result)
        }
        
    }
    
    func qrScannerDidFail(_ controller: UIViewController, error: String) {
        print("error:\(error)")
    }
    
    func qrScannerDidCancel(_ controller: UIViewController) {
        print("SwiftQRScanner did cancel")
    }
    
    
    func GetChangedTickets(_ controller: UIViewController) -> NSMutableArray {
        print("InitiateVC")
        

        var Arrr =  DatabaseCalls.GetDataFromLocal(WordId: "ChangedTickets") as? NSMutableArray ?? NSMutableArray()
        return Arrr
    }
    
    func SyncTickets(_ controller: UIViewController)  {
        print("SyncTickets")
        
        self.navigationController?.popViewController(animated: true)
        var Arrr =  DatabaseCalls.GetDataFromLocal(WordId: "ChangedTickets") as? NSMutableArray ?? NSMutableArray()
        self.WSSyncTickets(ChangedTicketsArray: Arrr)
    }
}

