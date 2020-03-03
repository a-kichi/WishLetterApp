//
//  FirstViewController.swift
//  WishLetterApp
//
//  Created by あーきち on 2020/02/25.
//  Copyright © 2020 あーきち. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITextFieldDelegate, UITableViewDelegate{

    @IBOutlet var writtenTable : UITableView!
    
    var saveData: UserDefaults = UserDefaults.standard
    
    var index :Int!
    
    //タプル
    //var letterArray:[Any] = []
    //var letter:[(date: Date, text:String, notification: Int, notificationID: String)] = []
    
    var sentDateArray: [Date] = []
    var letterTextArray: [String] = []
    var spanArray: [Int] = []
    var receiveDateArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        writtenTable.dataSource = self
        writtenTable.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
        if saveData.object(forKey: "sentDate") != nil {
            sentDateArray  = saveData.object(forKey: "sentDate") as! [Date]
            letterTextArray  = saveData.object(forKey: "letterText") as! [String]
            spanArray = saveData.object(forKey: "span") as! [Int]
            receiveDateArray = saveData.object(forKey: "receiveDate") as! [String]
        }
        
        writtenTable.reloadData()

        print(sentDateArray)
        
    }
    
    
    private func dateString(date: NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        dateFormatter.dateFormat = "yyyy年MM月dd日 "
        let dateString: String = dateFormatter.string(from: date as Date)
        return dateString
    }
    
    //追加ボタン
    @IBAction func toWriteButton(){
        performSegue(withIdentifier: "toViewController", sender: nil)

    }
    
    func tableView(_ writtenTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return letterTextArray.count
    }
    
    func tableView(_ writtenTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = writtenTable.dequeueReusableCell(withIdentifier: "Cell")
        //--の自分へにしたい
        cell?.textLabel?.text = "\(receiveDateArray[indexPath.row])の自分へ"
        return cell!
    }

    func tableView(_ writtenTable: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    //削除 後から消す
    func tableView(_ writtenTableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            sentDateArray.remove(at: indexPath.row)
            letterTextArray.remove(at: indexPath.row)
            spanArray.remove(at: indexPath.row)
            receiveDateArray.remove(at: indexPath.row)
            
            writtenTable.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
        
        saveData.set(sentDateArray, forKey: "sentDate")
        saveData.set(letterTextArray, forKey: "letterText")
        saveData.set(spanArray, forKey: "span")
        saveData.set(receiveDateArray, forKey: "receiveDate")
    }
    
//しめ
}

extension FirstViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {

        self.writtenTable.reloadData()
    }
}
