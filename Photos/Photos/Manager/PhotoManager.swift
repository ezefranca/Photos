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
    
    var photoModels = [Photos]()
    var photoViewModels = [PhotosViewModel]()
    
    var photoDownloader: PhotoApi
    var disposeBag = DisposeBag()
    
    init(downloader:PhotoApi){
        self.photoDownloader = downloader
    }
    
    func getViewModels() -> Observable<[PhotosViewModel]> {
        
        return Observable.create({ (observer) -> Disposable in
            
            self.photoDownloader.download()
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
                self.photoDownloader.cancel()
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