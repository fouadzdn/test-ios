//
//  HomePageDetailsViewController.swift
//  SwiftQRScanner_Example
//
//  Created by Softech on 7/23/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SVProgressHUD
import PDFReader

class HomePageDetailsViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate{

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var GenerateCodeButon: UIButton!
//    @IBOutlet weak var EnterTextfield: UITextField!

    @IBOutlet weak var DetailsTableView: UITableView!
    @IBOutlet weak var LocationAndPriceContainer: UIView!
    
//    @IBOutlet weak var PriceLabel: UILabel!
//    @IBOutlet weak var LocationLabel: UILabel!
    public var DictionaryDetails = NSDictionary()
    var OptionsArray = NSArray()
    
    var SelectedIndex = 999999
    
    var Counter = 1
    var backupPhone = "+961"
    override func viewDidLoad() {
        super.viewDidLoad()

        self.OptionsArray = (DictionaryDetails.object(forKey: "Options") as? NSArray ?? NSArray() )
//        self.LocationLabel.text = (DictionaryDetails.object(forKey: "Location") as? String ?? "" )
//        self.LocationLabel.font = UIFont.systemFont(ofSize: 12)
//        self.PriceLabel.text = "LPB \(DictionaryDetails.object(forKey: "Price") as? String ?? "" )"
//        self.PriceLabel.font = UIFont.systemFont(ofSize: 12)
        
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title: "Generate Ticket", style: .plain, target: self, action: #selector(GenerateCodeButton))
        
//        self.EnterTextfield.delegate = self
//        self.EnterTextfield.layer.cornerRadius = 10
//        self.EnterTextfield.backgroundColor = UIColor(red: 40.0/255.0, green: 44.0/255.0, blue: 50.0/255.0, alpha: 1.0)
//
//        self.EnterTextfield.text = "+961"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.CloseKeyboard(_:)))
        self.view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(Login.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Login.keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        
        

        
        self.DetailsTableView.register(UINib(nibName: "DetailsTableViewCell", bundle: .main), forCellReuseIdentifier: "DetailsTableViewCell")
        
        self.DetailsTableView.register(UINib(nibName: "DetailsFooterTableViewCell", bundle: .main), forCellReuseIdentifier: "DetailsFooterTableViewCell")
        self.DetailsTableView.register(UINib(nibName: "HomePageTableViewCell", bundle: .main), forCellReuseIdentifier: "HomePageTableViewCell")
        
//        self.WSGetTicketListing()
//
//        DispatchQueue.global(qos: .background).async {
//            // Background Thread
//            DispatchQueue.main.async {
                // Run UI Updates or call completion block
                
                for var con in self.DetailsTableView.constraints{
                    if(con.identifier=="DetailsHeight")
                    {

                        con.constant = CGFloat( (self.OptionsArray.count)*50)
                        
                    }
                }
//
//            }
//        }
    
asdssdsdsd
        // Do any additional setup after loading the view.
    }
    // MARK: - Table view functions
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      if(section == 0)
      {
        return 1
      }
        
        if(section == 2)
        {
          return 1
        }
        return self.OptionsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell") as! DetailsTableViewCell
        if(tableView == self.DetailsTableView)
        {
            
            if(self.OptionsArray.count>indexPath.row)
            {
                if(indexPath.section == 0)
                {
                  let cell = tableView.dequeueReusableCell(withIdentifier: "HomePageTableViewCell") as! HomePageTableViewCell
                    cell.selectionStyle = .none
    //                cell.ContainerView.
                    cell.ContainerView.layer.cornerRadius = 10
                    var Dictionary = self.DictionaryDetails
                    
                    cell.InfoListingButton.addTarget(self, action: #selector(self.OpenInfoListing(sender:)), for: .touchUpInside)
                    
                    
                    cell.ListingImageView.sd_setImage(with: URL(string: Dictionary.object(forKey: "ImgPath") as? String ?? "" ) as URL?, placeholderImage: nil)
                    
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
                    return cell
                }
                
                if(indexPath.section == 2)
                {
                  let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsFooterTableViewCell") as! DetailsFooterTableViewCell
                    cell.selectionStyle = .none
    
                    cell.backgroundColor = UIColor.black
                    
                    cell.EnterPhoneLabel.font = SwiftFunctions.GetCustomTitleSemiBoldBodyFont(EngFontNumber: 15,ArFontNumber:15)
                    cell.EnterPhoneTextField.delegate = self
                    cell.EnterPhoneTextField.layer.cornerRadius = 10
                    cell.EnterPhoneTextField.backgroundColor = UIColor(red: 40.0/255.0, green: 44.0/255.0, blue: 50.0/255.0, alpha: 1.0)
                    
                    cell.EnterPhoneTextField.text = self.backupPhone
                    
                    cell.CounterContainer.layer.cornerRadius = 10
                    cell.CounterContainer.layer.borderColor = UIColor.systemBlue.cgColor
                    cell.CounterContainer.layer.borderWidth = 1
                   
                    cell.MInusButton.addTarget(self, action: #selector(self.MinusButton(sender:)), for: .touchUpInside)
                    
                    cell.PlusBUtton.addTarget(self, action: #selector(self.PlusButton(sender:)), for: .touchUpInside)
                    return cell
                }
                
                
                cell.selectionStyle = .none
                var OPtionSTr = self.OptionsArray[indexPath.row] as? NSDictionary ?? NSDictionary()
                
                cell.OptionLabel.text = OPtionSTr.object(forKey: "Name") as? String ?? ""
                cell.OptionLabel.font = SwiftFunctions.GetCustomBodyFont(EngFontNumber: 13,ArFontNumber:15)
                
                cell.CheckButton.addTarget(self, action: #selector(RequestButtonPressed), for: .touchUpInside)
                cell.CheckButton.accessibilityLabel = "\(indexPath.row)"
                
                
                if(self.SelectedIndex == indexPath.row) { // Unchecked
                    cell.CheckButton.setImage(UIImage(named: "Check"), for: UIControl.State.normal)
                   
                } else { // Checked
                    cell.CheckButton.setImage(UIImage(named: "UnCheck"), for: UIControl.State.normal)
                }
                
            }
        }
        return cell
        }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

       
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if(tableView == self.DetailsTableView)
//        {        let headerView = UIView()
//
//            if(section != 0)
//                 {
//            var TitleLabel = UILabel(frame: CGRect(x: 7, y: 10, width: self.DetailsTableView.frame.size.width, height: 30))
//            TitleLabel.text = "Choose an Option"
//                TitleLabel.textColor = UIColor.white
//            TitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
//            headerView.addSubview(TitleLabel)
//            headerView.backgroundColor = UIColor(red: 31.0/255.0, green: 34.0/255.0, blue: 39.0/255.0, alpha: 1.0)
//            return headerView
//            }
//        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if(tableView == self.DetailsTableView)
//        {
//            if(section == 0)
//            {
//                return 0
//            }
//            if(self.OptionsArray.count>0)
//            {
//                return 44
//            }
//            else{
//                return 0
//            }
//        }
        return 0
        }

//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor(red: 31.0/255.0, green: 34.0/255.0, blue: 39.0/255.0, alpha: 1.0)
//   
//        
//         let headerCell = tableView.dequeueReusableCell(withIdentifier: "DetailsFooterTableViewCell") as! DetailsFooterTableViewCell
//         headerCell.frame = CGRect(x: 0, y: 0, width: DetailsTableView.frame.size.width, height: headerCell.frame.size.height)
//        
//        headerCell.EnterPhoneTextField.delegate = self
//        headerCell.EnterPhoneTextField.layer.cornerRadius = 10
//        headerCell.EnterPhoneTextField.backgroundColor = UIColor(red: 40.0/255.0, green: 44.0/255.0, blue: 50.0/255.0, alpha: 1.0)
//         
//         //            headerCell.backgroundColor = UIColor.green
//         headerView.addSubview(headerCell)
//         return headerView
//}
//func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//            return 60
//    }


   
    // MARK: - UITextField Functions
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.DetailsTableView.isScrollEnabled = false
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
        
        self.DetailsTableView.isScrollEnabled = true
        let indexPath = IndexPath(row: 0, section: 2)
        let cell:DetailsFooterTableViewCell = self.DetailsTableView.cellForRow(at: indexPath) as! DetailsFooterTableViewCell
        self.backupPhone = cell.EnterPhoneTextField.text as? String ?? ""
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
    
    @IBAction func RequestButtonPressed(_ sender: UIButton) {
        
//        let indexPath = IndexPath(row: 0, section: 2)
//        let cell:DetailsFooterTableViewCell = self.DetailsTableView.cellForRow(at: indexPath) as! DetailsFooterTableViewCell
        
        var Index = Int(sender.accessibilityLabel as? String ?? "9999" )
        self.SelectedIndex = Index ?? 999999
        
//         self.backupPhone = cell.EnterPhoneTextField.text as? String ?? ""
        
        
        self.DetailsTableView.reloadData()
        
       
//        cell.EnterPhoneTextField.text = self.backupPhone
        
       
    }
    @objc func CloseKeyboard(_ sender: UITapGestureRecognizer) {
        
//        let indexPath = IndexPath(row: 0, section: 2)
//        let cell:DetailsFooterTableViewCell = self.DetailsTableView.cellForRow(at: indexPath) as! DetailsFooterTableViewCell
//        self.backupPhone = cell.EnterPhoneTextField.text as? String ?? ""
        self.view.endEditing(true)
    }
    
//    @IBAction func GenerateCodeButton(_ sender: Any) {
//
//        if(self.EnterTextfield.text != "")
//        {
//        self.WSGenerateCode()
//        }
//    }
    
    @IBAction func GenerateCodeButton(_ sender: Any) {
//        let indexPath = IndexPath(row: 0, section: 2)
//               let cell:DetailsFooterTableViewCell = self.DetailsTableView.cellForRow(at: indexPath) as! DetailsFooterTableViewCell
        
//        if((cell.EnterPhoneTextField.text as? String ?? "") != "" && self.SelectedIndex != 999999  && ((cell.EnterPhoneTextField.text as? String ?? "").contains("+961")) && (cell.EnterPhoneTextField.text as? String ?? "").count < 13 && (cell.EnterPhoneTextField.text as? String ?? "").count > 10)
//        {
//        self.WSGenerateCode()
//        }
        
        if((self.backupPhone as? String ?? "") != "")
        {
            if((self.backupPhone as? String ?? "").contains("+961"))
            {
                if((self.backupPhone as? String ?? "").count < 13 && (self.backupPhone as? String ?? "").count > 10)
                       {
                    if(self.SelectedIndex != 999999 )
                           {
                        self.WSGenerateCode()
                           }
                           else
                           {
                               self.AlertShow(MessageToShow: "Please Choose an Option ")
                           }
                       }
                       else
                       {
                           self.AlertShow(MessageToShow: "Phone Entered is not Valid")
                       }
            }
            else
            {
                self.AlertShow(MessageToShow: "Phone Should Contain +961")
            }
        }
        else
        {
            self.AlertShow(MessageToShow: "Phone Field Empty")
        }
        
    }
    @objc private func MinusButton(sender: UIButton) {
        
        if(Counter > 1)
        {
            let indexPath = IndexPath(row: 0, section: 2)
            let cell:DetailsFooterTableViewCell = self.DetailsTableView.cellForRow(at: indexPath) as! DetailsFooterTableViewCell
            
            Counter = Counter - 1
            
            cell.ValueLabel.text = "\(Counter)"
        }
        
    }
    
    
    @objc private func PlusButton(sender: UIButton) {
        
        
        Counter = Counter + 1
        let indexPath = IndexPath(row: 0, section: 2)
        let cell:DetailsFooterTableViewCell = self.DetailsTableView.cellForRow(at: indexPath) as! DetailsFooterTableViewCell
        cell.ValueLabel.text = "\(Counter)"
        
    }
    
    @objc private func OpenInfoListing(sender: UIButton) {
        
        
        let vc = TicketListingViewController(nibName: "TicketListingViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    // MARK: - KeyBoard Functions
    @objc func keyboardWillShow(notification: Notification) {
        //        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
        //            print("notification: Keyboard will show")
        //            if self.scrollView.frame.origin.y == 0{
        //                self.scrollView.frame.origin.y -= keyboardSize.height/2
        //            }
        //        }
        
        print(DetailsTableView.contentSize.height)
        print(DetailsTableView.bounds.size.height)
        let bottomOffset = CGPoint(x: 0, y: DetailsTableView.contentSize.height - DetailsTableView.bounds.size.height+300)
        DetailsTableView.setContentOffset(bottomOffset, animated: true)
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        //        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
        //             print("notification: Keyboard will show")
        //            if self.scrollView.frame.origin.y != 0 {
        //                self.scrollView.frame.origin.y += keyboardSize.height/2
        //            }
        //        }
        
        let bottomOffset = CGPoint(x: 0, y: 0)
        DetailsTableView.setContentOffset(bottomOffset, animated: true)
    }
    
    // MARK: - WS Functions
    
    func WSGenerateCode()
    {
        
        DispatchQueue.global(qos: .background).async {
            // Background Thread
            DispatchQueue.main.async {
                SVProgressHUD.show(withStatus: "Generating Ticket")
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
        
        
//        let indexPath = IndexPath(row: 0, section: 2)
//        let cell:DetailsFooterTableViewCell = self.DetailsTableView.cellForRow(at: indexPath) as! DetailsFooterTableViewCell

      
        
        
        var OPtionSTr = self.OptionsArray[self.SelectedIndex] as? NSDictionary ?? NSDictionary()
        var EventId =  OPtionSTr.object(forKey: "Id") as? String ?? ""
        let parameterDictionary : NSDictionary =  [
            "EventId":self.DictionaryDetails.object(forKey: "Id") as? String ?? "",
            "LoginUser":DatabaseCalls.GetDataFromLocal(WordId: "UserName") as? String ?? "",
            "PhoneNo":self.backupPhone,
                "SalesMan":DatabaseCalls.GetDataFromLocal(WordId: "FULL_NAME") as? String ?? "",
            "OptionId":EventId,
            "QTY":"\(Counter)"
    ]
        
        
        
        
        print("WSGenerateCode %@",parameterDictionary)
        
        
        
        let Url = String(format: "https://www.mypdv.com/Rest/MyPDVSERVWs/Common.svc/GenerateBarcode")
        
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
                       
                        print("WSGenerateCode %@",dictionary)
                        
                        if (dictionary.count != 0)
                        {
                            
                            
                          
                                
                                DispatchQueue.global(qos: .background).async {
                                    // Background Thread
                                    DispatchQueue.main.async {
                                        // Run UI Updates or call completion block

                                        NotificationCenter.default.post(name: Notification.Name("ReloadHomePageTable"), object: nil)
                                        
                                        
                                        SVProgressHUD.dismiss()
//                                        self.AlertShow(MessageToShow: "No more Entries")
                                        
                                        let remotePDFDocumentURLPath = dictionary.object(forKey: "PDFPath") as? String ?? ""
                                        guard let remotePDFDocumentURL = URL(string: remotePDFDocumentURLPath) else { return }
                                        
                                        guard let document = PDFDocument(url: remotePDFDocumentURL) else { return }
//                                        let document = PDFDocument(url: remotePDFDocumentURL)!
//                                        let readerController = PDFViewController.createNew(with: document)
                                        let image = UIImage(named: "")
                                        let controller = PDFViewController.createNew(with: document, title: "", actionButtonImage: image, actionStyle: .activitySheet, PhoneFouad: dictionary.object(forKey: "PhoneNo") as? String ?? "", documentURLFouad: dictionary.object(forKey: "PDFPath") as? String ?? "")
//                                        readerController.modalPresentationStyle = .fullScreen
//                                        self.present(readerController, animated: true, completion: nil)
                                        self.navigationController?.pushViewController(controller, animated: true)
                                      

                                    }
                                }

//                            }
                            
                            
                      
                            
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
        
        
//        let indexPath = IndexPath(row: 0, section: 2)
//        let cell:DetailsFooterTableViewCell = self.DetailsTableView.cellForRow(at: indexPath) as! DetailsFooterTableViewCell
//
//
//
//
//        var OPtionSTr = self.OptionsArray[self.SelectedIndex] as? NSDictionary ?? NSDictionary()
//        var EventId =  OPtionSTr.object(forKey: "Id") as? String ?? ""
        let parameterDictionary : NSDictionary =  [
//            "EventId":self.DictionaryDetails.object(forKey: "Id") as? String ?? "",
//            "LoginUser":UserDefaults.standard.string(forKey: "UserName"),
//            "PhoneNo":cell.EnterPhoneTextField.text as? String ?? "",
//                "SalesMan":UserDefaults.standard.string(forKey: "FULL_NAME"),
//            "OptionId":EventId,
//            "QTY":"\(Counter)"
            
            "EventId":"1"
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
                            
                            
                          
                                
//                                DispatchQueue.global(qos: .background).async {
//                                    // Background Thread
//                                    DispatchQueue.main.async {
//                                        // Run UI Updates or call completion block
//
//                                        NotificationCenter.default.post(name: Notification.Name("ReloadHomePageTable"), object: nil)
//                                        
//                                        
//                                        SVProgressHUD.dismiss()
////                                        self.AlertShow(MessageToShow: "No more Entries")
//                                        
//                                        let remotePDFDocumentURLPath = dictionary.object(forKey: "PDFPath") as? String ?? ""
//                                        guard let remotePDFDocumentURL = URL(string: remotePDFDocumentURLPath) else { return }
//                                        
//                                        guard let document = PDFDocument(url: remotePDFDocumentURL) else { return }
////                                        let document = PDFDocument(url: remotePDFDocumentURL)!
////                                        let readerController = PDFViewController.createNew(with: document)
//                                        let image = UIImage(named: "")
//                                        let controller = PDFViewController.createNew(with: document, title: "", actionButtonImage: image, actionStyle: .activitySheet, PhoneFouad: dictionary.object(forKey: "PhoneNo") as? String ?? "", documentURLFouad: dictionary.object(forKey: "PDFPath") as? String ?? "")
////                                        readerController.modalPresentationStyle = .fullScreen
////                                        self.present(readerController, animated: true, completion: nil)
//                                        self.navigationController?.pushViewController(controller, animated: true)
//                                      
//
//                                    }
//                                }

//                            }
                            
                            
                      
                            
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
