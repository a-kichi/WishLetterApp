//
//  ViewController.swift
//  WishLetterApp
//
//  Created by あーきち on 2020/02/28.
//  Copyright © 2020 あーきち. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet var selectTextField: UITextField!
    
    @IBOutlet var writeTextView: UITextView!
    
    var saveData: UserDefaults = UserDefaults.standard
    
    var letterArray:[String] = []
    
    var index = 1
    
    //タプル
    var letter = (date: Date, text:String, notification: Int, notificationID: String).self
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectTextField.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if saveData.object(forKey: "letter") != nil {
            letterArray = saveData.object(forKey: "letter")as! [String]
        }
    }

    
    @IBAction func toSendButton(){
        index += 1
        //letter[index].プロパティにいろいろ出てくる
        
        letterArray.append(writeTextView.text!)
        saveData.set(letterArray, forKey:"letter")
        //print(index)
        dismiss(animated: true, completion: nil)
         
        print(writeTextView.text!)
    }



}
