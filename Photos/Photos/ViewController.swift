//
//  ViewController.swift
//  Photos
//
//  Created by techthings on 10/5/16.
//  Copyright © 2016 Ezequiel França. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import Foundation
import ObjectMapper
import BusyNavigationBar



class ListViewController: UIViewController, ErrorAlerts, NetworkManager {
    
    @IBOutlet var tableView: UITableView!
    
    var disposeBag = DisposeBag()
    
    var viewModels = ViewModel()
    
    var manager:PhotoManager = PhotoManager(downloader: PhotoApi())
    
    //let data = Observable.just([Contributor]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoaderNavigation()
        print("viewDidLoad")
        
        //        viewModels.bindTo(tableView.rx_itemsWithCellIdentifier(PhotoCell.reuseIdentifier!)) { _, model, cell in
        //            let cell:PhotoCell = cell as! PhotoCell
        //            cell.setup(model)
        //            }
        //            .addDisposableTo(disposeBag)
        
        viewModels.data
            .drive(tableView.rx_itemsWithCellIdentifier(PhotoCell.reuseIdentifier!)) { _, photo, cell in
                let cell:PhotoCell = cell as! PhotoCell
                cell.setup(PhotosViewModel(photo: photo))
            }
            .addDisposableTo(disposeBag)
        
        manager.getViewModels()
            .subscribe(
                onError: { error in
                    self.showError(ErrorOptions(message: (error as NSError).domain))
                },
                onCompleted: {
                    self.stopLoaderNavigation()
                },
                onDisposed: {
                    print("Disposed 😎")
                }
            )
            .addDisposableTo(disposeBag)
    }
}

