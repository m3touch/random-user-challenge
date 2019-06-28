//
//  RandomUserDetailInteractor.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

final class RandomUserDetailInteractor: RandomUserDetailInteractorProtocol {
    private var presenter: RandomUserDetailPresenterProtocol

    init(presenter: RandomUserDetailPresenterProtocol) {
        self.presenter = presenter
    }
}
