//
//  Mobile.swift
//  PRJ_IOS_TEAM3
//
//  Created by CNTT on 5/26/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//

import UIKit
//0. Table MobiPhone
struct MobiPhone {
    let MobiphoneSectionType:String
    let MobiPhoneImage:[String]
    let MoBiPhoneName:[String]
    let MoBiPhonePrice:[String]
}
//1. Table Product
class PRODUCT {
    //MARK: Properties
    var ProductID:Int
    var ProductName:String
    let ProductImage:UIImage?
    var ProductRating:Int
    var Product_ProtypeID:Int
    var Product_description:String
    
    
    
    //MARK: Constructors
    init?(ProductID:Int, ProductName:String, ProductImage:UIImage, ProductRating:Int, Product_ProtypeID:Int, Product_description:String) {
        if Product_description.isEmpty {
            return nil
        }
        if ProductName.isEmpty {
            return nil
        }
        if ProductRating < 0 || ProductRating > 5 {
            return nil
        }
        self.ProductID = ProductID
        self.ProductName = ProductName
        self.ProductImage = ProductImage
        self.ProductRating = ProductRating
        self.Product_ProtypeID = Product_ProtypeID
        self.Product_description = Product_description
    }
    
}
class PROTYPE {
    //MARK: Properties
    var ProtypeID:Int
    var ProtypeName:String
    //MARK: Constructors
    init?(ProtypeID:Int, ProtypeName:String){
        if ProtypeName.isEmpty {
            return nil
        }
        self.ProtypeID = ProtypeID
        self.ProtypeName = ProtypeName
    }
}
class USER {
    //MARK: Properties
    var UserName:String
    var UserID:Int
    var UserPass:String
    //MARK: Constructors
    init?(UserName:String, UserID:Int, UserPass:String){
        if UserName.isEmpty {
            return nil
        }
        self.UserName = UserName
        self.UserID = UserID
        self.UserPass = UserPass
    }
}





