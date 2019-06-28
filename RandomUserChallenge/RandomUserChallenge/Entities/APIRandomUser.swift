//
//  APIRandomUser.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

struct APIRandomUser: Decodable {

    struct Name: Decodable {
        var title: String?
        var first: String?
        var last: String?
    }

    struct Location: Decodable {
        var street: String?
        var city: String?
        var state: String?
    }

    struct Login: Decodable {
        var uuid: String?
    }

    struct Registered: Decodable {
        var date: String?
    }

    struct Picture: Decodable {
        var large: String?
        var medium: String?
        var thumbnail: String?
    }

    var gender: String?
    var name: Name
    var location: Location
    var email: String?
    var login: Login
    var registered: Registered
    var phone: String?
    var picture: Picture

    /**
     Assembles the raw APIRandomUser to a processed RandomUser.

     - returns: A RandomUser from the RawRandomUser data.
     */
    func assembleRandomUser() -> RandomUser? {
        return try? RandomUser(
            id: login.uuid ?? "",
            name: name.first,
            surname: name.last,
            gender: gender,
            street: location.street,
            city: location.city,
            state: location.state,
            phoneNumber: phone,
            email: email,
            thumbnail: picture.medium,
            picture: picture.large,
            registeredDate: registered.date
        )
    }
}
