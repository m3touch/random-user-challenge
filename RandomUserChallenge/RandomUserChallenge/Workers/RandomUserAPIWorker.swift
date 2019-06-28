//
//  RandomUserAPIWorker.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import Foundation

final class RandomUserAPIWorker: APIWorkerProtocol {

    private struct FetchedData: Decodable {
        var results: [APIRandomUser]
    }

    func fetch(page: Int, resultsPerPage: Int,
               onSuccess: @escaping (_ users: [RandomUser]) -> Void,
               onError: @escaping (_ error: APIError?) -> Void) {
        guard
            let url = getRandomUsersCall(page: page, resultsPerPage: resultsPerPage)
        else {
            onError(APIError.unableToBuildCall)
            return
        }

        HttpClientBuilder().build(method: .get, url: url) { (jsonData: Data?, error) in
            guard
                error == nil,
                let data = jsonData
            else {
                onError(APIError.serviceCallFailed)
                return
            }

            guard
                let fetchedData = try? JSONDecoder().decode(FetchedData.self, from: data)
            else {
                onError(APIError.unexpectedServiceAnswerFormat)
                return
            }

            let assembledRandomUsers = fetchedData.results.compactMap { rawRandomUser in rawRandomUser.assembleRandomUser() }
            onSuccess(RandomUserAPIWorker.removeRepetitions(inRandomUsersSequence: assembledRandomUsers))
        }
    }

    // MARK: - Private Interface

    fileprivate func getRandomUsersCall(page: Int, resultsPerPage: Int) -> URL? {
        return RandomUsersAPIUrlBuilder(
            requestInfo: false,
            page: page,
            results: resultsPerPage,
            includedProperties: [.login, .gender, .name, .location, .email, .registered, .phone, .picture]
        ).build()
    }

    fileprivate static func removeRepetitions(inRandomUsersSequence users: [RandomUser]) -> [RandomUser] {
        var uniqueRandomUsers: [UUID: RandomUser] = [:]
        users.forEach { user in uniqueRandomUsers[user.id] = user }

        return Array(uniqueRandomUsers.values)
    }
}
