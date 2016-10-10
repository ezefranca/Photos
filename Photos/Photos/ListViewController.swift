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

class ListViewController: UIViewController, Alerts {
    
    // MARK: Variables and properties
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var refreshData: UIBarButtonItem!
    
    private var disposeBag = DisposeBag()
    private var api = PhotoApi()
    private var viewModelManager = ViewModelManager()
    private var photoViewModels = [PhotosViewModel]()
    
    // MARK: ViewController lifecicle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.initObservables()
        self.showLoaderNavigation()
        
        refreshData.rx_tap.asDriver()
            .driveNext { [unowned self] in
                self.showLoaderNavigation()
                self.updateViewModelObservable()
            }
            .addDisposableTo(disposeBag)
        
        tableView.rx_itemSelected
            .subscribeNext { [unowned self] indexPath in
                self.presentDetails(indexPath)
            }
            .addDisposableTo(disposeBag)
    }
}

// MARK: Fetch Data and Network Manager

extension ListViewController : NetworkManager {
    
    func initObservables() {
        
        Reachable.filterInternetIsActive()
            
            .subscribeNext { (status) in
                self.updateViewModelObservable()
                self.stopLoaderNavigation()
            }
            .addDisposableTo(self.disposeBag)
        
        
        Reachable.filterInternetIsOffline()
            .subscribeNext { (status) in
                self.stopLoaderNavigation()
                self.showMessage(Options(message: "Falha de internet", type: .error))
            }
            .addDisposableTo(self.disposeBag)
    }
    
    func updateViewModelObservable() {
        
        self.stopLoaderNavigation()
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        self.viewModelManager.data
            .asDriver()
            .asObservable()
            .bindTo(self.tableView.rx_itemsWithCellIdentifier(PhotoCell.reuseIdentifier)) { _, photo, cell in
                let cell:PhotoCell = cell as! PhotoCell
                let model = PhotosViewModel(photo: photo)
                self.photoViewModels.append(model)
                cell.setup(model)
            }
            .addDisposableTo(self.disposeBag)
    }
    
}


// MARK: Details

extension ListViewController {
    
    
    
    private func presentDetails(index:NSIndexPath) {
        let sb = UIStoryboard(name: self.storyboardName(), bundle: NSBundle(identifier: DetailViewController.identifier))
        let vc = sb.instantiateViewControllerWithIdentifier(DetailViewController.identifier) as! DetailViewController
        vc.model = photoViewModels[index.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}


