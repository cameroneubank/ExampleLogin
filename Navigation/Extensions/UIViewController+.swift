//
//  UIViewController+.swift
//  Navigation
//
//  Created by Cameron Eubank on 8/23/22.
//

import Foundation
import UIKit

extension UIViewController {
    func embeddedInNavigationController() -> UIViewController {
        UINavigationController(rootViewController: self)
    }
}
