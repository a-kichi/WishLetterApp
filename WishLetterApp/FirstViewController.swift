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
    var letterArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        writtenTable.dataSource = self
        writtenTable.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
        if saveData.object(forKey: "letter") != nil{
            letterArray = saveData.object(forKey: "letter") as! [String]
        }
        
        writtenTable.reloadData()
        
    }
    
    //追加ボタン
    @IBAction func toWriteButton(){
        
    }
    
    func tableView(_ writtenTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return letterArray.count
    }
    
    func tableView(_ writtenTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = writtenTable.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = letterArray[indexPath.row]
        return cell!
    }

    func tableView(_ writtenTable: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    //削除 後から消す
    func tableView(_ writtenTableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            letterArray.remove(at: indexPath.row)
            writtenTable.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
        saveData.set(letterArray, forKey: "letter")
    }

}

