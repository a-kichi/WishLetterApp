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
    var notificationIDArray: [String] = []
    
    var tapCellNumber :Int?
    
    var receiveTextArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if saveData.object(forKey: "sentDate") != nil {
            sentDateArray  = saveData.object(forKey: "sentDate") as! [Date]
            letterTextArray  = saveData.object(forKey: "letterText") as! [String]
            spanArray = saveData.object(forKey: "span") as! [Int]
            notificationIDArray = saveData.object(forKey: "notificationID") as! [String]
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
    
    
    //ローカル通知
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // notification center (singleton)
        let center = UNUserNotificationCenter.current()

        // ユーザに通知の許可を求める
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Allowed")
            } else {
                print("Didn't allowed")
            }
        }

        return true
    }
    
    @IBAction func setNotification(_ sender: UIButton) {

        //かえる
        let seconds = 10

        // 通知の発行: タイマーを指定して発行

        // content
        let content = UNMutableNotificationContent()
        content.title = "タイトル"
        content.body = "ボディ文"

        // trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(seconds),
                                                        repeats: false)

        // request includes content & trigger
        let request = UNNotificationRequest(identifier: "TIMER\(seconds)",
                                            content: content,
                                            trigger: trigger)

        // schedule notification by adding request to notification center
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

}

