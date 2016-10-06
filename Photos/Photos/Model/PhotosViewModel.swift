//
//  PhotosViewModel.swift
//  Photos
//
//  Created by techthings on 10/5/16.
//  Copyright © 2016 Ezequiel França. All rights reserved.
//

import Foundation

public struct PhotosViewModel {
    
    public var title: String?
    public var url: String?
    public var internalIdentifier: Int?
    public var thumbnailUrl: String?
    public var albumId: Int?
    
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

