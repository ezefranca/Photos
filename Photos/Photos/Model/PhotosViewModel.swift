//
//  PhotosViewModel.swift
//  Photos
//
//  Created by techthings on 10/5/16.
//  Copyright © 2016 Ezequiel França. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper
import Alamofire

struct PhotosViewModel {
    
    var title: String?
    var url: String?
    var internalIdentifier: Int?
    var thumbnailUrl: String?
    var albumId: Int?
    
    var model: Photos! {
        didSet{
            self.title = model.title
            self.url = model.url
            self.internalIdentifier = model.internalIdentifier
            self.thumbnailUrl = model.thumbnailUrl
            self.albumId = model.albumId
        }
    }
    
    init(photo: Photos) {
        setPhoto(photo)
    }
    
    mutating func setPhoto(photo:Photos) {
        self.model = photo
    }
    
}


struct ViewModelManager  {
    
    var manager:PhotoApi = PhotoApi()
    let load = Variable<Bool>(false)
    let disposeBag = DisposeBag()
    
    lazy var data: Driver<[Photos]> = {
        return self.load.asObservable()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest {_ in
                self.getPhotos()
            }
            .asDriver(onErrorJustReturn: [])
    }()
    
    mutating func getPhotos() -> Observable<[Photos]> {
        return (manager.download())
    }
    //load: Verdadeiro ou Falso para novo download
}
