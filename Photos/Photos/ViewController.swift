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

class ListViewController: UIViewController, Alerts, NetworkManager {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var refreshData: UIBarButtonItem!
    
    var disposeBag = DisposeBag()
    var api = PhotoApi()
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.download()
        
        print("viewDidLoad")
        print(PhotoCell.reuseIdentifier)
        self.showLoaderNavigation()
        
        Reachable.filterInternetIsActive()
            
            .subscribeNext { (status) in
                self.updateViewModelObservable()
            }
            .addDisposableTo(self.disposeBag)
        
        
        Reachable.filterInternetIsOffline()
            .subscribeNext { (status) in
                self.showMessage(Options(message: "Falha de internet", type: .error))
                self.stopLoaderNavigation()
            }
            .addDisposableTo(self.disposeBag)
        
        refreshData.rx_tap.asDriver()
            .driveNext { [unowned self] in
                self.showLoaderNavigation()
                self.updateViewModelObservable()
            }
            .addDisposableTo(disposeBag)
        
        
    }
    
    func updateViewModelObservable() {
        
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        self.viewModel.data.asDriver()
            .asObservable()
            .observeOn(MainScheduler.instance)
            .bindTo(self.tableView.rx_itemsWithCellIdentifier(PhotoCell.reuseIdentifier)) { _, photo, cell in
                let cell:PhotoCell = cell as! PhotoCell
                cell.setup(PhotosViewModel(photo: photo))
            }
            .addDisposableTo(self.disposeBag)
        self.stopLoaderNavigation()
        
    }
}

