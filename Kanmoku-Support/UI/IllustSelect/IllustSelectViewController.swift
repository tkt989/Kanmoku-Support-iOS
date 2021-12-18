// 
//  IllustSelectViewController.swift
//  Kanmoku-Support
//
//  Created by tkt989 on 2018/04/14.
//  Copyright © 2018年 tkt989. All rights reserved.
//

import UIKit
import SwiftUI

private let reuseIdentifier = "Cell"

class IllustSelectViewController: UICollectionViewController {
    let images = [
        "face1",
        "face2",
        "face3",
        "face4",
        "face5",
        "face6",
        "face7",
        "face8",
        "face9",
        "illust10",
        "illust11"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! IllustCell

        let imageName = images[indexPath.row]
        cell.illustView.image = UIImage(named: imageName)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let cell = collectionView.cellForItem(at: indexPath) as! IllustCell
        
        let vc = ShowDrawingView.uiHostingController(image: cell.illustView.image)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        return true
    }
}
