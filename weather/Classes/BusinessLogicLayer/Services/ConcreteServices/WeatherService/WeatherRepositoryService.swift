//
// Created by Юрий Трыков on 27.08.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

protocol WeatherRepositoryServiceType {

    func cities() -> Observable<[CityVO]>

    func saveCities(_ cities: [CityVO]) -> Observable<[CityVO]>
}

class WeatherRepositoryService: WeatherRepositoryServiceType {

    func cities() -> Observable<[CityVO]> {
        guard let repository = try? RealmRepository<CityDBO>() else {
            return Observable.error(RealmRepositoryError.createError)
        }
        return repository.fetchAll()
    }

    func saveCities(_ cities: [CityVO]) -> Observable<[CityVO]> {
        guard let repository = try? RealmRepository<CityDBO>() else {
            return Observable.error(RealmRepositoryError.createError)
        }
        return repository.save(items: cities)
                .map { cities }
    }
}
