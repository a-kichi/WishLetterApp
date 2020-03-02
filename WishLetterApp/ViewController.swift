//
//  ViewController.swift
//  WishLetterApp
//
//  Created by あーきち on 2020/02/28.
//  Copyright © 2020 あーきち. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIScrollViewDelegate{
    
    @IBOutlet var selectTextField: UITextField!
    
    @IBOutlet var writeTextView: UITextView!
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var giftImageView: UIImageView!
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    @objc func onClickCommitButton (sender: UIButton) {
        if(writeTextView.isFirstResponder){
            writeTextView.resignFirstResponder()
        }
    }
    
    var saveData: UserDefaults = UserDefaults.standard
    
    var index = 0
    
    //タプル
    //var letters:[(sentdate: Date, text:String, span: Int, notificationID: String)] = []
    var sentDateArray: [Date] = []
    var letterTextArray: [String] = []
    var spanArray: [Int] = []
    var notificationIDArray: [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if saveData.object(forKey: "sentDate") != nil {
            sentDateArray  = saveData.object(forKey: "sentDate") as! [Date]
            letterTextArray  = saveData.object(forKey: "letterText") as! [String]
            spanArray = saveData.object(forKey: "span") as! [Int]
            notificationIDArray = saveData.object(forKey: "notificationID") as! [String]
        }
        
        if saveData.object(forKey: "index") != nil {
            index = saveData.object(forKey: "index") as! Int
            
        }
        
        self.configureObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectTextField.delegate = self
        scrollView.delegate = self
        
        
        //完了ボタン
        let custombar = UIView(frame: CGRect(x:0, y:0,width:(UIScreen.main.bounds.size.width),height:40))
        custombar.backgroundColor = UIColor.lightGray
        let commitBtn = UIButton(frame: CGRect(x:(UIScreen.main.bounds.size.width)-50,y:0,width:50,height:40))
        commitBtn.setTitle("完了", for: .normal)
        commitBtn.setTitleColor(UIColor.darkGray, for:.normal)
        commitBtn.addTarget(self, action:#selector(ViewController.onClickCommitButton), for: .touchUpInside)
        custombar.addSubview(commitBtn)
        writeTextView.inputAccessoryView = custombar
        writeTextView.keyboardType = .default
        writeTextView.delegate = self
        
        // ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        selectTextField.inputView = datePicker
        
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        // テキストフィールドに代入
        selectTextField.inputView = datePicker
        selectTextField.inputAccessoryView = toolbar
        
    }

    
    @IBAction func toSendButton(){
        
        //現在を取得
        let sentDate = Date()
        //選択した日付
        let receive = datePicker.date
        //差分を出す
        let span = receive.timeIntervalSince(sentDate)
        //各タプル
        //let letter = (sentdate: sentDate, text:writeTextView.text!, span: Int(span), notificationID: String(index))
        
        //各配列
        sentDateArray.append(sentDate)
        letterTextArray.append(writeTextView.text)
        spanArray.append(Int(span))
        notificationIDArray.append(String(index))
        
        index += 1
        saveData.set(index, forKey:"index")

        
        saveData.set(sentDateArray, forKey: "sentDate")
        saveData.set(letterTextArray, forKey: "letterText")
        saveData.set(spanArray, forKey: "span")
        saveData.set(notificationIDArray, forKey: "notificationID")
        
        dismiss(animated: true, completion: nil)

    }
    
    
    //リターン押したら消える
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
    }
    
    // キーボードのNotification設定
    func configureObserver() {
          
      let notification = NotificationCenter.default

      notification.addObserver(
        self,
        selector: #selector(self.keyboardWillShow(notification:)),
        name: UIResponder.keyboardWillShowNotification,
        object: nil
      )
          
      notification.addObserver(
        self,
        selector: #selector(self.keyboardWillHide(notification:)),
        name: UIResponder.keyboardWillHideNotification,
        object: nil
      )
    }
    
    //キーボードの設定
      // Notificationの削除
      func removeObserver() {
        NotificationCenter.default.removeObserver(self)
      }
        
      // キーボード現れたとき
      @objc func keyboardWillShow(notification: Notification?) {
        _ = (notification?.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: duration!) {
          self.view.transform = CGAffineTransform(translationX: 0, y: -150)
        }
      }
        
      // キーボード消えたとき
      @objc func keyboardWillHide(notification: Notification?) {
        let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!) {
          self.view.transform = CGAffineTransform.identity
        }
      }
    
    // 決定ボタン押下
    @objc func done() {
        selectTextField.endEditing(true)
        
        // 日付のフォーマット
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        selectTextField.text = "\(formatter.string(from: datePicker.date))"
    }

}

extension ViewController {
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        guard let presentationController = presentationController else { return }
        if #available(iOS 13, *) {
            presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
        }
    }
}
