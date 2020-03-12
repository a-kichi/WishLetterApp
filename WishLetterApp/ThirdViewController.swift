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
    }
    
    //リターンキー
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func toUpdateProfileButton(_ sender: Any) {
        
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
      let rect = (notification?.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
      let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
      UIView.animate(withDuration: duration!) {
        self.view.transform = CGAffineTransform(translationX: 0, y: -(rect?.size.height)!)
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
