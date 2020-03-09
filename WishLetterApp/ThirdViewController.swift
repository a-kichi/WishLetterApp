//
//  ThirdViewController.swift
//  WishLetterApp
//
//  Created by あーきち on 2020/02/25.
//  Copyright © 2020 あーきち. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController,UIImagePickerControllerDelegate , UINavigationControllerDelegate , UITextFieldDelegate{

    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var UserNameTextField: UITextField!
    
    @IBOutlet var birthdayTextField: UITextField!
    
    @IBOutlet var goalTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UserNameTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //リターンキー
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
    
}
