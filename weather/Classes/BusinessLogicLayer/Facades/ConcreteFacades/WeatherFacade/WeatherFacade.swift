//
// Created by Юрий Трыков on 30.09.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation
import RxSwift

protocol WeatherFacadeType {

    func cities() -> Observable<[CityVO]>

    func forecasts(with cityId: Int) -> Observable<[ForecastVO]>

}

class WeatherFacade: WeatherFacadeType {

    private let weatherNetworkService: WeatherNetworkServiceType
    private let weatherRepositoryService: WeatherRepositoryServiceType

    // MARK: - Init

    init(weatherNetworkService: WeatherNetworkServiceType,
         weatherRepositoryService: WeatherRepositoryServiceType) {
        self.weatherNetworkService = weatherNetworkService
        self.weatherRepositoryService = weatherRepositoryService
    }

    func cities() -> Observable<[CityVO]> {
        let networkCities = weatherNetworkService.cities()
                .map { $0.compactMap(CityVO.init)}
                .flatMap(weatherRepositoryService.saveCities)

        return weatherRepositoryService.cities()
                .flatMap { cities -> Observable<[CityVO]> in
                    guard !cities.isEmpty else {
                        return networkCities
                    }
                    return Observable.just(cities)
                }
    }

    func forecasts(with cityId: Int) -> Observable<[ForecastVO]> {
        weatherNetworkService.forecasts(with: cityId)
                .map { $0.compactMap(ForecastVO.init)}
    }
}
