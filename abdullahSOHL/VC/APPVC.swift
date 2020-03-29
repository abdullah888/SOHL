//
//  APPVC.swift
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


extension APPVC {
    
    func SetUpRefresher(){
        self.RefreshControl.addTarget(self, action: #selector(APPVC.RefreshNow), for: .valueChanged)
        RefreshControl.tintColor = UIColor.orange
        self.collectionView.addSubview(self.RefreshControl)
    }
    
    @objc func RefreshNow(){
        self.UserArray = []
        self.collectionView.reloadData()
        self.GetData()
        self.RefreshControl.endRefreshing()
    }
    
    
    
}








class APPVC: UIViewController {
    
    var RefreshControl : UIRefreshControl = UIRefreshControl()
    
    var UserArray : [NewUserObject] = []

    @IBOutlet weak var collectionView: UICollectionView! {didSet{
           collectionView.delegate = self
           collectionView.dataSource = self
           }}
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpRefresher()
        GetData()
        collectionView.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        let customLayout = CustomLayout()
        customLayout.delegate = self
        collectionView.collectionViewLayout = customLayout
        
        
        
    }
     func GetData(){
         NewUsersApi.GetAllNewUsers { (NewUsers) in
             self.UserArray.append(NewUsers)
             self.collectionView.reloadData()
         }
         
     }
        
    

    
    
    
    
    
    
    

}

extension APPVC :  UICollectionViewDelegate , UICollectionViewDataSource  , UICollectionViewDelegateFlowLayout , CustomLayoutDelegate  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomeCell
        cell.Update(User: UserArray[indexPath.row])
        return cell
    }
    
func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath: IndexPath) -> CGSize {
           let cellsAcross: CGFloat = 1
                 let spaceBetweenCells: CGFloat = 0
                 let dim = (collectionView.bounds.width - (cellsAcross - 0) * spaceBetweenCells) / cellsAcross
                 return CGSize(width: dim, height: dim)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NewUsersApi.GetNewUsers(ID: self.UserArray[indexPath.row].ID!) { (NewUser) in
            self.performSegue(withIdentifier: "ImageShow", sender: NewUser)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newUser = sender as? NewUserObject {
            if let next = segue.destination as? UserVC {
                next.User = newUser
            
        }
        
        }
    }
    
    
}
