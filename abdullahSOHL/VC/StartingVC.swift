//
//  StartingVC.swift
//  Store Project
//
//  Created by Osama Jasim on 10/13/19.
//  Copyright © 2019 Smart Angle. All rights reserved.
//

import UIKit
import Firebase

class StartingVC : UIViewController {
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
         // try? Auth.auth().signOut()
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if user == nil { 
                self.performSegue(withIdentifier: "Auth", sender: nil)
                // no user
            } else {
                self.performSegue(withIdentifier: "App", sender: nil)
                // user is here
            }
            
            
            
        }
        

        print("الى الان انتهى")
        
        
    }

    
    
    
    
}
