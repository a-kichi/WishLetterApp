//
//  ReceiveViewController.swift
//  WishLetterApp
//
//  Created by あーきち on 2020/03/02.
//  Copyright © 2020 あーきち. All rights reserved.
//

import UIKit

class ReceiveViewController: UIViewController {

    @IBOutlet var dearLabel: UILabel!
    
    @IBOutlet var giftImageView: UIImageView!
    
    @IBOutlet var receiveTextView: UITextView!
    
    var saveData: UserDefaults = UserDefaults.standard
    
    var sentDateArray: [Date] = []
    var letterTextArray: [String] = []
    var spanArray: [Int] = []
    var receiveDateArray: [String] = []
    
    var getInfo : Letter!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if saveData.object(forKey: "sentDate") != nil {
            sentDateArray  = saveData.object(forKey: "sentDate") as! [Date]
            letterTextArray  = saveData.object(forKey: "letterText") as! [String]
            spanArray = saveData.object(forKey: "span") as! [Int]
            receiveDateArray = saveData.object(forKey: "receiveDate") as! [String]
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if getInfo != nil{
            dearLabel.text = "\(dateString(date: getInfo.sentDate as NSDate))の自分から届きました"
            receiveTextView.text = getInfo.letterText
        }
    }
    
    private func dateString(date: NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        dateFormatter.dateFormat = "yyyy年MM月dd日 "
        let dateString: String = dateFormatter.string(from: date as Date)
        return dateString
    }
    
    
    @IBAction func readButton(){
        
        dismiss(animated: true, completion: nil)
    }
}
