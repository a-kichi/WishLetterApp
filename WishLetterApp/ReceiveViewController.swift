//
//  ReceiveViewController.swift
//  WishLetterApp
//
//  Created by あーきち on 2020/03/02.
//  Copyright © 2020 あーきち. All rights reserved.
//

import UIKit

class ReceiveViewController: UIViewController {

    @IBOutlet var dearLabel: UILabel!
    
    @IBOutlet var giftImageView: UIImageView!
    
    @IBOutlet var receiveTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func readButton(){
        
        dismiss(animated: true, completion: nil)
    }
}
