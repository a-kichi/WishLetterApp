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
    
    var tapCellInfo :Letter!
    
    var receiveTextArray: [String] = []
    
    var letterArray: [Letter] = []
    
    let letterInfo: (sentdate: Date, text: String, span: Int, receivedate: String)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receiveTable.dataSource = self
        receiveTable.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        letterArray.removeAll()
        if saveData.object(forKey: "sentDate") != nil {
            sentDateArray  = saveData.object(forKey: "sentDate") as! [Date]
            letterTextArray  = saveData.object(forKey: "letterText") as! [String]
            spanArray = saveData.object(forKey: "span") as! [Int]
            receiveDateArray = saveData.object(forKey: "receiveDate") as! [String]
        }
        
        // まとめる
        // からの配列つくる
        // UserDefaultsから取り出した４つの配列をまとめる
        //配列番号０チームをまとめ直した
        for letterIndex in 0 ..< spanArray.count{
            let date = sentDateArray[letterIndex]
            let text = letterTextArray[letterIndex]
            let span = spanArray[letterIndex]
            let receiveDate = receiveDateArray[letterIndex]
            
            let letterInfo = Letter(sentDate: date, letterText: text, span: span, receiveDate: receiveDate)
            
            //letterArrayは０番０チームの配列
            letterArray.append(letterInfo)
        }
        
        receiveTable.reloadData()
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
        //if let firstIndex = spanArray.firstIndex(where: {$0 <= 0}) {
        //    receiveTextArray = [letterTextArray[firstIndex]]
        //}
        let t = spanArray.filter({$0 <= 0})
        return t.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = receiveTable.dequeueReusableCell(withIdentifier: "Cell")
        
        let sortedLetterArray = letterArray.sorted(by: {(a, b) -> Bool in
            return a.span < b.span
        })

        cell?.textLabel?.text = "\(dateString(date: sortedLetterArray[indexPath.row].sentDate as NSDate))から届きました"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)が選択されました")
        //タップしたセル番号をtapCellNumberとして値わたし
        tapCellInfo = letterArray[indexPath.row]
        //画面遷移
        performSegue(withIdentifier: "toReceiveViewController", sender: nil)
        //セル選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "toReceiveViewController" {
            let nextVC: ReceiveViewController = (segue.destination as? ReceiveViewController)!
            nextVC.getInfo = tapCellInfo
        }
    }
    
}

