//
//  SegueHandler.swift
//  Photos
//
//  Created by techthings on 10/10/16.
//  Copyright © 2016 Ezequiel França. All rights reserved.
//

import UIKit
import Foundation

protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self: UIViewController,
    SegueIdentifier.RawValue == String
{
    func performSegueWithIdentifier(segueIdentifier: SegueIdentifier,
                                    sender: AnyObject?) {
        performSegueWithIdentifier(segueIdentifier.rawValue, sender: sender)
    }
    func segueIdentifierForSegue(segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier,
            segueIdentifier = SegueIdentifier(rawValue: identifier) else { fatalError("Invalid segue identifier \(segue.identifier).") }
        return segueIdentifier
    }
}