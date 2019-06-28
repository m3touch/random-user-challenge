//
//  HttpClientBuilder.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import Alamofire
import Foundation

final class HttpClientBuilder {

    enum Error {
        case callFailed(debugDescription: String)
        case malformedData
    }

    enum HttpProtocol {
        case get

        func toAlamofireMethod() -> Alamofire.HTTPMethod {
            switch self {
            case .get: return .get
            }
        }
    }

    func build(headers: [String: String]? = nil, method: HttpProtocol, url: URL, parameters: [String: Any]? = nil,
               completion: @escaping (_ response: Data?, _ error: HttpClientBuilder.Error?) -> Void) {

        Alamofire.SessionManager.default
            .request(url as URLConvertible, method: method.toAlamofireMethod(), parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { (responseData) in
                switch responseData.result {
                case .failure(let error):
                    completion(nil, Error.callFailed(debugDescription: error.localizedDescription))

                case .success(let data):
                    guard
                        let jsonData = try? JSONSerialization.data(withJSONObject: data, options: [])
                    else {
                        completion(nil, Error.malformedData)
                        return
                    }

                    completion(jsonData, nil)
                }
            }
    }
}
