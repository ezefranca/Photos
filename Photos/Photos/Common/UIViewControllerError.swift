//
//  UIViewControllerError.swift
//  Photos
//
//  Created by Ezequiel on 06/10/16.
//  Copyright © 2016 Ezequiel França. All rights reserved.
//

import UIKit
import LNRSimpleNotifications
import BusyNavigationBar
import RxSwift

extension UIViewController {
    func storyboardName() -> String {
        let storyboardName = "Main"
        return storyboardName
    }
}

enum typeAlert {
    case error
    case done
    case warning
    
    var color: UIColor {
        switch self {
        case .error: return UIColor.redColor()
        case .done: return UIColor.greenColor()
        case .warning: return UIColor.orangeColor()
        }
    }
}

struct Options {
    let message: String
    let title: String
    var notificationManager = LNRNotificationManager()
    
    init(message: String, title: String = "Internet", type: typeAlert) {
        notificationManager.notificationsPosition = LNRNotificationPosition.Top
        notificationManager.notificationsBackgroundColor = type.color
        notificationManager.notificationsTitleTextColor = UIColor.whiteColor()
        notificationManager.notificationsBodyTextColor = UIColor.whiteColor()
        notificationManager.notificationsSeperatorColor = UIColor.whiteColor()
        self.message = message
        self.title =  title
    }
}

protocol Alerts {
    func showMessage(options: Options)
}

extension Alerts where Self: UIViewController {
    func showMessage(options: Options) {
        options.notificationManager.showNotification(options.title, body: options.message, onTap: nil)
        self.navigationController?.navigationBar.stop()
    }
    
}


struct NetworkOptions {
    var options = BusyNavigationBarOptions()
    
    init() {
        options.animationType = .Stripes
        options.color = UIColor.whiteColor()
        options.alpha = 1
        options.barWidth = 20
        options.gapWidth = 30
        options.speed = 1
        options.transparentMaskEnabled = true
    }
}

protocol NetworkManager {
    func showLoaderNavigation(options: NetworkOptions)
    func stopLoaderNavigation()
}


extension NetworkManager where Self: UIViewController {
    
    func showLoaderNavigation(options: NetworkOptions = NetworkOptions()) {
        self.navigationController?.navigationBar.start(options.options)
    }
    
    func stopLoaderNavigation() {
        self.navigationController?.navigationBar.stop()
    }
    
    
}