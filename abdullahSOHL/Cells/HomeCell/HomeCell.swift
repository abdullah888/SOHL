//
//  HomeCell.swift
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
class HomeCell: UICollectionViewCell {
    
    
    @IBOutlet weak var ImageView: UIImageView!
    

     func Update(User : NewUserObject) {
           
           
           guard let imgString = User.ImageURLs?[0], let url = URL(string : imgString) else { return }
           ImageView.sd_setImage(with: url, completed: nil)
           
       }
       

}
