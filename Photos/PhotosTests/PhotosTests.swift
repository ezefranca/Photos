//
//  PhotosTests.swift
//  Photos
//
//  Created by Ezequiel on 06/10/16.
//  Copyright © 2016 Ezequiel França. All rights reserved.
//

//        albumId": 1,
//        "id": 1,
//        "title": "accusamus beatae ad facilis cum similique qui sunt",
//        "url": "http://placehold.it/600/92c952",
//        "thumbnailUrl": "http://placehold.it/150/30ac17"

import Foundation
import XCTest
import ObjectMapper
import SwiftyJSON
@testable import Photos

class PhotoTests: XCTestCase {
    
    let photoMapper = Mapper<Photos>()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBasicParsing() {
        
        let title = "accusamus beatae ad facilis cum similique qui sunt"
        let url = "http://placehold.it/600/92c952"
        let internalIdentifier = 1
        let thumbnailUrl = "http://placehold.it/150/30ac17"
        let albumId = 1
        
        let photoJSONString = "{\"albumId\":\(albumId),\"url\":\"\(url)\",\"id\":\(internalIdentifier),\"thumbnailUrl\":\"\(thumbnailUrl)\", \"title\":\"\(title)\"}"
        
        print(photoJSONString)
        
        let photo = photoMapper.map(photoJSONString)
        
        XCTAssertNotNil(photo)
        XCTAssertEqual(title, photo!.title)
        XCTAssertEqual(url, photo!.url)
        XCTAssertEqual(internalIdentifier, photo!.internalIdentifier)
        XCTAssertEqual(thumbnailUrl, photo!.thumbnailUrl)
        XCTAssertEqual(albumId, photo!.albumId)
        
    }
    
    func testInstanceParsing() {
        
        let title = "accusamus beatae ad facilis cum similique qui sunt"
        let url = "http://placehold.it/600/92c952"
        let internalIdentifier = 1
        let thumbnailUrl = "http://placehold.it/150/30ac17"
        let albumId = 1
        
        let photoJSONString = "{\"albumId\":\(albumId),\"url\":\"\(url)\",\"id\":\(internalIdentifier),\"thumbnailUrl\":\"\(thumbnailUrl)\", \"title\":\"\(title)\"}"
        
        let photo = Mapper<Photos>().mapArray(photoJSONString)
        
        XCTAssertNotNil(photo)
        XCTAssertEqual(title, photo!.first!.title)
        XCTAssertEqual(url, photo!.first!.url)
        XCTAssertEqual(internalIdentifier, photo!.first!.internalIdentifier)
        XCTAssertEqual(thumbnailUrl, photo!.first!.thumbnailUrl)
        XCTAssertEqual(albumId, photo!.first!.albumId)
    }
    
    func testDictionaryParsing() {
        let title = "accusamus beatae ad facilis cum similique qui sunt"
        let url = "http://placehold.it/600/92c952"
        let internalIdentifier = 1
        let thumbnailUrl = "http://placehold.it/150/30ac17"
        let albumId = 1
        
        let json: [String: AnyObject] = ["albumId": albumId, "url": url, "id": internalIdentifier, "thumbnailUrl": thumbnailUrl, "title" : title]
        
        let p = Photos()
        p.title = title
        let photo = Mapper().map(json, toObject: p)
        
        XCTAssertNotNil(photo)
        XCTAssertEqual(title, photo.title)
        XCTAssertEqual(url, photo.url)
        XCTAssertEqual(internalIdentifier, photo.internalIdentifier)
        XCTAssertEqual(thumbnailUrl, photo.thumbnailUrl)
        XCTAssertEqual(albumId, photo.albumId)
    }
    
    func testInstanceWithJSON() {
        let title = "accusamus beatae ad facilis cum similique qui sunt"
        let url = "http://placehold.it/600/92c952"
        let internalIdentifier = 1
        let thumbnailUrl = "http://placehold.it/150/30ac17"
        let albumId = 1
        
        let j: JSON = ["albumId": albumId, "url": url, "id": internalIdentifier, "thumbnailUrl": thumbnailUrl, "title" : title]
        
        let photo = Photos(json: j)
        
        XCTAssertNotNil(photo)
        XCTAssertEqual(title, photo.title)
        XCTAssertEqual(url, photo.url)
        XCTAssertEqual(internalIdentifier, photo.internalIdentifier)
        XCTAssertEqual(thumbnailUrl, photo.thumbnailUrl)
        XCTAssertEqual(albumId, photo.albumId)
    }
    
    
    func testInstanceWithAnyObject() {
        let title = "accusamus beatae ad facilis cum similique qui sunt"
        let url = "http://placehold.it/600/92c952"
        let internalIdentifier = 1
        let thumbnailUrl = "http://placehold.it/150/30ac17"
        let albumId = 1
        
        let j: AnyObject = ["albumId": albumId, "url": url, "id": internalIdentifier, "thumbnailUrl": thumbnailUrl, "title" : title]
        
        let photo = Photos(object: j)
        
        XCTAssertNotNil(photo)
        XCTAssertEqual(title, photo.title)
        XCTAssertEqual(url, photo.url)
        XCTAssertEqual(internalIdentifier, photo.internalIdentifier)
        XCTAssertEqual(thumbnailUrl, photo.thumbnailUrl)
        XCTAssertEqual(albumId, photo.albumId)
    }
    
    func testDictionaryRepresetation() {
        
        let title = "accusamus beatae ad facilis cum similique qui sunt"
        let url = "http://placehold.it/600/92c952"
        let internalIdentifier = 1
        let thumbnailUrl = "http://placehold.it/150/30ac17"
        let albumId = 1
        
        let json: [String: AnyObject] = ["albumId": albumId, "url": url, "id": internalIdentifier, "thumbnailUrl": thumbnailUrl, "title" : title]
        
        let photo = Photos(JSON: json)
        let dictionary = photo!.dictionaryRepresentation()
        let photo2 = Photos(JSON: dictionary)
        
        XCTAssertNotNil(dictionary)
        XCTAssertEqual(json as NSObject, dictionary as NSObject)
        XCTAssertEqual(photo?.title, photo2?.title)
        XCTAssertEqual(photo?.url, photo2?.url)
        XCTAssertEqual(photo?.internalIdentifier, photo2?.internalIdentifier)
        XCTAssertEqual(photo?.thumbnailUrl, photo2?.thumbnailUrl)
        XCTAssertEqual(photo?.albumId, photo2?.albumId)
    }
    
}
