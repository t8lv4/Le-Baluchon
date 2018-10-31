//
//  UIViewController+ActivityIndicator.swift
//  Le Baluchon
//
//  Created by Morgan on 29/10/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

extension UIViewController {

    /// Toggle an activity indicator
    func toggleActivityIndicator(_ indicator: UIActivityIndicatorView, shown: Bool) {
        indicator.isHidden = !shown
    }

}
