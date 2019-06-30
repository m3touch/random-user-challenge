//
//  UIInstantiable.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import UIKit

/**
 Enables automatic instantiation from a xib file.
 */
protocol UIInstantiable {
    static func instiantate() -> Self
}

extension UIInstantiable where Self: UIViewController {
    static func instiantate() -> Self {
        let xibName = String(describing: self)
        return Self.init(nibName: xibName, bundle: Bundle.main)
    }
}
