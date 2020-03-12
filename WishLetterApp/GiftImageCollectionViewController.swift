//
//  GiftImageCollectionViewController.swift
//  WishLetterApp
//
//  Created by あーきち on 2020/03/10.
//  Copyright © 2020 あーきち. All rights reserved.
//

import UIKit

class GiftImageCollectionViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {

    let photos = ["cake.png", "coffee.png", "present.png", "trip.png", "dog.png"]
    
    var imageInfo: Int!
    
    @IBOutlet var giftImageCollection: UICollectionView!
    
    
    @IBOutlet var toBackWritePageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        giftImageCollection.dataSource = self
        giftImageCollection.delegate = self

    }
    
    //表示するセルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // "Cell" はストーリーボードで設定したセルのID
        let cell:UICollectionViewCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                               for: indexPath)
        
        // Tag番号を使ってImageViewのインスタンス生成
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        // 画像配列の番号で指定された要素の名前の画像をUIImageとする
        let cellImage = UIImage(named: photos[indexPath.row])
        // UIImageをUIImageViewのimageとして設定
        imageView.image = cellImage
        
        return cell
    }

    //セルタップしたとき
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageInfo = indexPath.item
        // Identifierが"Segue"のSegueを使って画面遷移する関数
        performSegue(withIdentifier: "toGiftImageViewController", sender: nil)
    }

    // 画面遷移先のViewControllerを取得し、データを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGiftImageViewController" {
            let nextvc = segue.destination as! ViewController
            nextvc.selectedImageInfo = imageInfo
        }
    }


}
