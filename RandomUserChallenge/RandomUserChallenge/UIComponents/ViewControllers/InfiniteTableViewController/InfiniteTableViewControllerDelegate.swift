//
//  InfiniteTableViewControllerDelegate.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import UIKit

// TODO: AssociatedType instead of RandomUser. Add abstraction of the required cell to be shown to make it cell adnostic, it only manages cells.
protocol InfiniteTableViewControllerDelegate: class {
    var infiniteTableViewDataSource: [RandomUser] { get }

    func getCellDataForRowAt(indexPath: IndexPath) -> RandomUser?
    func deleteUserAtRow(indexPath: IndexPath)
    func loadMoreData()
    // TODO: --> Notify of a selected item
}
