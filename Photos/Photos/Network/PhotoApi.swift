//
//  PhotoApi.swift
//  Photos
//
//  Created by techthings on 10/5/16.
//  Copyright © 2016 Ezequiel França. All rights reserved.
//

import Alamofire
import RxSwift
import RxCocoa
import ObjectMapper

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
    
    var request:Request? = nil
    
    
    func download() -> Observable<[Photos]> {
        
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
    
    func cancel() {
        self.request!.cancel() 
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