//
//  HistoryViewController.swift
//  SwiftQRScanner_Example
//
//  Created by Softech on 7/26/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var HistoryTableView: UITableView!
    var ScannedQRArray = NSMutableArray()
    var BAckUpArray:NSMutableArray = NSMutableArray()
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title="History"
        self.title = "History"
        
        self.ScannedQRArray = DatabaseCalls.GetDataFromLocal(WordId: "ScannedQR") as? NSMutableArray ?? NSMutableArray()
        self.ScannedQRArray = (self.ScannedQRArray.reversed() as NSArray).mutableCopy() as? NSMutableArray ?? NSMutableArray()
        self.BAckUpArray = self.ScannedQRArray
        
        self.HistoryTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ReloadTable), name: NSNotification.Name(rawValue: "ReloadTable"), object: nil)
        self.HistoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.ScannedQRArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        if(self.ScannedQRArray.count>indexPath.row)
        {
//            cell.textLabel?.font = SwiftFunctions.GetCustomBodyFont(EngFontNumber: 12, ArFontNumber: 22)
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.textColor = UIColor.white
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textAlignment = .left
            

            
            if var GlobalDic = self.ScannedQRArray[indexPath.row] as? NSDictionary{
            let GlobalString = NSMutableAttributedString(string: "" )


                cell.textLabel?.font = SwiftFunctions.GetCustomTitleSemiBoldBodyFont(EngFontNumber: 14,ArFontNumber:15)
                
            if((GlobalDic.object(forKey: "SalesMan") as? String ?? "" ) != "")
            {
                var CONTENTS = "SalesMan: \(GlobalDic.object(forKey: "SalesMan") as? String ?? "" ) "
                var Key =  (GlobalDic.object(forKey: "SalesMan") as? String ?? "" )
                var range = (CONTENTS as NSString).range(of: Key)
                let myString = NSMutableAttributedString(string: CONTENTS)
                myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 137.0/255.0, green: 147.0/255.0, blue: 158.0/255.0, alpha: 1.0) , range: range)
                myString.addAttribute(NSAttributedString.Key.font, value: SwiftFunctions.GetCustomBodyFont(EngFontNumber: 14,ArFontNumber:15) , range: range)
                
                GlobalString.append(myString)
            }
            if((GlobalDic.object(forKey: "PhoneNo") as? String ?? "" ) != "")
            {
                var CONTENTS = "\nPhoneNo: \(GlobalDic.object(forKey: "PhoneNo") as? String ?? "" ) "
                var Key =  (GlobalDic.object(forKey: "PhoneNo") as? String ?? "" )
                var range = (CONTENTS as NSString).range(of: Key)
                let myString = NSMutableAttributedString(string: CONTENTS)
                myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 137.0/255.0, green: 147.0/255.0, blue: 158.0/255.0, alpha: 1.0) , range: range)
                myString.addAttribute(NSAttributedString.Key.font, value: SwiftFunctions.GetCustomBodyFont(EngFontNumber: 14,ArFontNumber:15) , range: range)
                
                GlobalString.append(myString)
            }
//
                if(((GlobalDic.object(forKey: "Valid")) != nil))
                {
                   
                    var CONTENTS = "\nValid: " + (GlobalDic.object(forKey: "ErrorDesc") as? String ?? "")
                    var Key =  (GlobalDic.object(forKey: "ErrorDesc")) as? String ?? ""
                    var range = (CONTENTS as NSString).range(of: Key)
                    let myString = NSMutableAttributedString(string: CONTENTS)
                    myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 137.0/255.0, green: 147.0/255.0, blue: 158.0/255.0, alpha: 1.0) , range: range)
                    myString.addAttribute(NSAttributedString.Key.font, value: SwiftFunctions.GetCustomBodyFont(EngFontNumber: 14,ArFontNumber:15) , range: range)
                    
                    GlobalString.append(myString)
                }
                
                if((GlobalDic.object(forKey: "Date") as? String ?? "" ) != "")
                {
                    var CONTENTS = "\nDate: " + (GlobalDic.object(forKey: "Date") as? String ?? "")
                    var Key =  (GlobalDic.object(forKey: "Date") as? String ?? "")
                    var range = (CONTENTS as NSString).range(of: Key)
                    let myString = NSMutableAttributedString(string: CONTENTS)
                    myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 137.0/255.0, green: 147.0/255.0, blue: 158.0/255.0, alpha: 1.0) , range: range)
                    myString.addAttribute(NSAttributedString.Key.font, value: SwiftFunctions.GetCustomBodyFont(EngFontNumber: 14,ArFontNumber:15) , range: range)
                    
                    GlobalString.append(myString)
                }

//                    }
                cell.textLabel?.attributedText = GlobalString
//
               
            }
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       
        return 0
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
            //        let delivery = self.deliveriesFiltered[indexPath.row]
            //
            //        if(delivery.Update=="1")
            //        {
            //            if((self.deliveriesFiltered.count-1)==indexPath.row)
            //            {
            //                self.OpenMapsButton.isHidden=true
            //            }
            //            if(isDelivered==false)
            //            {
            let marksAsDevlivered = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                
                
//                var DeleteDictionary = self.IdentifiedFacesArray[indexPath.section] as? NSDictionary ?? NSDictionary()
//

                self.ScannedQRArray.removeObject(at: indexPath.row)
                self.BAckUpArray = self.ScannedQRArray
                
                var SavedSearchesArray =  (self.ScannedQRArray.reversed() as NSArray).mutableCopy() as! NSMutableArray
                DatabaseCalls.SaveDataToLocal(WordId: "ScannedQR", DataArray: SavedSearchesArray)
                

                self.HistoryTableView.reloadData()
                
                
                
            })
            //                marksAsDevlivered.image =  UIGraphicsImageRenderer(size:CGSize(width: 30, height: 30)).image { _ in
            //                    UIImage(named:"delivered_icn")?.draw(in: CGRect(x: 0, y: 0, width: 30, height: 30))
            //                }
            marksAsDevlivered.backgroundColor = .red
            //
            //                let more = UIContextualAction(style: .normal, title:  "More", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            //                    let delivery = self.deliveriesFiltered[indexPath.row]
            //                    self.deliverySelected = delivery
            //                    self.moreClick()
            //                    success(true)
            //                })
            //
            //                more.image =   UIGraphicsImageRenderer(size:CGSize(width: 30, height: 30)).image { _ in
            //                    UIImage(named:"more_icn")?.draw(in: CGRect(x: 0, y: 0, width: 30, height: 30))
            //                }
            //                more.backgroundColor = .greyColor
            
            //                return UISwipeActionsConfiguration(actions: [more, marksAsDevlivered])
            return UISwipeActionsConfiguration(actions: [marksAsDevlivered])
            //            }
            //            else{
            //                let more = UIContextualAction(style: .normal, title:  "More", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            //                    let delivery = self.deliveriesFiltered[indexPath.row]
            //                    self.deliverySelected = delivery
            //                    self.moreClick()
            //                    success(true)
            //                })
            //
            //                more.image =   UIGraphicsImageRenderer(size:CGSize(width: 30, height: 30)).image { _ in
            //                    UIImage(named:"more_icn")?.draw(in: CGRect(x: 0, y: 0, width: 30, height: 30))
            //                }
            //                more.backgroundColor = .greyColor
            //
            //                return UISwipeActionsConfiguration(actions:  [more])
            //            }
            //        }
            //        else{
            //            return UISwipeActionsConfiguration(actions:  [])
            //        }
            
        }
    
    
    @objc func ReloadTable(notification : NSNotification)
    {
        self.ScannedQRArray = DatabaseCalls.GetDataFromLocal(WordId: "ScannedQR") as! NSMutableArray
        self.ScannedQRArray = (self.ScannedQRArray.reversed() as NSArray).mutableCopy() as! NSMutableArray
        self.BAckUpArray = self.ScannedQRArray
        self.HistoryTableView.reloadData()
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
