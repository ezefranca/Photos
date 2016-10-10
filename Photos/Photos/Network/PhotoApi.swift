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

private enum service {
    static let baseURL = NSURL(string: "https://jsonplaceholder.typicode.com/photos")
}

public class PhotoApi {
    
    final private var photoViewModels = [PhotosViewModel]()
    final private let URLSession = Foundation.NSURLSession.sharedSession()
    private var disposeBag = DisposeBag()
    
    var request:Request? = nil
    
    
    public func download() -> Observable<[Photos]> {
        
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
                self.cancel()
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
    
    private func getViewModels() -> Observable<[PhotosViewModel]> {
        
        print("comecando download")
        return Observable.create({ (observer) -> Disposable in
            
            self.download()
                .retry(5)
                .subscribe(
                    onNext: { data in
                        observer.onNext(self.getViewModels(data))
                    },
                    onError: { error in
                        observer.on(.Error(error))
                    },
                    onCompleted: {
                        observer.on(.Completed)
                    }
                    
                )
                .addDisposableTo(self.disposeBag)
            return AnonymousDisposable {
                self.cancel()
            }
        });
    }
    
    private func getViewModels(models:[Photos]) -> [PhotosViewModel] {
        
        models
            .flatMap{$0}
            .forEach { ( photo : Photos) -> () in
                self.photoViewModels.append(PhotosViewModel(photo: photo))
        }
        
        return photoViewModels
    }
}