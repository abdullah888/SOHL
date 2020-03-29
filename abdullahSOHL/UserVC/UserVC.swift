//
//  UserVC.swift
//  abdullahSOHL
//
//  Created by abdullah on 03/08/1441 AH.
//  Copyright © 1441 abdullah. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos
import FirebaseStorage
import SDWebImage
import Firebase
class UserVC: UIViewController {
    
    var User : NewUserObject!
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var CityLabel: UILabel!
    @IBOutlet weak var PropertyLabel: UILabel!
    @IBOutlet weak var InformationLabel: UILabel!
    @IBOutlet weak var PhoneNumberLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView! {didSet{
        collectionView.delegate = self
        collectionView.dataSource = self
        
        }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        self.NameLabel.text = User.Name
        self.CityLabel.text = User.City
        self.PropertyLabel.text = User.Property
        self.InformationLabel.text = User.Information
        self.PhoneNumberLabel.text = User.PhoneNumber
        self.PriceLabel.text = (User.Price?.description ?? "") + " ريال"
       
    }
    
    
    @IBAction func BackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
  
}

extension UserVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.User.ImageURLs?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCell
        if let imgs = self.User.ImageURLs {
            
            Cell.Update(url:imgs[indexPath.row])
        }
        Cell.ImageView.contentMode = .scaleAspectFill
        return Cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    
}
