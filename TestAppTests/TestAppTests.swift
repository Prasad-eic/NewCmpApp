//
//  TestAppTests.swift
//  TestAppTests
//
//  Created by Prasad Lokhande on 10/07/23.
//

import XCTest
@testable import TestApp

final class TestAppTests: XCTestCase {

    var num1: Int?
    var num2: Int?
    var testClass: FilterViewController?
    var clsPopUp:PopUpViewControllerForAddding?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testClass = FilterViewController()
        clsPopUp = PopUpViewControllerForAddding()

            num1 = 10
            num2 = 10
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        testClass = nil
            num1 = nil
            num2 = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        let sum = testClass!.calculateSum(num1: num1!, num2: num2!)
        // The sum should be 20 for this to pass.
        XCTAssertTrue(sum == 20)
        
        _ = clsPopUp?.validatetxtData(name: "qwe")
        XCTAssertTrue(false)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testSumFunction() {
       
    }
    func testAddEmp()
    {
        
    }
}
