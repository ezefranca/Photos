//
//  PhotoManager.swift
//  Photos
//
//  Created by Ezequiel on 06/10/16.
//  Copyright © 2016 Ezequiel França. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift

public class PhotoManager {
    
    var photoModels: [Photos] = []
    
    public var photoViewModels: [PhotosViewModel] = []
    //    {
    //        guard let vm = self.photoViewModels else {
    //            return nil
    //        }
    //        return vm
    //    }
    
    var photoDownloader: PhotoApi
    var disposeBag = DisposeBag()
    
    init(downloader:PhotoApi){
        self.photoDownloader = downloader
    }
    
    func getViewModels() -> Observable<AnyObject?> {
        
        return Observable.create({ (observer) -> Disposable in
            
            self.photoDownloader.download()
                .retry(3)
                .timeout(5, scheduler: MainScheduler.instance)
                .subscribeOn(self.photoDownloader.backgroundScheduler)
                .observeOn(self.photoDownloader.mainScheduler)
                .subscribe(
                    onNext: { data in
                        self.parseData(data!)
                        observer.on(.Next(data))
                    },
                    onError: { error in
                        observer.on(.Error(error))
                    },
                    onCompleted: {
                        self.getViewModels(self.photoModels)
                        observer.on(.Completed)
                    }
                    
                )
                .addDisposableTo(self.disposeBag)
            return AnonymousDisposable {
                self.photoDownloader.cancel()
            }
        });
    }
    
    private func parseData(data:AnyObject) {
        do {
            let json : AnyObject! = try NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions.MutableContainers)
            guard let photos : Array<Photos> = Mapper<Photos>().mapArray(json) else {
                return
            }
            self.photoModels = photos
            
        } catch {
            print(NSString(data: data as! NSData, encoding: NSUTF8StringEncoding))
        }
        //self.getViewModels(self.photoModels)!
    }
    
    private func getViewModels(models:[Photos]) -> Void? {
        
        for m in models {
            let p = PhotosViewModel(photo: m)
            print(p.title)
            self.photoViewModels.append(p)
        }
        
        //        guard let vm = photoViewModels else {
        //            return ()
        //        }
        //        
        //        self.photoViewModels = vm
        //        for a in (photoViewModels?)! {
        //            print(a.title)
        //        }
        return ()
    }
    
}