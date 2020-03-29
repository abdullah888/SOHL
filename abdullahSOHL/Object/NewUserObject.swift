//
//  NewUserObject.swift
//  abdullahSOHL
//
//  Created by abdullah on 02/08/1441 AH.
//  Copyright © 1441 abdullah. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos
import FirebaseStorage
import SDWebImage
import Firebase

class NewUserObject {
    
    
    var ID : String?
    var Stamp : TimeInterval?
    var Name : String?
    var City : String?
    var Property : String?
    var Information : String?
    var PhoneNumber : String?
    var Price : Double?
    var ImageURLs : [String]?
    
    init(ID : String, Stamp : TimeInterval, Name : String, City : String, Property : String, Information : String , PhoneNumber : String , Price : Double, ImageURLs : [String]) {
        self.ID = ID
        self.Stamp = Stamp
        self.Name = Name
        self.City = City
        self.Property = Property
        self.Information = Information
        self.PhoneNumber = PhoneNumber
        self.Price = Price
        self.ImageURLs = ImageURLs
    }
    
    init(Dictionary : [String : AnyObject]) {
        self.ID = Dictionary["ID"] as? String
        self.Stamp = Dictionary["Stamp"] as? TimeInterval
        self.Name = Dictionary["Name"] as? String
        self.City = Dictionary["City"] as? String
        self.Property = Dictionary["Property"] as? String
        self.Information = Dictionary["Information"] as? String
        self.PhoneNumber = Dictionary["PhoneNumber"] as? String
        self.Price = Dictionary["Price"] as? Double
        self.ImageURLs = Dictionary["ImageURLs"] as? [String]
        
    }
    
    func MakeDictionary()->[String : AnyObject] {
        var D : [String : AnyObject] = [:]
        D["ID"] = self.ID as AnyObject
        D["Stamp"] = self.Stamp as AnyObject
        D["Name"] = self.Name as AnyObject
        D["City"] = self.City as AnyObject
        D["Property"] = self.Property as AnyObject
        D["Information"] = self.Information as AnyObject
        D["PhoneNumber"] = self.PhoneNumber as AnyObject
        D["Price"] = self.Price as AnyObject
        D["ImageURLs"] = self.ImageURLs as AnyObject
        return D
    }
    
     func Upload(){
             guard let id = self.ID else { return }
             Firestore.firestore().collection("NewUsers").document(id).setData(MakeDictionary())
         }
         
         func Remove(){
             guard let id = self.ID else { return }
             Firestore.firestore().collection("NewUsers").document(id).delete()
             
//             Firestore.firestore().collection("Ads").document(id).delete()
         }
         
         
     }


     class NewUsersApi {

         static func GetNewUsers(ID : String, completion : @escaping (_ Product : NewUserObject)->()){
             Firestore.firestore().collection("NewUsers").document(ID).addSnapshotListener { (Snapshot : DocumentSnapshot?, Error : Error?) in
                 if let data = Snapshot?.data() as [String : AnyObject]? {
                     let New = NewUserObject(Dictionary: data)
                     completion(New)
                 }
             }
         }
         
         static func GetAllNewUsers(completion : @escaping (_ User : NewUserObject)->()){
             Firestore.firestore().collection("NewUsers").getDocuments { (Snapshot, error) in
                 if error != nil { print("Error") ; return }
                 guard let documents = Snapshot?.documents else { return }
                 for P in documents {
                     if let data = P.data() as [String : AnyObject]? {
                         let New = NewUserObject(Dictionary: data)
                         completion(New)
                     }
                 }
             }

         }
         
     }
