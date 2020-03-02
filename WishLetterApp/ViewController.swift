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
    //var letterArray:[Any] = []
    //var letter:[(date: Date, text:String, notification: Int, notificationID: String)] = []
    var letterArray:[String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if saveData.object(forKey: "letter") != nil {
            letterArray = saveData.object(forKey: "letter") as! [String]
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
        index += 1
        letterArray.append(writeTextView.text)
        saveData.set(letterArray, forKey:"letter")
        //print(index)
        dismiss(animated: true, completion: nil)
         
        print(index)
    }
    
    
    //リターン押したら消える
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
    }
    
    // Notification設定
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
