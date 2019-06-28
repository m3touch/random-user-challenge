//
//  RandomUsersAPIUrlBuilder.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import Foundation

struct RandomUsersAPIUrlBuilder {
    //https://randomuser.me/api/?noinfo&page=1&results=3&inc=login,gender,name,location,email,registered,phone,picture

    enum RandomUsersProperties: String {
        case gender, name, location, email, login, registered, dob, phone, cell, id, picture, nat
    }

    private let noInfo: String = "noinfo"
    private let baseUrl: String = "https://randomuser.me/api"
    var requestInfo = false
    var page: Int?
    var results: Int?
    var includedProperties: [RandomUsersProperties]?

    /**
     Builds a RandomUsers API call to request the required information.

     - returns: The URL to fetch the required information.
     */
    func build() -> URL? {
        var url = baseUrl

        if !requestInfo || page != nil || results != nil || includedProperties != nil {
            url += "/?"
        }

        if !requestInfo {
            url += "\(noInfo)"
        }

        if let pageToFetch = page {
            url += "&page=\(pageToFetch)"
        }

        if let resultsToShow = results {
            url += "&results=\(resultsToShow)"
        }

        if let includedPropertiesToGet = includedProperties {
            url += "&inc="
            includedPropertiesToGet.forEach { propertyName in url += "\(propertyName.rawValue)," }
        }

        return URL(string: url)
    }
}
