//
//  ListViewController.swift
//  Photos
//
//  Created by techthings on 10/10/16.
//  Copyright © 2016 Ezequiel França. All rights reserved.
//

import UIKit
import Foundation
import XCTest
import ObjectMapper
import SwiftyJSON
@testable import Photos

class ListViewControllerTests: XCTestCase {
    
    func testListViewController()
    {
        let title = "accusamus beatae ad facilis cum similique qui sunt"
        let url = "http://placehold.it/600/92c952"
        let internalIdentifier = 1
        let thumbnailUrl = "http://placehold.it/150/30ac17"
        let albumId = 1
        
        let json: [String: AnyObject] = ["albumId": albumId, "url": url, "id": internalIdentifier, "thumbnailUrl": thumbnailUrl, "title" : title]
        
        let viewModel = PhotosViewModel(photo: Photos(object: json))
        
        let sb = UIStoryboard(name: "Main", bundle: NSBundle(identifier: ListViewController.identifier))
        let vc = sb.instantiateViewControllerWithIdentifier(ListViewController.identifier) as! ListViewController
        
        vc.photoViewModels = [viewModel]
        //vc.assertDependencies(viewModel)
        //vc.inject(viewModel)
        
        XCTAssertNotNil(vc)
        XCTAssertEqual(title, vc.photoViewModels[0]?.title)
    }
    
    
}
