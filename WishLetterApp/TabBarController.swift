//
//  TabBarController.swift
//  WishLetterApp
//
//  Created by あーきち on 2020/02/25.
//  Copyright © 2020 あーきち. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //アイコンの色
        UITabBar.appearance().tintColor = UIColor(red: 255/255, green: 224/255, blue: 218/255, alpha: 1.0)

        // 背景色
        UITabBar.appearance().barTintColor = UIColor(red: 254/255, green: 252/255, blue: 211/255, alpha: 1.0)


        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
