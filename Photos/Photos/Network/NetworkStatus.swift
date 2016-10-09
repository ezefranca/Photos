//
//  NetworkStatus.swift
//  Photos
//
//  Created by Ezequiel on 08/10/16.
//  Copyright © 2016 Ezequiel França. All rights reserved.
//

import ReachabilitySwift
import RxSwift

let Reachable = _Reachable()
struct _Reachable {
    
    let reachability: Reachability
    let disposeBag = DisposeBag()
    let internetStatus = Variable<Reachability.NetworkStatus>(.NotReachable)
    
    private init() {
        reachability = try! Reachability.reachabilityForInternetConnection()
        createObservable().bindTo(self.internetStatus).addDisposableTo(disposeBag)
    }
    
    private func createObservable()-> Observable<Reachability.NetworkStatus> {
        return Observable.create { observer in
            let cancel = AnonymousDisposable {
                self.reachability.stopNotifier()
            }
            let reachableUpdateBlock: (Reachability-> Void) = { r in
                observer.onNext(r.currentReachabilityStatus)
            }
            
            self.reachability.whenReachable = reachableUpdateBlock
            self.reachability.whenUnreachable = reachableUpdateBlock
            
            try! self.reachability.startNotifier()
            return cancel
        }
    }
    
    func filterInternetIsActive()-> Observable<Reachability.NetworkStatus> {
        return Reachable.internetStatus.asObservable().filter { status in
            switch status {
            case .NotReachable:
                return false
            default:
                return true
            }
        }
    }
    
    func filterInternetIsOffline()-> Observable<Reachability.NetworkStatus> {
        return Reachable.internetStatus.asObservable().filter { status in
            switch status {
            case .NotReachable:
                return true
            default:
                return false
            }
        }
    }
}
