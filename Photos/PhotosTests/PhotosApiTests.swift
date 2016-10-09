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
import ObjectMapper
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
    
    func testDownloadImages(){
        
        class MockClient: PhotoApi {
            
            override func download() -> Observable<[Photos]> {
                return Observable.create({ (observer) -> Disposable in
                    self.request = Alamofire.request(.GET, service.baseURL!, parameters: nil)
                        .response(completionHandler:  { request, response, data, error in
                            if ((error) != nil) {
                                observer.on(.Error(error!))
                            } else {
                                observer.on(.Next(self.parseData(data!)))
                                observer.on(.Completed)
                            }
                        });
                    return AnonymousDisposable {
                        self.request!.cancel()
                    }
                })
            }
            
            private func parseData(data:AnyObject) -> [Photos] {
                do {
                    let json : AnyObject! = try NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions.MutableContainers)
                    guard let photos : Array<Photos> = Mapper<Photos>().mapArray(json) else {
                        return []
                    }
                    return photos
                } catch {
                    print(NSString(data: data as! NSData, encoding: NSUTF8StringEncoding))
                }
                return []
            }
            
            
        }
        
        //        class MockClient:PhotoApi {
        //            
        //            override func download() -> Observable<AnyObject?> {
        //                
        //                return Observable.create({ (observer) -> Disposable in
        //                    let request = Alamofire.request(.GET, service.baseURL!, parameters: nil)
        //                        .response(completionHandler:  { request, response, data, error in
        //                            var operationComplete = false
        //                            var response:String? = nil
        //                            let error:NSError? = NSError(domain: "Testing", code: 99, userInfo: nil)
        //                            
        //                            
        //                            if ((error) != nil) {
        //                                observer.on(.Error(error!))
        //                            } else {
        //                                observer.on(.Next(data))
        //                                observer.on(.Completed)
        //                            }
        //                        });
        //                    return AnonymousDisposable {
        //                        request.cancel()
        //                    }
        //                })
        //                
        //            }
        //        }
        
    }
    
}
