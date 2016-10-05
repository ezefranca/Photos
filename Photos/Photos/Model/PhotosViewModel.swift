//
//  PhotosViewModel.swift
//  Photos
//
//  Created by techthings on 10/5/16.
//  Copyright © 2016 Ezequiel França. All rights reserved.
//

import UIKit
import RxViewModel
import RxSwift
import RxCocoa

public class PhotosViewModel: RxViewModel {
    
    public var photo:Photos?
    private let disposeBag = DisposeBag()
    
    public var title: String?
    public var url: String?
    public var internalIdentifier: Int?
    public var thumbnailUrl: String?
    public var albumId: Int?
    
    public override init ()
    {
        super.init()
        
        
        self.didBecomeActive.subscribeNext { [weak self] _ in
            
            if let strongSelf = self {
                print(strongSelf)
            }
            
            }.addDisposableTo(self.disposeBag)
        
    }
    
    init(photo: Photos){
        
        self.photo = photo
        super.init()
        
    }
    
}