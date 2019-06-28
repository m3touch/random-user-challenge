//
//  Utils.swift
//  RandomUserChallengeTests
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

@testable import RandomUserChallenge

struct RandomUserStub {
    static var firstUser: RandomUser {
        //swiftlint:disable:next force_try
        return try! RandomUser(
            id: "0FDA2BD6-7D62-40B6-9F13-9FD8C27B2FE3",
            name: "FirstUser",
            surname: "FirstSurname",
            gender: "male",
            street: "Street 1",
            city: "City 1",
            state: "State 1",
            phoneNumber: "+34 111",
            email: "111@111.com",
            thumbnail: "https://react.semantic-ui.com/images/avatar/large/molly.png",
            picture: "https://react.semantic-ui.com/images/avatar/large/molly.png",
            registeredDate: "11:11:11 11/11/11"
        )
    }

    static var secondUser: RandomUser {
        //swiftlint:disable:next force_try
        return try! RandomUser(
            id: "6F412147-FA07-4724-94C0-2EFFFFAA7EEC",
            name: "SecondUser",
            surname: "SecondSurname",
            gender: "female",
            street: "Street 2",
            city: "City 2",
            state: "State 2",
            phoneNumber: "+34 222",
            email: "222@222.com",
            thumbnail: "https://semantic-ui.com/images/avatar2/large/kristy.png",
            picture: "https://semantic-ui.com/images/avatar2/large/kristy.png",
            registeredDate: "22:22:22 22/22/22"
        )
    }
}
