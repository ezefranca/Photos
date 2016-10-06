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

class ViewController: UIViewController, ErrorAlerts {
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let p:PhotoApi = Photo()
        print("viewDidLoad")
        let manager = PhotoManager(downloader: PhotoApi())
        
        manager.getViewModels()
            .subscribe(
                onNext: { data in
                    print("Next 💪")
                },
                onError: { error in
                    self.showError(ErrorOptions(message: (error as NSError).domain))
                },
                onCompleted: {
                    print("Completo 💪")
                },
                onDisposed: {
                    print("Disposed 😎")
                }
            )
            .addDisposableTo(disposeBag)
        
        
        
        //        let photoAPI = PhotoApi()
        //        
        //        
        //        photoAPI.download()
        //        
        //        photoAPI.download()
        //            // tenta 3 vezes
        //            .retry(3)
        //            // 5 segundos maximo de timeout
        //            .timeout(5, scheduler: MainScheduler.instance)
        //            // adicionar backgroud thread
        //            .subscribeOn(photoAPI.backgroundScheduler)
        //            // Adicionar main thread
        //            .observeOn(photoAPI.mainScheduler)
        //            .subscribe(
        //                onNext: { data in
        //                    
        //                    do {
        //                        let json : AnyObject! = try NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions.MutableContainers)
        //                        let customer : Array<Photos> = Mapper<Photos>().mapArray(json)!
        //                        let photo = PhotosViewModel(photo: customer.first!)
        //                        print(photo.title)
        //                    } catch {
        //                        print(NSString(data: data as! NSData, encoding: NSUTF8StringEncoding))
        //                    }
        //                    
        //                },
        //                onError: { error in
        //                    print(error)
        //                },
        //                onCompleted: {
        //                    print("Completo 💪")
        //                },
        //                onDisposed: {
        //                    print("Disposed 😎")
        //                }
        //            )
        //            .addDisposableTo(disposeBag)
    }
    
}
