//
//  NetworkStatusTests.swift
//  Photos
//
//  Created by Ezequiel on 09/10/16.
//  Copyright © 2016 Ezequiel França. All rights reserved.
//

import XCTest
import ReachabilitySwift
import RxSwift
import Alamofire

@testable import Photos

class NetworkStatusTests: XCTestCase {
    
    let disposable = DisposeBag()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //    func testNotifier() {
    //        
    //        Reachable.filterInternetIsActive()
    //            
    //            .subscribeNext { (status) in
    //                //self.updateViewModelObservable()
    //            }
    //            .addDisposableTo(self.disposable)
    //        
    //    }
    
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
    
    
    func testValidHost() {
        
        let reachability: Reachability
        let validHostName = "https://jsonplaceholder.typicode.com/photos"
        
        do {
            try reachability = Reachability(hostname: validHostName)
        } catch {
            XCTAssert(false, "Unable to create reachability")
            return
        }
        
        let expectation = expectationWithDescription("Check valid host")
        reachability.whenReachable = { reachability in
            dispatch_async(dispatch_get_main_queue()) {
                print("Pass: \(validHostName) is reachable - \(reachability)")
                expectation.fulfill()
            }
        }
        reachability.whenUnreachable = { reachability in
            dispatch_async(dispatch_get_main_queue()) {
                print("\(validHostName) is initially unreachable - \(reachability)")
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            XCTAssert(false, "Unable to start notifier")
            return
        }
        
        waitForExpectationsWithTimeout(5, handler: nil)
        
        reachability.stopNotifier()
    }
    
}
