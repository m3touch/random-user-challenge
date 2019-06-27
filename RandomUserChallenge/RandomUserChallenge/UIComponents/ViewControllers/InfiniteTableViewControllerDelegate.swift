//
//  InfiniteTableViewControllerDelegate.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import UIKit

protocol InfiniteTableViewControllerDelegate: class { // TODO: AssociatedType instead of RandomUser
    var infiniteTableViewDataSource: [RandomUser] { get }

    func getCellDataForRowAt(indexPath: IndexPath) -> RandomUser?
}
