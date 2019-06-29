//
//  InfiniteTableViewControllerDelegate.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import UIKit

protocol InfiniteTableViewControllerDelegate: class {
    var dataSourceCount: Int { get }

    func getCellDataForRowAt(indexPath: IndexPath) -> RandomUser?
    func deleteUserAtRow(indexPath: IndexPath)
    func loadMoreData()
    func selectedCellAt(indexPath: IndexPath)
}
