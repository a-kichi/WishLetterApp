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
    
    var  letterArray:[String] = []
    
    var saveData: UserDefaults = UserDefaults.standard
    
    var index = 1
    
    var letter = (date: Date, text:String, notification: Int, notificationID: String).self
    
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

}

