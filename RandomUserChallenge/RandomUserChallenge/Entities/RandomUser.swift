//
//  RandomUser.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import Foundation

struct RandomUser: Equatable {
    let id: UUID
    let name: String?
    let surname: String?
    let gender: String?
    let location: RandomUserLocation
    let phoneNumber: String?
    let email: String?
    let thumbnail: URL?
    let picture: URL?
    let registeredDate: String?

    init(id: String, name: String?, surname: String?, gender: String?, street: String?, city: String?, state: String?, phoneNumber: String?, email: String?, thumbnail: String?, picture: String?, registeredDate: String?) throws {

        guard
            let idUUID = UUID(uuidString: id)
        else {
            throw RandomUserError.invalidUUID(wrongIdentifier: id)
        }

        self.id = idUUID
        self.name = name
        self.surname = surname
        self.gender = gender
        self.location = RandomUserLocation(street: street, city: city, state: state)
        self.phoneNumber = phoneNumber
        self.email = email
        self.thumbnail = URL(string: thumbnail ?? "")
        self.picture = URL(string: picture ?? "")
        self.registeredDate = registeredDate
    }

    static func == (lhs: RandomUser, rhs: RandomUser) -> Bool {
        return lhs.id == rhs.id
    }
}
