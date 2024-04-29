//
//  DroneteTests.swift
//  DroneteTests
//
//  Created by Daniel Cazorro Frías on 30/1/24.
//

import XCTest
@testable import Dronete

final class DroneteTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    // Models
    func testItemInitialization() {
        let imageName = "test_image"
        let title = "Test Item"
        
        let item = Item(imageName: imageName, title: title)
        
        XCTAssertEqual(item.imageName, imageName, "Image name should match")
        XCTAssertEqual(item.title, title, "Title should match")
    }

    func testItemEquality() {
        let item1 = Item(imageName: "image1", title: "Item 1")
        let item2 = Item(imageName: "image1", title: "Item 1")
        let item3 = Item(imageName: "image2", title: "Item 2")
        
        XCTAssertEqual(item1, item2, "Items with same properties should be equal")
        XCTAssertNotEqual(item1, item3, "Items with different properties should not be equal")
    }
}
