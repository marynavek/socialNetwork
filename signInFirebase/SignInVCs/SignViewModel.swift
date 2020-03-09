//
//  SignViewModel.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 2/4/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth

class SignViewModel : NSObject {

    func validateSignUp(email: String?, password: String?, name: String?, sport: String?, gender: String?, lastName: String?, confirmPassword: String?) -> Bool{
        if let email = email, !email.isEmpty, let password = password, !password.isEmpty, let name = name, !name.isEmpty, let sport = sport, !sport.isEmpty, let gender = gender, !gender.isEmpty, let lastName = lastName, !lastName.isEmpty, let confPass = confirmPassword, !confPass.isEmpty {
            if email.isValidEmail {
                if password == confPass {
                    return true
                } else {
                    print("passwords do not match")
                    return false
                }
            } else {
                print("The email is not valid")
                return false
            }
                
        } else {
            print("Fill out all fields")
            return false
        }
    }
    
    func signUp(user : UserModel, completionHandler: @escaping (Error?) -> Void){
        FireBaseManager.shared.createUser(user: user) { (error) in
            if error == nil {
                print("Created a user")
                completionHandler(nil)
            } else {
                completionHandler(error)
                print("Could not create a user")
            }
        }
    }

    func validateSignIn(email: String?, password: String?) -> Bool {
        if let email = email, !email.isEmpty, let password = password, !password.isEmpty {
            return true
        } else {
            print("Fill out all fields")
            return false
        }
    }
    
    func signIn(email: String?, password: String?, completionHandler: @escaping (Error?) -> Void){
        FireBaseManager.shared.signIn(email: email ?? defaultUserModel.shared.email, password: password ?? defaultUserModel.shared.password) { (error) in
            if error != nil {
                print(error?.localizedDescription ?? "could not sign in")
                completionHandler(error)
            } else {
                print("Succesfully signed in")
                completionHandler(nil)
            }
        }
    }
    
    func resetPassword(email: String?, completionHandler: @escaping (Error?) -> Void){
        if let email = email, !email.isEmpty {
            if email.isValidEmail {
                FireBaseManager.shared.resetPassword(email: email) { (error) in
                    if error != nil {
                        completionHandler(error)
                    } else {
                        completionHandler(nil)
                    }
                }
            } else {
                print("the email is not valid")
            }
        } else {
            print("Fill out all fields")
        }
    }
    
    
}
