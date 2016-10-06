//
//  PhotosViewModelTests.swift
//  Photos
//
//  Created by Ezequiel on 06/10/16.
//  Copyright © 2016 Ezequiel França. All rights reserved.
//

import XCTest
import RxSwift
import ObjectMapper

@testable import Photos

class PhotosViewModelTests: XCTestCase {
    var viewModel: PhotosViewModel?
    let disposable = DisposeBag()
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testInitWithModel() {
        
        let title = "accusamus beatae ad facilis cum similique qui sunt"
        let url = "http://placehold.it/600/92c952"
        let internalIdentifier = 1
        let thumbnailUrl = "http://placehold.it/150/30ac17"
        let albumId = 1
        
        let json: [String: AnyObject] = ["albumId": albumId, "url": url, "id": internalIdentifier, "thumbnailUrl": thumbnailUrl, "title" : title]
        
        let p = Photos()
        p.title = title
        _ = Mapper().map(json, toObject: p)
        XCTAssertNotNil(p)
        
        self.viewModel = PhotosViewModel(photo: p)
        
        guard let vm = self.viewModel else {
            return
        }
        
        XCTAssertNotNil(vm)
        XCTAssertEqual(title, vm.title)
        XCTAssertEqual(url, vm.url)
        XCTAssertEqual(internalIdentifier, vm.internalIdentifier)
        XCTAssertEqual(thumbnailUrl, vm.thumbnailUrl)
        XCTAssertEqual(albumId, vm.albumId)
        
    }
}
