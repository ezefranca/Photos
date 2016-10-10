//
//  DetailsViewControllerTests.swift
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

class DetailViewControllerTests: XCTestCase {
    
    func testDetailViewController()
    {
        let title = "accusamus beatae ad facilis cum similique qui sunt"
        let url = "http://placehold.it/600/92c952"
        let internalIdentifier = 1
        let thumbnailUrl = "http://placehold.it/150/30ac17"
        let albumId = 1
        let json: [String: AnyObject] = ["albumId": albumId, "url": url, "id": internalIdentifier, "thumbnailUrl": thumbnailUrl, "title" : title]
        let viewModel = PhotosViewModel(photo: Photos(object: json))
        let sb = UIStoryboard(name: "Main", bundle: NSBundle(identifier: DetailViewController.identifier))
        let vc = sb.instantiateViewControllerWithIdentifier(DetailViewController.identifier) as! DetailViewController
        vc.inject(viewModel)
        vc.assertDependencies(viewModel)
        XCTAssertNotNil(vc)
        XCTAssertEqual(url, vc.model?.url)
    }
    
    
}

