//
//  Sign Up.swift
//  Store Project
//
//  Created by Osama Jasim on 10/10/19.
//  Copyright © 2019 Smart Angle. All rights reserved.
//

import UIKit
import Firebase

class SignUp : UIViewController {
    
    
    @IBOutlet weak var EmailT: UITextField!
    
    @IBOutlet weak var PasswordT: UITextField!
    
    @IBOutlet weak var ConfirmPasswordT: UITextField!
    
    @IBAction func SignUpAction(_ sender: Any) {
        
        if ConfirmPasswordT.text != PasswordT.text {
            // the password is not matching the confirm password
            print("Passwords don't match")
            return
        }
        
        Auth.auth().createUser(withEmail: EmailT.text!, password: PasswordT.text!) { (auth, error) in
            
            if error == nil {
                          print("Done Signing up.")
                
                Auth.auth().addStateDidChangeListener { (auth, user) in
                        guard let User = user else { return }
                        print(User.uid)
                    Firestore.firestore().collection("Users").document(User.uid).setData(["Email" : self.EmailT.text!])
                    }
                    
                
                
                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                      } else {
                          print(error.debugDescription)
                      }
            
            
        }
    }
    
    @IBAction func SignInAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
