//
//  PhotoApi.swift
//  Photos
//
//  Created by techthings on 10/5/16.
//  Copyright © 2016 Ezequiel França. All rights reserved.
//

import Alamofire
import RxSwift

enum service {
    static let baseURL = NSURL(string: "https://jsonplaceholder.typicode.com/photos")
}



public class PhotoApi {
    
    
    let URLSession = Foundation.NSURLSession.sharedSession()
    
    public var backgroundScheduler: ImmediateSchedulerType {
        let operationQueue = NSOperationQueue()
        operationQueue.maxConcurrentOperationCount = 2
        return OperationQueueScheduler(operationQueue: operationQueue)
    }
    
    public var mainScheduler: SerialDispatchQueueScheduler {
        return MainScheduler.instance
    }
    
    
    func download() -> Observable<AnyObject?> {
        
        return Observable.create({ (observer) -> Disposable in
            let request = Alamofire.request(.GET, service.baseURL!, parameters: nil)
                .response(completionHandler:  { request, response, data, error in
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