//
//  DatabaseLayer.swift
//  PRJ_IOS_TEAM3
//
//  Created by CNTT on 5/26/22.
//  Copyright © 2022 fit.tdc. All rights reserved.
//
import Foundation
import UIKit
import os.log

class DatabaseLayer {
    
    //MARK: Database 's Properties
    private let DB_MOBILE = "mobile.sqlite"
    private let DB_PATH:String?
    private let database: FMDatabase?
    
    //1, Table Product
    private let PRODUCT_TABLE_NAME = "product"
    private let PRODUCT_ID = "ID"
    private let PRODUCT_NAME = "name"
    private let PRODUCT_IMAGE = "Image"
    private let PRODUCT_RATING = "rating"
    private let PRODUCT_PROTYPEID = "proypeId"
    private let PRODUCT_DESCRIPTION = "description"
    //1,1 Table Protype
    private let PROTYPE_TABLE_NAME = "protype"
    private let PROTYPE_PROTYPEID = "protypeId"
    private let PROTYPE_NAME = "_name"
    //1,2 Tale user
    private let USER_TABLE_USERNAME = "user_name"
    private let USER_USERNAME = "user_name"
    private let USER_USERID = "user_Id"
    private let USER_USERPASS = "user_pass"
    
    //MARK: Constructors
    init() {
        let directory: [String] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        //initialiaztion of DB_PATH
        DB_PATH = directory[0] + "/" + DB_MOBILE
        //initialiaztion of DB_Database
        database = FMDatabase(path: DB_PATH)
        if database != nil {
            os_log("the database is created successfully!")
        }
        else{
            os_log("the database isn't created successfully!")
        }
    }
    /////////////////////////////////////////////////////////////////////////////
    //MARK: Datbase 's Primities Definition
    //1.open
    public func open() -> Bool{
        let OK = false
        if let database = database{
            if database.open() {
                os_log("the database is opened successful")
            }
            else{
                os_log("the database isn't opened successful")
            }
        }
        return OK
    }
    //close
    private func close() {
        if let database = database {
            database.close()
        }
    }
    //3. creation table product
    private func tableproduct(){
        //SQL stament defimtion
        let product
            = "CREATE TABLE" + PRODUCT_TABLE_NAME + " ( " + PRODUCT_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, " +
                PRODUCT_NAME + " TEXT," + PRODUCT_IMAGE + " TEXT, " + PRODUCT_RATING + " INTEGER, " + PRODUCT_PROTYPEID + PRODUCT_DESCRIPTION + " TEXT, " + ")"
        if open() {
            //execute the SQL statment
            if database!.executeStatements(product) {
                os_log("The tables are created successful!")
            }
            else {
                os_log("The tables are not created successful!")
            }
            close()
        }
    }
    //4. creation table protype
    private func tableprotype(){
        let protype
            = "CREATE TABLE" + PRODUCT_TABLE_NAME + " ( " + PROTYPE_PROTYPEID + " INTEGER PRIMARY KEY AUTOINCREMENT, " +
                PROTYPE_NAME + " TEXT, " + ")"
        if open() {
            //execute the SQL statment
            if database!.executeStatements(protype) {
                os_log("The tables are created successful!")
            }
            else {
                os_log("The tables are not created successful!")
            }
            close()
        }
    }
    
    /////////////////////////////////////////////////////////////////////////////
    //1. Insert Product
    public func insertProduct(product: PRODUCT) -> Bool {
        var OK = false
        
        //Create the SQL Statement
        let sql = "INSERT INTO \(PRODUCT_TABLE_NAME) (\(PRODUCT_ID), \(PRODUCT_NAME), \(PRODUCT_IMAGE), \(PRODUCT_RATING), \(PRODUCT_PROTYPEID), \(PRODUCT_DESCRIPTION)) VALUES (?, ?, ?, ?, ?, ?, ?)"
        if open() {
            if database!.tableExists(PRODUCT_TABLE_NAME) {
                //Transfrom, UIImage to string
                var imageString = ""
                if let image = product.ProductImage {
                    let imageNSData = image.pngData()! as NSData
                    imageString = imageNSData.base64EncodedString(options: .lineLength64Characters)
                }
                // Insert the transformed meal into database
                if database!.executeUpdate(sql,  withArgumentsIn: [product.ProductID, product.ProductName, imageString, product.ProductRating, product.Product_ProtypeID, product.Product_description]) {
                    os_log("The meal is inserted successful!")
                    OK = true
                    
                    close()
                }
                else {
                    os_log("The meal is not inserted successful!")
                    
                }
            }
        }
        return OK
    }
    //2. Read all Product from database
    public func ReadProduct(product: inout [PRODUCT]) {
        //creat SQL Statement
        let sql = "SELECT * FROM \(PRODUCT_TABLE_NAME) ORDER BY \(PRODUCT_ID) DESC"
        if open() {
            if database!.tableExists(PRODUCT_TABLE_NAME) {
                var result: FMResultSet?
                //Catch Acception
                do {
                    result = try database!.executeQuery(sql, values: nil)
                }
                catch {
                    os_log("There are problems while reading meals!")
                }
                
                // Read Product from result
                if let result = result {
                    while (result.next()) {
                        let ID =  result.int(forColumn: PRODUCT_ID)
                        let name = result.string(forColumn: PRODUCT_NAME) ?? ""
                        let imageString = result.string(forColumn: PRODUCT_IMAGE)
                        let Rating = result.int(forColumn: PRODUCT_RATING)
                        let ProtypeID = result.int(forColumn: PRODUCT_PROTYPEID)
                        let description = result.string(forColumn: PRODUCT_DESCRIPTION) ?? ""
                        var image: UIImage? = nil
                        
                        //Trasfrom String image to UIImage
                        if !imageString!.isEmpty {
                            let imageDaTa = Data(base64Encoded: imageString!, options: .ignoreUnknownCharacters)!
                            image = UIImage(data: imageDaTa)
                        }
                        
                        let Product = PRODUCT(ProductID: Int(ID), ProductName: name, ProductImage: image!, ProductRating: Int(Rating), Product_ProtypeID: Int(ProtypeID), Product_description: description)!
                        product.append(Product)
                    }
                }
                close()
            }
        }
    }
    //3. UpDatbase product in the database
    public func updataProduct(old: PRODUCT, new: PRODUCT)-> Bool {
        var OK = false
        
        if open() {
            if database!.tableExists(PRODUCT_TABLE_NAME) {
                // Transformation of new meal image to string
                var stringImage = ""
                if let image =  new.ProductImage {
                    let imageNSData = image.pngData()! as NSData
                    stringImage = imageNSData.base64EncodedString(options: .lineLength64Characters)
                }
                
                //Create Sql stamement
                let sql = "UPDATE \(PRODUCT_TABLE_NAME) SET \(PRODUCT_ID) = ?, \(PRODUCT_NAME) = ?, \(PRODUCT_IMAGE) = ?, \(PRODUCT_RATING) = ?, \(PRODUCT_PROTYPEID) = ?, \(PRODUCT_DESCRIPTION) = ?"
                //Execute the sql stament
                do {
                    try database!.executeUpdate(sql, values: [new.ProductID, new.ProductName, stringImage, new.ProductRating, new.Product_ProtypeID ,new.Product_description, old.ProductID, old.ProductName, old.ProductRating, old.Product_ProtypeID, old.Product_description])
                    os_log("The meal is updated successful!")
                    OK = true
                }
                catch {
                    os_log("The meal is not updated successful!")
                }
                close()
            }
        }
        return OK
    }
    
}

