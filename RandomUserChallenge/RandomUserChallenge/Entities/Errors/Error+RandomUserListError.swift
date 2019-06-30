//
//  RandomUserListError.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

// MARK: - Review this!!!!!
enum RandomUserListError: Error {
    case anyUserFound(userMessage: String?)
    case unableToLoadUsers(userMessage: String?)
    case noMoreUsersToLoad(userMessage: String?)
}
