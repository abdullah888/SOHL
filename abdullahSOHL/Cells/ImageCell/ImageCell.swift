//
//  ImageCell.swift
//  abdullahSOHL
//
//  Created by abdullah on 02/08/1441 AH.
//  Copyright © 1441 abdullah. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var ImageView: UIImageView!
    
    

  func Update(url : String){
      guard let Url = URL(string : url) else { return }
      self.ImageView?.sd_setImage(with: Url, completed: nil)
  }
  
  func Update(Image : UIImage){
      self.ImageView.image = Image
      
  }
}
