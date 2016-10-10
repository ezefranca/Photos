//
//  CheckDependencies.swift
//  Photos
//
//  Created by techthings on 10/10/16.
//  Copyright © 2016 Ezequiel França. All rights reserved.
//

import Foundation

struct Dependencie<T> {
    var value: T
}

protocol CheckDependencies {
    func assertDependencies<T>(dependencies : T?)
}

extension CheckDependencies where Self: DetailViewController {
    
    func inject(injection: PhotosViewModel){
        self.model = injection
    }
    
}

extension CheckDependencies where Self: ListViewController {
    
    func inject(injection: [PhotosViewModel?]){
        self.photoViewModels = injection
    }
    
}
