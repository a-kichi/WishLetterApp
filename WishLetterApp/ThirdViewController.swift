//
//  ThirdViewController.swift
//  WishLetterApp
//
//  Created by あーきち on 2020/02/25.
//  Copyright © 2020 あーきち. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate,UIScrollViewDelegate{

    @IBOutlet var profileImage: UIImageView!

    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var birthdayTextField: UITextField!
    @IBOutlet var goalTextField: UITextField!
    
    @IBOutlet var profileScrollView: UIScrollView!
    
    var profileSaveData: UserDefaults = UserDefaults.standard
    
    var userName: String!
    var birthday: String!
    var goal: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userNameTextField.delegate = self
        birthdayTextField.delegate = self
        goalTextField.delegate = self
        profileScrollView.delegate = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureObserver()
        print(profileSaveData)
        if profileSaveData.object(forKey: "profileSaveData") != nil {
            profileImage.image = profileSaveData.object(forKey: "profileSaveData") as? UIImage
        }
        
        if profileSaveData.object(forKey: "userName") != nil {
            userName = (profileSaveData.object(forKey: "sentDate") as? String)
            birthday  = (profileSaveData.object(forKey: "birthday") as? String)
            goal = (profileSaveData.object(forKey: "goal") as? String)
        }
    }
    
    //リターンキー
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func toUpdateProfileButton(_ sender: Any) {
        
        userName = userNameTextField.text
        birthday = birthdayTextField.text
        goal = goalTextField.text
        
        profileSaveData.set(userName, forKey: "userName")
        profileSaveData.set(birthday, forKey: "birthday")
        profileSaveData.set(goal, forKey: "gaol")

        let alert: UIAlertController = UIAlertController(title: "更新完了！",message: "",preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(
                title:"OK",
                style: .default, handler:{ action in
                print("更新")
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
  
    //ImageViewTapAction
    @IBAction func TapImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let ImagePicker = UIImagePickerController()
            ImagePicker.sourceType = .photoLibrary
            ImagePicker.delegate = self
   
            ImagePicker.allowsEditing = true
   
            present(ImagePicker, animated: true, completion: nil)
   
        }
   
    }
    //画像表示
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileImage.image = info[.editedImage]as? UIImage
        // UserDefaultsへ保存
        profileSaveData.setUIImageToData(image: profileImage.image!, forKey: "profileSaveData")
        dismiss(animated: true, completion: nil)
   
    }

    
    // Notificationを設定
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
      
    // Notificationを削除
    func removeObserver() {
      NotificationCenter.default.removeObserver(self)
    }
      
    // キーボードが現れたときにviewをずらす
    @objc func keyboardWillShow(notification: Notification?) {
        _ = (notification?.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
      let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
      UIView.animate(withDuration: duration!) {
        self.view.transform = CGAffineTransform(translationX: 0, y: -100)
      }
    }
      
    // キーボードが消えたときにviewを戻す
    @objc func keyboardWillHide(notification: Notification?) {
      let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double
      UIView.animate(withDuration: duration!) {
        self.view.transform = CGAffineTransform.identity
      }
    }
    
}

extension UserDefaults {
    // 保存したいUIImage, 保存するUserDefaults, Keyを取得
    func setUIImageToData(image: UIImage, forKey: String) {
        // UIImageをData型へ変換
        let nsdata = image.pngData()
        // UserDefaultsへ保存
        self.set(nsdata, forKey: forKey)
    }
    // 参照するUserDefaults, Keyを取得, UIImageを返す
    func image(forKey: String) -> UIImage {
        // UserDefaultsからKeyを基にData型を参照
        let data = self.data(forKey: forKey)
        // UIImage型へ変換
        let returnImage = UIImage(data: data!)
        // UIImageを返す
        return returnImage!
    }

}
