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

struct ErrorOptions {
    let message: String
    let title: String
    var notificationManager = LNRNotificationManager()
    
    init(message: String, title: String = "Erro de conexão!") {
        notificationManager.notificationsPosition = LNRNotificationPosition.Top
        notificationManager.notificationsBackgroundColor = UIColor.redColor()
        notificationManager.notificationsTitleTextColor = UIColor.whiteColor()
        notificationManager.notificationsBodyTextColor = UIColor.whiteColor()
        notificationManager.notificationsSeperatorColor = UIColor.whiteColor()
        self.message = message
        self.title =  title
    }
}

protocol ErrorAlerts {
    func showError(errorOptions: ErrorOptions)
}

extension ErrorAlerts where Self: UIViewController {
    func showError(errorOptions: ErrorOptions) {
        errorOptions.notificationManager.showNotification(errorOptions.title, body: errorOptions.message, onTap: nil)
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