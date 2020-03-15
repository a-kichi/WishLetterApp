//
//  GiftImageCollectionViewController.swift
//  WishLetterApp
//
//  Created by あーきち on 2020/03/10.
//  Copyright © 2020 あーきち. All rights reserved.
//

import UIKit

class GiftImageCollectionViewController: UIViewController{

    let photos = ["cake.png", "coffee.png", "present.png", "trip.png", "dog.png"]
    
    var imageInfo: Int!
    
    @IBOutlet var cakeImageView: UIImageView!
    @IBOutlet var coffeeImageView: UIImageView!
    @IBOutlet var presentImageView: UIImageView!
    @IBOutlet var tripImageView: UIImageView!
    @IBOutlet var dogImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         cakeImageView.isUserInteractionEnabled = true
         coffeeImageView.isUserInteractionEnabled = true
         presentImageView.isUserInteractionEnabled = true
         tripImageView.isUserInteractionEnabled = true
         dogImageView.isUserInteractionEnabled = true
    }

    
    @IBAction func toBackWritePageButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //imageViewタップしたら
    //値渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "toGiftImageViewController" {
            //let nextVC: ViewController = (segue.destination as? ViewController)!
            //nextVC.imageNumber = imageInfo
        }
    }
    

}
