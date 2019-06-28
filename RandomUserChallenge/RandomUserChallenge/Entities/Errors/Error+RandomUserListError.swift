//
//  RandomUserListError.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

protocol UIError: Error {
    var userMessage: String? { get }
}

enum RandomUserListError: UIError {
    var userMessage: String? {
        switch self {
        case .anyUserFound(userMessage: let message):
            return message
        default:
            return nil
        }
    }

    case anyUserFound(userMessage: String?)
    case unableToLoadUsers(userMessage: String?)
    case noMoreUsersToLoad(userMessage: String?)
}
