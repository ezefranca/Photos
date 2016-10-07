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

var manager:PhotoManager = PhotoManager(downloader: PhotoApi())

class ListViewController: UIViewController, ErrorAlerts, NetworkManager {
    
    @IBOutlet var tableView: UITableView!
    var disposeBag = DisposeBag()
    var viewModels:[PhotosViewModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoaderNavigation()
        self.setupTableView()
        print("viewDidLoad")
        
        
        manager.getViewModels()
            .subscribe(
                onError: { error in
                    self.showError(ErrorOptions(message: (error as NSError).domain))
                },
                onCompleted: {
                    self.tableView.reloadData()
                    self.stopLoaderNavigation()
                    //                    print("Completo 💪")
                    //                    self.navigationController?.navigationBar.stop()
                    //                    print(manager.photoViewModels.count)
                    //                    print("aaaa")
                },
                onDisposed: {
                    print("Disposed 😎")
                }
            )
            .addDisposableTo(disposeBag)
    }
    
    func setupTableView() {
        tableView.dataSource = self
        //tableView.delegate =  self
    }
    
}

