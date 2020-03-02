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
    
    //セル
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return letterTextArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = receiveTable.dequeueReusableCell(withIdentifier: "Cell")
        
        //表示したいものだけを表示させるif文
        //textLabelに表示したいものだけを
        cell?.textLabel?.text = letterTextArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番")
        //画面遷移
        performSegue(withIdentifier: "toReceiveViewController", sender: nil)
        //セル選択を解除
        receiveTable.deselectRow(at: indexPath, animated: true)
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

