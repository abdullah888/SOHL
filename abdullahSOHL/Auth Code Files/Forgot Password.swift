//
//  Forgot Password.swift
//  Store Project
//
//  Created by Osama Jasim on 10/10/19.
//  Copyright © 2019 Smart Angle. All rights reserved.
//

import UIKit
import Firebase
class ForgotPassword : UIViewController {
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBAction func ResetPasswordAction(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: EmailTextField.text!, completion: nil)
    }
    
    @IBAction func SignInAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
