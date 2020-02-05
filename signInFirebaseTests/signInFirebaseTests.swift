//
//  signInFirebaseTests.swift
//  signInFirebaseTests
//
//  Created by Maryna Veksler on 1/26/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import XCTest
@testable import signInFirebase

class signInFirebaseTests: XCTestCase {
    let signModel = SignViewModel()
    let FBfunctions = FireBaseManager.self

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSignIn(){
        let email = "testing@mail.com"
        let password = "test123"
        var errCheck : Error?
        FBfunctions.shared.signIn(email: email, password: password) { (error) in
            errCheck = error
        }
        XCTAssertNil(errCheck, "Error is nil")
    }
    
    
    func testCreatingUser() {
        let user = UserModel(userId: nil, email: "gmail@mail.com", password: "weather", userImage: nil, name: "John", lastName: "Mac", sport: "hokey", gender: "male")
        var errorCheck : Error?
        FBfunctions.shared.createUser(user: user) { (error) in
            errorCheck = error
        }
        XCTAssertNil(errorCheck)
    }
    
    func testUserValidationForSignUp(){
        let test1 = signModel.validateSignUp(email: nil, password: nil, name: nil, sport: nil, gender: nil, lastName: nil, confirmPassword: nil)
        XCTAssertEqual(test1, false)
        let test2 = signModel.validateSignUp(email: "", password: nil, name: nil, sport: nil, gender: nil, lastName: nil, confirmPassword: nil)
        XCTAssertEqual(test2, false)
        let test3 = signModel.validateSignUp(email: "mailcom", password: "pass", name: "Mary", sport: "Tennis", gender: "fem", lastName: "denny", confirmPassword: "pass")
        XCTAssertNotEqual(test3, true)
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
