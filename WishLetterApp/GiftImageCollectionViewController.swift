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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func toBackWritePageButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
