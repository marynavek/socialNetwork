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
import TWMessageBarManager
import SVProgressHUD
import IHProgressHUD
import FBSDKLoginKit



class ViewController: UIViewController, GIDSignInDelegate {
    
    let signInVM = SignViewModel()
    
    @IBOutlet weak var resetPBtn: UIButton!
    
    @IBOutlet weak var loginFBbtn: UIButton!
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
        buttonStyle(button: loginFBbtn, color: .blue)
        
        let loginButton = FBLoginButton()
        loginButton.delegate = self as? LoginButtonDelegate
    
        view.sendSubviewToBack(backgroundImgView)
        
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }

    //Facebook sign in
    @IBAction func facebookSignIn(_ sender: Any) {
        let fbLoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self){(result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            guard let accessToken = AccessToken.current else {
                print("failed to get access token")
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            IHProgressHUD.show()
            Auth.auth().signIn(with: credential) { (authResult, error) in
              if let error = error {
                IHProgressHUD.showError(withStatus: "Could not login with Facebook")
                print( error.localizedDescription)
                IHProgressHUD.dismiss()
                return
              }
                IHProgressHUD.showSuccesswithStatus("Succesfully logged in with Facebook")
                if (authResult?.additionalUserInfo!.isNewUser)! {
                    let uid = Auth.auth().currentUser?.uid
                    FireBaseManager.shared.addUserEntryForGIDAndFBLogin(userId: uid, user: nil, isFB: true) { (error) in
                        if error != nil{
                            print("error happened")
                        }
                    }
                }
            print("Succesfully logged in with Google credentials")
                IHProgressHUD.dismiss()
            let ctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
            ctrl.modalPresentationStyle = .fullScreen
            self.present(ctrl, animated: true, completion: nil)
            }
        }
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
            IHProgressHUD.show()
               Auth.auth().signIn(with: credential){(result, error) in
                   if let error = error {
                       IHProgressHUD.showError(withStatus: "Could not login with Google")
                       print( error.localizedDescription)
                       IHProgressHUD.dismiss()
                       return
                   }
                    IHProgressHUD.showSuccesswithStatus("Succesfully logged in with Google")
                if (result?.additionalUserInfo!.isNewUser)! {
                 let uid = Auth.auth().currentUser?.uid
                    let user = UserModel(userId: uid, email: result?.additionalUserInfo?.profile?["email"] as? String, password: nil, userImage: nil, name: result?.additionalUserInfo?.profile?["given_name"] as? String, lastName: result?.additionalUserInfo?.profile?["family_name"] as? String, sport: nil, gender: nil)
                    FireBaseManager.shared.addUserEntryForGIDAndFBLogin(userId: uid, user: user, isFB: false) { (error) in
                        if error != nil{
                            print("error happened")
                        }
                    }
                }
                print("Succesfully logged in with Google credentials")
                 IHProgressHUD.dismiss()
                let ctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                ctrl.modalPresentationStyle = .fullScreen
                self.present(ctrl, animated: true, completion: nil)
               }
           }
       }
       
    
    
    
    //Sign in button that implements sign In function and go to the main application
    @IBAction func signInBtn(_ sender: Any) {
       if signInVM.validateSignIn(email: txtEmail.text, password: txtPassword.text){
        IHProgressHUD.show()
            signInVM.signIn(email: txtEmail.text, password: txtPassword.text) { (error) in
                if error == nil {
                    IHProgressHUD.dismiss()
                    let ctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                    ctrl.modalPresentationStyle = .fullScreen
                    self.present(ctrl, animated: true, completion: nil)
                    
                } else {
                    IHProgressHUD.dismiss()
                }
            }
       } else {
        }
    }
    
    
    
    @IBAction func goTosignUp(_ sender: Any) {
        let ctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signUpViewController") as! signUpViewController
        ctrl.modalPresentationStyle = .fullScreen
        self.present(ctrl, animated: true, completion: nil)
    }
}

