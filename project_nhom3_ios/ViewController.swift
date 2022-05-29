//
//  ViewController.swift
//  project_nhom3_ios
//
//  Created by CNTT on 5/27/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var ClectionView: UICollectionView!
    var currentcellIndex = 0
    var Image = ["iphone-13-pro-max-sierra-blue-600x600","msi-gaming-ge66-raider-11ug-i7-258vn-600x600","Samsung-Galaxy-tab-s8-black-thumb-600x600"]
    var timer:Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
    }
    @objc func slideToNext(){
        if currentcellIndex < Image.count-1 {
            currentcellIndex = currentcellIndex + 1
        }
        else{
            currentcellIndex = 0
        }
        
        ClectionView.scrollToItem(at: IndexPath(item: currentcellIndex, section: 0), at: .right, animated: true)
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyColection
        cell.MyImage.image = UIImage(named: Image[indexPath.row])
        return cell
    }
    func collectionView(_ ColectionView: UICollectionView, layout ColectionViewlayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)  -> CGSize {
        return CGSize(width: ColectionView.frame.width, height: ColectionView.frame.height)
    }
    
    
}

