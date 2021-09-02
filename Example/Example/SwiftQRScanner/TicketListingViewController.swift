//
//  TicketListingViewController.swift
//  SwiftQRScanner_Example
//
//  Created by Softech on 7/23/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SVProgressHUD
import PDFReader
import DropDown
class TicketListingViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var GenerateCodeButon: UIButton!
    @IBOutlet weak var SelectOptionLabel: UILabel!
    @IBOutlet weak var SelectOptionContainer: UIView!
    @IBOutlet weak var GoButton: UIButton!
    
    @IBOutlet weak var SelectSalesManContainer: UIView!
    @IBOutlet weak var SelectSalesManLabel: UILabel!
    
    //    @IBOutlet weak var EnterTextfield: UITextField!
    
    @IBOutlet weak var DetailsTableView: UITableView!
    @IBOutlet weak var LocationAndPriceContainer: UIView!
    
    //    @IBOutlet weak var PriceLabel: UILabel!
    //    @IBOutlet weak var LocationLabel: UILabel!
    public var DictionaryDetails = NSDictionary()
    var OptionsArray = NSArray()
    var OptionsStrArray = NSArray()
    
    var SalesManArray = NSArray()
    
    var TicketArray = NSMutableArray()
    
    var GlobalDic = NSDictionary()
    
    let rightBarDropDown = DropDown()
    var DropDownIndex : Int = 0
    lazy var dropDowns: [DropDown] = {
        return [
            self.rightBarDropDown
        ]
    }()
    
    let SalessManrightBarDropDown = DropDown()
    var SalessManDropDownIndex : Int = 0
    lazy var SalessMandropDowns: [DropDown] = {
        return [
            self.SalessManrightBarDropDown
        ]
    }()
    
    
    @IBAction func showBarButtonDropDown(_ sender: AnyObject) {
        rightBarDropDown.show()
    }
    @IBAction func showBarButtonSalesManDropDown(_ sender: AnyObject) {
        SalessManrightBarDropDown.show()
    }
    
    
    func setupRightBarDropDown() {
        rightBarDropDown.anchorView = self.SelectOptionLabel
        rightBarDropDown.selectRow(self.DropDownIndex)
        rightBarDropDown.backgroundColor = UIColor.init(hexFromString: "#1F2227")
        rightBarDropDown.textColor = UIColor.white
        rightBarDropDown.bottomOffset = CGPoint(x: -5, y:(rightBarDropDown.anchorView?.plainView.bounds.height)! + 10)
        rightBarDropDown.cornerRadius = 10
        rightBarDropDown.dataSource = OptionsStrArray as? [String] ?? [""]
        rightBarDropDown.TypeES = "Option"
    }
    
    func setupRightBarSalesManDropDown() {
        SalessManrightBarDropDown.anchorView = self.SelectSalesManLabel
        SalessManrightBarDropDown.selectRow(self.SalessManDropDownIndex)
        SalessManrightBarDropDown.backgroundColor = UIColor.init(hexFromString: "#1F2227")
        SalessManrightBarDropDown.textColor = UIColor.white
        SalessManrightBarDropDown.bottomOffset = CGPoint(x: -5, y:(SalessManrightBarDropDown.anchorView?.plainView.bounds.height)! + 10)
        SalessManrightBarDropDown.cornerRadius = 10
        SalessManrightBarDropDown.dataSource = SalesManArray as? [String] ?? [""]
        SalessManrightBarDropDown.TypeES = "Sales"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.topItem?.title="Ticket History"
        NotificationCenter.default.addObserver(self, selector: #selector(TicketListFilter), name: NSNotification.Name(rawValue: "TicketListFilter"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SalesManListFilter), name: NSNotification.Name(rawValue: "SalesManListFilter"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SelectOptionLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.showBarButtonDropDown(_:)))
        self.SelectOptionLabel.addGestureRecognizer(tap)
        self.SelectOptionContainer.layer.cornerRadius = 10
        self.SelectOptionContainer.backgroundColor = UIColor.init(hexFromString: "#1F2227")
        self.SelectOptionLabel.text = "Select an Option"
        self.SelectOptionLabel.font = SwiftFunctions.GetCustomBodyFont(EngFontNumber: 14,ArFontNumber:15)
        
//        self.SelectSalesManLabel.isUserInteractionEnabled = true
//        let SalesMantap = UITapGestureRecognizer(target: self, action: #selector(self.showBarButtonSalesManDropDown(_:)))
//        self.SelectSalesManLabel.addGestureRecognizer(SalesMantap)
//        self.SelectSalesManContainer.layer.cornerRadius = 10
//        self.SelectSalesManContainer.backgroundColor = UIColor.init(hexFromString: "#1F2227")
//        self.SelectSalesManLabel.text = "Select a Salesman"
//        self.SelectSalesManLabel.font = SwiftFunctions.GetCustomBodyFont(EngFontNumber: 14,ArFontNumber:15)
        
        self.GoButton.backgroundColor = UIColor(red: 69.0/255.0, green: 122.0/255.0, blue: 178.0/255.0, alpha: 1.0)
        self.GoButton.layer.cornerRadius = 10
        
        //        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title: "Generate Ticket", style: .plain, target: self, action: #selector(GenerateCodeButton))
        
        
        
       
        
        NotificationCenter.default.addObserver(self, selector: #selector(Login.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Login.keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        
        
        
        
        self.DetailsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        self.WSGetTicketListing()
        
        
        
        // Do any additional setup after loading the view.
    }
    // MARK: - Table view functions
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //        3
    //    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.TicketArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        if(tableView == self.DetailsTableView)
        {
            
            if(self.TicketArray.count>indexPath.row)
            {
                //            cell.textLabel?.font = SwiftFunctions.GetCustomBodyFont(EngFontNumber: 12, ArFontNumber: 22)
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.textColor = UIColor.white
                cell.backgroundColor = UIColor.clear
                cell.textLabel?.textAlignment = .left
                
                
                
                if var GlobalDic = self.TicketArray[indexPath.row] as? NSDictionary{
                    let GlobalString = NSMutableAttributedString(string: "" )
                    
                    
                    cell.textLabel?.font = SwiftFunctions.GetCustomTitleSemiBoldBodyFont(EngFontNumber: 14,ArFontNumber:15)
                    
                    if((GlobalDic.object(forKey: "Event") as? String ?? "" ) != "")
                    {
                        var CONTENTS = "Event: \(GlobalDic.object(forKey: "Event") as? String ?? "" ) "
                        var Key =  (GlobalDic.object(forKey: "Event") as? String ?? "" )
                        var range = (CONTENTS as NSString).range(of: Key)
                        let myString = NSMutableAttributedString(string: CONTENTS)
                        myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 137.0/255.0, green: 147.0/255.0, blue: 158.0/255.0, alpha: 1.0) , range: range)
                        myString.addAttribute(NSAttributedString.Key.font, value: SwiftFunctions.GetCustomBodyFont(EngFontNumber: 14,ArFontNumber:15) , range: range)
                        
                        GlobalString.append(myString)
                    }
              
                    //
                    if(((GlobalDic.object(forKey: "EventDate")) != nil))
                    {
                        
                        var CONTENTS = "\nEventDate: \(GlobalDic.object(forKey: "EventDate") as? String ?? "" ) "
                        var Key =  (GlobalDic.object(forKey: "EventDate")) as? String ?? ""
                        var range = (CONTENTS as NSString).range(of: Key)
                        let myString = NSMutableAttributedString(string: CONTENTS)
                        myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 137.0/255.0, green: 147.0/255.0, blue: 158.0/255.0, alpha: 1.0) , range: range)
                        myString.addAttribute(NSAttributedString.Key.font, value: SwiftFunctions.GetCustomBodyFont(EngFontNumber: 14,ArFontNumber:15) , range: range)
                        
                        GlobalString.append(myString)
                    }
                    
                    if(((GlobalDic.object(forKey: "Location")) != nil))
                    {
                        
                        var CONTENTS = "\nLocation: \(GlobalDic.object(forKey: "Location") as? String ?? "" ) "
                        var Key =  (GlobalDic.object(forKey: "Location")) as? String ?? ""
                        var range = (CONTENTS as NSString).range(of: Key)
                        let myString = NSMutableAttributedString(string: CONTENTS)
                        myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 137.0/255.0, green: 147.0/255.0, blue: 158.0/255.0, alpha: 1.0) , range: range)
                        myString.addAttribute(NSAttributedString.Key.font, value: SwiftFunctions.GetCustomBodyFont(EngFontNumber: 14,ArFontNumber:15) , range: range)
                        
                        GlobalString.append(myString)
                    }
                    
                    if(((GlobalDic.object(forKey: "LoginUser")) != nil))
                    {
                        
                        var CONTENTS = "\nLoginUser: \(GlobalDic.object(forKey: "LoginUser") as? String ?? "" ) "
                        var Key =  (GlobalDic.object(forKey: "LoginUser")) as? String ?? ""
                        var range = (CONTENTS as NSString).range(of: Key)
                        let myString = NSMutableAttributedString(string: CONTENTS)
                        myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 137.0/255.0, green: 147.0/255.0, blue: 158.0/255.0, alpha: 1.0) , range: range)
                        myString.addAttribute(NSAttributedString.Key.font, value: SwiftFunctions.GetCustomBodyFont(EngFontNumber: 14,ArFontNumber:15) , range: range)
                        
                        GlobalString.append(myString)
                    }
                    
                    
                    if(((GlobalDic.object(forKey: "Option")) != nil))
                    {
                        
                        var CONTENTS = "\nOption: \(GlobalDic.object(forKey: "Option") as? String ?? "" ) "
                        var Key =  (GlobalDic.object(forKey: "Option")) as? String ?? ""
                        var range = (CONTENTS as NSString).range(of: Key)
                        let myString = NSMutableAttributedString(string: CONTENTS)
                        myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 137.0/255.0, green: 147.0/255.0, blue: 158.0/255.0, alpha: 1.0) , range: range)
                        myString.addAttribute(NSAttributedString.Key.font, value: SwiftFunctions.GetCustomBodyFont(EngFontNumber: 14,ArFontNumber:15) , range: range)
                        
                        GlobalString.append(myString)
                    }
                    
                    if(((GlobalDic.object(forKey: "PhoneNo")) != nil))
                    {
                        
                        var CONTENTS = "\nPhoneNo: \(GlobalDic.object(forKey: "PhoneNo") as? String ?? "" ) "
                        var Key =  (GlobalDic.object(forKey: "PhoneNo")) as? String ?? ""
                        var range = (CONTENTS as NSString).range(of: Key)
                        let myString = NSMutableAttributedString(string: CONTENTS)
                        myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 137.0/255.0, green: 147.0/255.0, blue: 158.0/255.0, alpha: 1.0) , range: range)
                        myString.addAttribute(NSAttributedString.Key.font, value: SwiftFunctions.GetCustomBodyFont(EngFontNumber: 14,ArFontNumber:15) , range: range)
                        
                        GlobalString.append(myString)
                    }
                    
                    if(((GlobalDic.object(forKey: "SalesMan")) != nil))
                    {
                        
                        var CONTENTS = "\nSalesMan: \(GlobalDic.object(forKey: "SalesMan") as? String ?? "" ) "
                        var Key =  (GlobalDic.object(forKey: "SalesMan")) as? String ?? ""
                        var range = (CONTENTS as NSString).range(of: Key)
                        let myString = NSMutableAttributedString(string: CONTENTS)
                        myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 137.0/255.0, green: 147.0/255.0, blue: 158.0/255.0, alpha: 1.0) , range: range)
                        myString.addAttribute(NSAttributedString.Key.font, value: SwiftFunctions.GetCustomBodyFont(EngFontNumber: 14,ArFontNumber:15) , range: range)
                        
                        GlobalString.append(myString)
                    }
                    
                    if(((GlobalDic.object(forKey: "isUsed")) != nil))
                    {
                        
                        var CONTENTS = "\nisUsed: \(GlobalDic.object(forKey: "isUsed") as? String ?? "" ) "
                        var Key =  (GlobalDic.object(forKey: "isUsed")) as? String ?? ""
                        var range = (CONTENTS as NSString).range(of: Key)
                        let myString = NSMutableAttributedString(string: CONTENTS)
                        myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 137.0/255.0, green: 147.0/255.0, blue: 158.0/255.0, alpha: 1.0) , range: range)
                        myString.addAttribute(NSAttributedString.Key.font, value: SwiftFunctions.GetCustomBodyFont(EngFontNumber: 14,ArFontNumber:15) , range: range)
                        
                        GlobalString.append(myString)
                    }
                    
                    
                    cell.textLabel?.attributedText = GlobalString
                    
                    
                }
                
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 31.0/255.0, green: 34.0/255.0, blue: 39.0/255.0, alpha: 1.0)


     
        
        let DonorLabel = UILabel(frame: CGRect(x:15, y: 0, width: self.DetailsTableView.frame.size.width  , height: 50))
//        DonorLabel.text = "Investments"
//        DonorLabel.font = SwiftFunctions.GetCustomTitleSemiBoldBodyFont(EngFontNumber: 17, ArFontNumber: 16)
        DonorLabel.textColor = UIColor.white
        
         var totalSoldDic = self.GlobalDic.object(forKey: "totalSold")  as? NSDictionary ?? NSDictionary()
        var TotalPriceDic = self.GlobalDic.object(forKey: "TotalPrice")  as? NSDictionary ?? NSDictionary()
            let GlobalString = NSMutableAttributedString(string: "" )
            
            
            DonorLabel.font = SwiftFunctions.GetCustomTitleSemiBoldBodyFont(EngFontNumber: 16,ArFontNumber:15)
            
            if((totalSoldDic.object(forKey: "Count") as? String ?? "" ) != "")
            {
                var CONTENTS = "Total Tickets Sold: \(totalSoldDic.object(forKey: "Count") as? String ?? "" ) "
                var Key =  (totalSoldDic.object(forKey: "Count") as? String ?? "" )
                var range = (CONTENTS as NSString).range(of: Key)
                let myString = NSMutableAttributedString(string: CONTENTS)
                myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 137.0/255.0, green: 147.0/255.0, blue: 158.0/255.0, alpha: 1.0) , range: range)
                myString.addAttribute(NSAttributedString.Key.font, value: SwiftFunctions.GetCustomBodyFont(EngFontNumber: 14,ArFontNumber:15) , range: range)
                
                GlobalString.append(myString)
            }
      
            //
            if(((TotalPriceDic.object(forKey: "Price")) != nil))
            {
                
                var CONTENTS = "\nTotal Price of Tickets: \(TotalPriceDic.object(forKey: "Price") as? String ?? "" ) "
                var Key =  (TotalPriceDic.object(forKey: "Price")) as? String ?? ""
                var range = (CONTENTS as NSString).range(of: Key)
                let myString = NSMutableAttributedString(string: CONTENTS)
                myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 137.0/255.0, green: 147.0/255.0, blue: 158.0/255.0, alpha: 1.0) , range: range)
                myString.addAttribute(NSAttributedString.Key.font, value: SwiftFunctions.GetCustomBodyFont(EngFontNumber: 14,ArFontNumber:15) , range: range)
                
                GlobalString.append(myString)
            }
            DonorLabel.attributedText = GlobalString
            
            
            
        
        DonorLabel.numberOfLines = 0
        headerView.addSubview(DonorLabel)
        return headerView
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //        if(tableView == self.DetailsTableView)
        //        {
        //            if(section == 0)
        //            {
        //                return 0
        //            }
                    if(self.TicketArray.count>0)
                    {
                        return 50
                    }
        //            else{
        //                return 0
        //            }
        //        }
        return 0
    }
    
//        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//            let headerView = UIView()
//            headerView.backgroundColor = UIColor(red: 31.0/255.0, green: 34.0/255.0, blue: 39.0/255.0, alpha: 1.0)
//
//
//
//
//            let DonorLabel = UILabel(frame: CGRect(x:20, y: 10, width: 370  , height: 100))
//            DonorLabel.text = "Investments"
//            DonorLabel.font = SwiftFunctions.GetCustomTitleSemiBoldBodyFont(EngFontNumber: 17, ArFontNumber: 16)
//            DonorLabel.textColor = UIColor.white
//            DonorLabel.numberOfLines = 0
//            headerView.addSubview(DonorLabel)
//
//
//             return headerView
//    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//                return 60
//        }
    
    
    
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
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //        self.view.endEditing(true)
        return true
    }
    // MARK: - button Functions
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func CloseKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func GoButtonPressed(_ sender: Any) {
        self.WSGetTicketListing()
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
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height+100)
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
    
    // MARK: - WS Functions
    
    
    
    func WSGetTicketListing()
    {
        
        DispatchQueue.global(qos: .background).async {
            // Background Thread
            DispatchQueue.main.async {
                SVProgressHUD.show(withStatus: "Getting Tickets")
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
        
        var OptionIDDictionary = NSDictionary()
        var OptionID = ""
        var SalesMan = ""
        
        if(self.DropDownIndex != 0)
        {
            OptionIDDictionary = self.OptionsArray[self.DropDownIndex - 1] as? NSDictionary ?? NSDictionary()
            OptionID = OptionIDDictionary.object(forKey: "Id") as? String ?? ""
        }
    
        
//        if(self.SalessManDropDownIndex != 0)
//        {
//            SalesMan = self.SalesManArray[self.SalessManDropDownIndex] as? String ?? ""
//        }
        
        let parameterDictionary : NSDictionary =  [
            
            "EventId":"1",
            "OptionId":OptionID,
//            "LoginUser":SalesMan
            "LoginUser":DatabaseCalls.GetDataFromLocal(WordId: "UserName") as? String ?? ""
        ]
        
        
        
        
        print("WSGetTicketListing %@",parameterDictionary)
        
        
        
        let Url = String(format: "https://www.mypdv.com/Rest/MyPDVSERVWs/Common.svc/Tickets")
        
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
                        
                        var dictionary:NSDictionary = try (JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary)!
                        
                        print("WSGetTicketListing %@",dictionary)
                        
                        if (dictionary.count != 0)
                        {
                            
                            self.GlobalDic = dictionary
                            
                            if let LsitArr = dictionary.object(forKey: "List") as? NSMutableArray {
                                
                                self.TicketArray = LsitArr as? NSMutableArray ?? NSMutableArray()
                                
                                
                            }
                            
                            if let OptionArr = dictionary.object(forKey: "Options") as? NSArray {
                                
                                var StrArray = NSMutableArray()
                                self.OptionsArray = OptionArr
                                
                                StrArray.add("Select an Option")
                                
                                for i in 0..<self.OptionsArray.count
                                {
                                    var Dic = self.OptionsArray[i] as? NSDictionary ?? NSDictionary()
                                    StrArray.add(Dic.object(forKey: "Name") as? String ?? "")
                                }
                                
                                self.OptionsStrArray = StrArray.copy() as? NSArray ?? NSArray()
                                
                            }
                            
                            
                            if let SalesManArr = dictionary.object(forKey: "SalesMan") as? NSArray {
                                
                                var StrArray = NSMutableArray()
                                StrArray.add("Select a Salesman")
                                for i in 0..<SalesManArr.count
                                {
                                    
                                    StrArray.add(SalesManArr[i] as? String ?? "")
                                }
                                
                                self.SalesManArray = StrArray.copy() as? NSArray ?? NSArray()
                                
                                
                            }
                            
                            
                            DispatchQueue.global(qos: .background).async {
                                // Background Thread
                                DispatchQueue.main.async {
                                    // Run UI Updates or call completion block
                                    
                                    self.setupRightBarDropDown()
//                                    self.setupRightBarSalesManDropDown()
                                    
                                    SVProgressHUD.dismiss()
                                    
                                    self.DetailsTableView.reloadData()
                                    
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
                                    self.AlertShow(MessageToShow: "Could not complete try again")
                                    
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
                    
                }
            }
        }
        
        
        
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
    
    
    // MARK: - NSNotification
    @objc func TicketListFilter(notification : NSNotification)
       {
        
        var filterDic = notification.object as? NSMutableDictionary ?? NSMutableDictionary()
        self.DropDownIndex = (filterDic.object(forKey: "Index") as? Int ?? 0)
        print(self.DropDownIndex)
 
        rightBarDropDown.selectRow(self.DropDownIndex)
        self.SelectOptionLabel.text = self.OptionsStrArray[self.DropDownIndex] as? String ?? ""

        
        
        
    }
    @objc func SalesManListFilter(notification : NSNotification)
       {
        
        var filterDic = notification.object as? NSMutableDictionary ?? NSMutableDictionary()
        self.SalessManDropDownIndex = (filterDic.object(forKey: "Index") as? Int ?? 0)
        print(self.SalessManDropDownIndex)
 
        self.SalessManrightBarDropDown.selectRow(self.DropDownIndex)
        self.SelectSalesManLabel.text = self.SalesManArray[self.SalessManDropDownIndex] as? String ?? ""

        
        
        
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
