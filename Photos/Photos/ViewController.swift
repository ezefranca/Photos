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
    
    @IBOutlet var refresh: UIBarButtonItem!
    
    var disposeBag = DisposeBag()
    var api = PhotoApi()
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.download()
        
        print("viewDidLoad")
        
        //        manager.getViewModels()
        
        
        //        refresh.rx_tap.asDriver()
        //            .driveNext { [unowned self] in
        //                //self.viewModel.data
        //                //.drive(tableView.rx_itemsWithCellIdentifier(PhotoCell.reuseIdentifier!, cellType: PhotoCell.self))
        //                .addDisposableTo(self.disposeBag)
        //        }
        
        
        //            .subscribe(
        //                onError: { error in
        //                    self.showError(ErrorOptions(message: (error as NSError).domain))
        //                },
        //                onCompleted: {
        //                    print("Completo 😎")
        //                    self.stopLoaderNavigation()
        //                },
        //                onDisposed: {
        //                    print("Disposed 😎")
        //                }
        //        )
        
        
        viewModel.data.asObservable()
            .subscribe(onNext: { (_) in
                print("PROXIMOO 😎")
                }, onError: { (_) in
                    print("Erro 😎")
                }, onCompleted: {
                    //Quando todos ViewModels ja foram usados
                    print("Completo 😎")
            }) {
            }
            .addDisposableTo(disposeBag)
        
        viewModel.data
            .drive(tableView.rx_itemsWithCellIdentifier(PhotoCell.reuseIdentifier!)) { _, photo, cell in
                let cell:PhotoCell = cell as! PhotoCell
                cell.setup(PhotosViewModel(photo: photo))
            }
            .addDisposableTo(disposeBag)
        
        
        
        //        viewModel.data.asObservable()
        //            .subscribeNext { (photos) in
        //                print(photos.first!.title)
        //            }
        //            .addDisposableTo(disposeBag)
        
    }
}

