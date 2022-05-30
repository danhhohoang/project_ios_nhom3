//
//  ViewController.swift
//  project_nhom3_ios
//
//  Created by CNTT on 5/27/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit

let MoBilePhone = [
    MobiPhone(MobiphoneSectionType: "MoBile Phone",MobiPhoneImage: ["Galaxy-S22","iphone-13","iphone-xi"], MoBiPhoneName: ["Galaxy-S22","iphone-13","iphone-xi"], MoBiPhonePrice: ["33.990.000d","40.990.000d","12.990.000d"]),
    
    MobiPhone(MobiphoneSectionType: "MoBile Phone",MobiPhoneImage: ["OPPOReno7-cam","opporeno75g","realme-c35"], MoBiPhoneName: ["OPPOReno7-cam","opporeno75g","realme-c35"], MoBiPhonePrice: ["8.490.000d","10.490.000d","3.990.000d"]),
    
    MobiPhone(MobiphoneSectionType: "MoBile Phone",MobiPhoneImage: ["Xiaomi-11T","redmi-note-11","redmi-note-11s"], MoBiPhoneName: ["Xiaomi-11T","redmi-note-11","redmi-note-11s"], MoBiPhonePrice: ["10.990.000d","7.490.000d","6.290.000d"]),
]
class ViewController: UIViewController {
    
    @IBOutlet var MyTable: UITableView!
    //
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
        
        //ClectionView.scrollToItem(at: IndexPath(item: currentcellIndex, section: 0), at: .right, animated: true)
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
//
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let Cell = MyTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        Cell.MyCollectionView.tag = indexPath.section
        Cell.MyCollectionView.reloadData()
        return Cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return MoBilePhone.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return MoBilePhone[section].MobiphoneSectionType
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .yellow
    }
}
    


