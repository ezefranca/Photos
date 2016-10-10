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

class ListViewController: UIViewController, Alerts, SegueHandlerType, CheckDependencies {
    static let identifier = "ListViewController"
    // MARK: Variables and properties
    typealias T = PhotosViewModel
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var refreshData: UIBarButtonItem!
    
    private var disposeBag = DisposeBag()
    private var api = PhotoApi()
    private var viewModelManager = ViewModelManager()
    var photoViewModels = [PhotosViewModel?]()
    private var selectedModel:PhotosViewModel?
    
    enum SegueIdentifier: String {
        case DetailViewController
    }
    
    // MARK: ViewController lifecicle
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x9B59B6)
    }
    
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
            .observeOn(MainScheduler.instance)
            .subscribeNext { [weak self] indexPath in
                guard let model = self!.photoViewModels[indexPath.row] else {
                    return
                }
                self!.selectedModel = model
                self?.tableView.cellForRowAtIndexPath(indexPath)?.selected = false
                self!.performSegueWithIdentifier(.DetailViewController, sender: nil)
            }
            .addDisposableTo(disposeBag)
        
        self.updateViewModelObservable()
    }
    
    func assertDependencies<T>(dependencies: T?) {
        assert(dependencies != nil)
    }
}

// MARK: Fetch Data and Network Manager

extension ListViewController : NetworkManager {
    
    func initObservables() {
        
        Reachable.filterInternetIsActive()
            .subscribeNext { (status) in
                self.stopLoaderNavigation()
                self.showMessage(Options(message: status.description, type: .done))
            }
            .addDisposableTo(self.disposeBag)
        
        
        Reachable.filterInternetIsOffline()
            .subscribeNext { (status) in
                self.stopLoaderNavigation()
                self.showMessage(Options(message: status.description, type: .error))
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
            .observeOn(MainScheduler.instance)
            .bindTo(self.tableView.rx_itemsWithCellIdentifier(PhotoCell.reuseIdentifier)) { _, photo, cell in
                let model = PhotosViewModel(photo: photo)
                self.photoViewModels.append(model)
            }
            .addDisposableTo(self.disposeBag)
        
        tableView.rx_willDisplayCell.subscribeNext{ (cell, indexPath) in
            let cell:PhotoCell = cell as! PhotoCell
            cell.setup(self.photoViewModels[indexPath.row]!)
            }.addDisposableTo(disposeBag)
    }
    
}


// MARK: Details

extension ListViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        switch segueIdentifierForSegue(segue) {
            
        case .DetailViewController:
            let details = segue.destinationViewController as? DetailViewController
            details!.inject(selectedModel!)
        }
    }
    
    
}




