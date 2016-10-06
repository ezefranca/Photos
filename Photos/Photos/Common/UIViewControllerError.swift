//
//  UIViewControllerError.swift
//  Photos
//
//  Created by Ezequiel on 06/10/16.
//  Copyright © 2016 Ezequiel França. All rights reserved.
//

import UIKit
import LNRSimpleNotifications

struct ErrorOptions {
    let message: String
    let title: String
    var notificationManager = LNRNotificationManager()
    
    init(message: String, title: String = "Erro de conexão!") {
        notificationManager.notificationsPosition = LNRNotificationPosition.Top
        notificationManager.notificationsBackgroundColor = UIColor.redColor()
        notificationManager.notificationsTitleTextColor = UIColor.whiteColor()
        notificationManager.notificationsBodyTextColor = UIColor.lightGrayColor()
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
    }
}