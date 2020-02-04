//
//  ViewController.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 1/26/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn



class ViewController: UIViewController, GIDSignInDelegate {
    
    @IBOutlet weak var resetPBtn: UIButton!
    
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var signInGBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var backgroundImgView: UIImageView!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        textFieldStyle(txtField: txtEmail, color: .blue)
        textFieldStyle(txtField: txtPassword, color: .blue)
        buttonStyle(button: signInBtn, color: .blue)
        buttonStyle(button: signUpBtn, color: .blue)
        buttonStyle(button: signInGBtn, color: .blue)
        buttonStyle(button: resetPBtn, color: .blue)
        
        view.sendSubviewToBack(backgroundImgView)
        
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }

    
    
    //Google Sign In
    @IBAction func googleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
           if error != nil {
               print("Error happened, \(error.localizedDescription)")
           } else {
               guard let auth = user.authentication else {return}
               let credential = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
               Auth.auth().signIn(with: credential){(result, error) in
                   if error != nil {
                       print( error?.localizedDescription ?? "Error happened")
                   } else {
                       print("Succesfully logged in with Google credentials")
                       let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "FeedViewController") as FeedViewController
                       self.navigationController?.pushViewController(vc, animated: true)
                   }
               }
           }
       }
       
    
    
    
    //Sign in button that implements sign In function and go to the main application
    @IBAction func signInBtn(_ sender: Any) {
        if let email = self.txtEmail.text, !email.isEmpty, let password = self.txtPassword.text, !password.isEmpty {
            FireBaseManager.shared.signIn(email: email, password: password)
            
            
            let ctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
            ctrl.modalPresentationStyle = .fullScreen
            self.present(ctrl, animated: true, completion: nil)
            
        } else {
            print("fill out all fields")
        }
    }
    
}

