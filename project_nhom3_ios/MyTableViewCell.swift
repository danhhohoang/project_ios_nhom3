//
//  MyTableViewCell.swift
//  project_nhom3_ios
//
//  Created by CNTT on 5/30/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    
    @IBOutlet var MyCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        MyCollectionView.delegate = self
        MyCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension MyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MoBilePhone[MyCollectionView.tag].MobiPhoneImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MyCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! MoBiPhoneViewCell
        cell.MyImage.image = UIImage(named: MoBilePhone[MyCollectionView.tag].MobiPhoneImage[indexPath.row])
        cell.Label1.text = MoBilePhone[MyCollectionView.tag].MoBiPhoneName[indexPath.row]
        cell.Label2.text = MoBilePhone[MyCollectionView.tag].MoBiPhoneName[indexPath.row]
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.5
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("YOU HAVE CLICK ON PRODUCT\(MoBilePhone[MyCollectionView.tag].MoBiPhoneName[indexPath.row])")
    }
    
}

