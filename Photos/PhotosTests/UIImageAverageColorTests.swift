//
//  UIImageAverageColorTests.swift
//  Photos
//
//  Created by Ezequiel on 07/10/16.
//  Copyright © 2016 Ezequiel França. All rights reserved.
//

import UIKit
import XCTest
@testable import Photos

class UIImageAverageColorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testCreateImage() {
        
        let color = UIColor.clearColor()
        let image = UIImage.imageWithColor(UIColor.clearColor())
        XCTAssertNotNil(image)
        XCTAssertNotNil(color)
        
    }
    
    func testImageColor() {
        let color =  UIColor.whiteColor()
        let image = UIImage.imageWithColor(UIColor.whiteColor())
        XCTAssertNotNil(image)
        XCTAssertNotNil(color)
        let expectation = expectationWithDescription("AsyncMethod")
        
        //XCTestAssertNil(error, "Something went horribly wrong")
        image.imageColor({ (cor) in
            XCTAssertNotNil(cor)
            //XCTAssertTrue(CGColorEqualToColor(cor.CGColor, color.CGColor))
            expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: nil)
    }
}