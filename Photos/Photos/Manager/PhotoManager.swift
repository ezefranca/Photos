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
    
    var photoModels: [Photos]?
    var photoViewModels: [PhotosViewModel]?
    var photoDownloader: PhotoApi
    
    var disposeBag = DisposeBag()
    
    init(downloader:PhotoApi){
        self.photoDownloader = downloader
    }
    
    func getViewModels() -> Observable<AnyObject?> {
        
        //        self.photoDownloader?.download()
        
        self.photoViewModels = [PhotosViewModel]()
        
        return Observable.create({ (observer) -> Disposable in
            
            self.photoDownloader.download()
                // tenta 3 vezes
                .retry(3)
                // 5 segundos maximo de timeout
                .timeout(5, scheduler: MainScheduler.instance)
                // adicionar backgroud thread
                .subscribeOn(self.photoDownloader.backgroundScheduler)
                // Adicionar main thread
                .observeOn(self.photoDownloader.mainScheduler)
                .subscribe(
                    onNext: { data in
                        
                        do {
                            let json : AnyObject! = try NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions.MutableContainers)
                            guard let photos : Array<Photos> = Mapper<Photos>().mapArray(json) else {
                                return
                            }
                            self.photoModels = photos
                            
                        } catch {
                            print(NSString(data: data as! NSData, encoding: NSUTF8StringEncoding))
                        }
                        observer.on(.Next(data))
                    },
                    onError: { error in
                        observer.on(.Error(error))
                    },
                    onCompleted: {
                        observer.on(.Completed)
                        print("Completo 💪")
                        return self.getViewModels(self.photoModels!)!
                    },
                    onDisposed: {
                    }
                )
                .addDisposableTo(self.disposeBag)
            return AnonymousDisposable {
                self.photoDownloader.cancel()
            }
        });
        
        //return self.getViewModels(photoModels!)
    }
    
    private func getViewModels(models:[Photos]) -> Void? {
        
        for m in models {
            let p = PhotosViewModel(photo: m)
            print(p.title)
            self.photoViewModels!.append(p)
        }
        
        //        guard let vm = photoViewModels else {
        //            return ()
        //        }
        //        
        //        self.photoViewModels = vm
        for a in photoViewModels! {
            print(a.title)
        }
        return ()
    }
    
}