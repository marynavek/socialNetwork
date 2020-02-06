//
//  TDD tests.swift
//  signInFirebaseTests
//
//  Created by Maryna Veksler on 2/6/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Firebase
@testable import signInFirebase

class signInTests : QuickSpec {
    override func spec() {
        var signUpViewModel : SignViewModel?
        describe("testing creating an account") {
            context("sign up button pressed") {
                afterEach {
                    signUpViewModel = nil
                }
                beforeEach {
                    signUpViewModel = SignViewModel()
                }
                it("valid user input"){
                    if let isValid = signUpViewModel?.validateSignUp(email: "gmail@mail.com", password: "password", name: "Alex", sport: "socces", gender: "male", lastName: "Karev", confirmPassword: "password") {
                        expect(isValid).to(equal(true))
                    }
                }
                it("user input is invalid") {
                    if let isValid = signUpViewModel?.validateSignUp(email: "gmail", password: "password", name: "Alex", sport: "socces", gender: "male", lastName: "Karev", confirmPassword: "password") {
                        expect(isValid).to(equal(false))
                    }
                }
            }
        }
    }
}
