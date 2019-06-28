//
//  APIError.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 27/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

enum APIError: Error {
    case
    unableToBuildCall,
    serviceCallFailed,
    unexpectedServiceAnswerFormat
}
