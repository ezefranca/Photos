//
//  PhotosTests.swift
//  PhotosTests
//
//  Created by techthings on 10/5/16.
//  Copyright © 2016 Ezequiel França. All rights reserved.
//

import XCTest
import RxSwift
import Alamofire
@testable import Photos

class PhotosApiTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDownloadImages(){
        
        class MockClient:PhotoApi {
            
            override func download() -> Observable<AnyObject?> {
                
                return Observable.create({ (observer) -> Disposable in
                    let request = Alamofire.request(.GET, service.baseURL!, parameters: nil)
                        .response(completionHandler:  { request, response, data, error in
                            var operationComplete = false
                            var response:String? = nil
                            let error:NSError? = NSError(domain: "Testing", code: 99, userInfo: nil)
                            
                            
                            if ((error) != nil) {
                                observer.on(.Error(error!))
                            } else {
                                observer.on(.Next(data))
                                observer.on(.Completed)
                            }
                        });
                    return AnonymousDisposable {
                        request.cancel()
                    }
                })
                
            }
        }
        
    }
    
    
    func testIfUrlIsAlive() {
        
        let urlString = "https://jsonplaceholder.typicode.com/photos"
        
        XCTAssertEqual(urlString, "https://jsonplaceholder.typicode.com/photos")
        
        let expectation = expectationWithDescription("Alamofire")
        
        Alamofire.request(.GET, urlString)
            
            .response { request, response, data, error in
                XCTAssertNil(error, "Erro na requisição \(error)")
                
                XCTAssertEqual(response?.statusCode, 200, "Status + \(response?.statusCode) : API Fora do ar Talvez")
                
                expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
}
