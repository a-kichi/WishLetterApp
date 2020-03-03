//
//  SecondViewController.swift
//  WishLetterApp
//
//  Created by あーきち on 2020/02/25.
//  Copyright © 2020 あーきち. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet var receiveTable: UITableView!
    
    var saveData: UserDefaults = UserDefaults.standard
    
    var sentDateArray: [Date] = []
    var letterTextArray: [String] = []
    var spanArray: [Int] = []
    var receiveDateArray: [String] = []
    
    var tapCellNumber :Int?
    
    var receiveTextArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if saveData.object(forKey: "sentDate") != nil {
            sentDateArray  = saveData.object(forKey: "sentDate") as! [Date]
            letterTextArray  = saveData.object(forKey: "letterText") as! [String]
            spanArray = saveData.object(forKey: "span") as! [Int]
            receiveDateArray = saveData.object(forKey: "receiveDate") as! [String]
        }
        
        receiveTable.dataSource = self
        receiveTable.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //DateをStringにしてる
    private func dateString(date: NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        dateFormatter.dateFormat = "yyyy年MM月dd日 "
        let dateString: String = dateFormatter.string(from: date as Date)
        return dateString
    }
    //セル
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //firstIndex=差分を超えた要素の配列番号
        if let firstIndex = spanArray.firstIndex(where: {$0 <= 0}) {
            print("インデックス番号: \(firstIndex)が差分を超えたもの")
            receiveTextArray = [letterTextArray[firstIndex]]
        }
        
        print(receiveTextArray.count)
        return receiveTextArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = receiveTable.dequeueReusableCell(withIdentifier: "Cell")

        cell?.textLabel?.text = "\(dateString(date: sentDateArray[indexPath.row] as NSDate))から届きました"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          print("\(indexPath.row)が選択されました")
            //タップしたセル番号をtapCellNumberとして値わたし
            tapCellNumber = indexPath.row
            //画面遷移
            performSegue(withIdentifier: "toReceiveViewController", sender: nil)
            //セル選択を解除
            tableView.deselectRow(at: indexPath, animated: true)
          }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
            if segue.identifier == "toReceiveViewController" {
                let nextVC: ReceiveViewController = (segue.destination as? ReceiveViewController)!
                nextVC.getNumber = tapCellNumber
            }
        }
    
}

