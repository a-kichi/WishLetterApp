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
    var notificationIDArray: [String] = []
    
    var getNumber : Int!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if saveData.object(forKey: "sentDate") != nil {
            sentDateArray  = saveData.object(forKey: "sentDate") as! [Date]
            letterTextArray  = saveData.object(forKey: "letterText") as! [String]
            spanArray = saveData.object(forKey: "span") as! [Int]
            notificationIDArray = saveData.object(forKey: "notificationID") as! [String]
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(getNumber as Int)
        if getNumber != nil{
            print(sentDateArray[getNumber!])
            dearLabel.text = "\(dateString(date: sentDateArray[getNumber!] as NSDate))の自分から届きました"
            receiveTextView.text = letterTextArray[getNumber!]
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
