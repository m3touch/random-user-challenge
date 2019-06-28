//
//  APIWorkerProtocol.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

protocol APIWorkerProtocol {
    /**
     Downloads the provided number of RandomUsers for the given page from the API. The provided random users will be filtered to be unique.

     - parameters:
         - page: The page to be loaded
         - resultsPerPage: The number of results that must be shown
         - onSuccess: Callback with the resultant array of RandomUser.
         - onError: Callback for a failure in the fetching process with the explaination.
     */
    func fetch(page: Int, resultsPerPage: Int, onSuccess: @escaping (_ users: [RandomUser]) -> Void, onError: @escaping (_ error: APIError?) -> Void)
}
