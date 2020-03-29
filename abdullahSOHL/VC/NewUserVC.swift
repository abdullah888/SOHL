//
//  NewUserVC.swift
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



class NewUserVC : UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!{didSet{
        scrollView.delegate = self
        }}
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
           self.view.endEditing(true)
       }
    
    
    @IBOutlet weak var BottomLayout: NSLayoutConstraint!
    
    @IBOutlet weak var NameTextField: UITextField!
    
    @IBOutlet weak var CityTextField: UITextField!
    @IBOutlet weak var PropertyTextField: UITextField!
    @IBOutlet weak var InformationTextField: UITextField!
    @IBOutlet weak var PhoneNumberTextField: UITextField!
    
    @IBOutlet weak var PriceTextField: UITextField!
    
    
    @IBOutlet weak var collectionView: UICollectionView! {didSet{
        collectionView.delegate = self
        collectionView.dataSource = self
        
        }}
    
    var Images : [UIImage] = []
    
    func getUIImage(asset: PHAsset) -> UIImage? {
        var img: UIImage?
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.version = .original
        options.isSynchronous = true
        manager.requestImageDataAndOrientation(for: asset, options: options) { (data, _, _, _) in
            if let data = data {
                img = UIImage(data: data)
            }
        }
        return img
    }


    func UploadManyImages(completion : @escaping (_ URLs : [String])->()){
        var UploadedImages : [String] = []
        for one in self.Images {
            one.Upload { (url) in
                UploadedImages.append(url)
                if self.Images.count == UploadedImages.count {
                    completion(UploadedImages)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
       
        SettingUpKeyboardNotificaions()
        if let EditPU = EditingUser {
        self.NameTextField.text = EditPU.Name
               self.CityTextField.text = EditPU.City
               self.PropertyTextField.text = EditPU.Property
               self.InformationTextField.text = EditPU.Information
            self.PriceTextField.text = EditPU.Price?.description
        self.PhoneNumberTextField.text = EditPU.PhoneNumber
//            if let str = EditPU.ImageURLs , let url = URL(string : str) {
//        self.ImageView.sd_setImage(with: url, completed: nil)
//                        }
        }
    }
    
    var BSVC = ImagePickerController()
    
    @IBAction func AddImage(_ sender: Any) {
        BSVC = ImagePickerController()
             BSVC.settings.selection.max = 6

                presentImagePicker(BSVC, animated: true, select: { (PHAssets : PHAsset) in
                   
                   
               }, deselect: { (PhAssets : PHAsset ) in
                   
               }, cancel: { (PhAssets : [PHAsset] ) in
                   
               }, finish: { (PhAssets : [PHAsset]) in
                
                
                   
                  for one in PhAssets {
                    if let img = self.getUIImage(asset: one) {
                               self.Images.append(img)
                           }
                       }
                       self.collectionView.reloadData()
                       
                   }, completion: nil)
               
            
    }
    
    
    var EditingUser : NewUserObject?
    
    @IBAction func DonButton(_ sender: Any) {
     self.performSegue(withIdentifier: "Loading", sender: nil)
        self.UploadManyImages { (URLs : [String]) in
          
         let UserID : String = self.EditingUser?.ID ?? UUID().uuidString
          NewUserObject(ID: UserID, Stamp: Date().timeIntervalSince1970, Name: self.NameTextField.text!, City: self.CityTextField.text!, Property: self.PropertyTextField.text!, Information: self.InformationTextField.text!, PhoneNumber: self.PhoneNumberTextField.text!, Price:  Double(self.PriceTextField.text!) ?? 0.0, ImageURLs: URLs).Upload()
            
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Loading"), object: nil, userInfo: nil)
            self.navigationController?.popViewController(animated : true)
            

//           NotificationCenter.default.post(name: NSNotification.Name("ReloadUsers"), object: nil, userInfo: nil)

          print("تم رفع البيانات")
//            self.navigationController?.popViewController(animated: true)
         self.dismiss(animated: true, completion: nil)
          
          }

//          self.UploadADforProduct(ProductID: ProductID)
        self.dismiss(animated: true, completion: nil)

        }
        
     

   
    
    
    
    
}
    
    

extension NewUserVC {
    
    func SettingUpKeyboardNotificaions(){
        NotificationCenter.default.addObserver(self, selector: #selector(NewUserVC.KeyboardShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NewUserVC.KeyboardHid(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func KeyboardShow(notification : NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                self.BottomLayout.constant = keyboardSize.height
                self.view.layoutIfNeeded()
                }, completion: nil)
            
        }
        
    }
    
    @objc func KeyboardHid(notification : NSNotification) {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.BottomLayout.constant = 0
            self.view.layoutIfNeeded()
            }, completion: nil)
        
    }
    
    
}

extension NewUserVC :  UICollectionViewDelegate , UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCell
        
        cell.Update(Image: Images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
       }
    
    
    
    
    
    
    
    
}

