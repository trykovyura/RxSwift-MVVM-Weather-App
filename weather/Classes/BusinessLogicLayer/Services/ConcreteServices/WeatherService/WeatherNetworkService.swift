//
// Created by Юрий Трыков on 27.08.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation
import Moya
import RxSwift

protocol WeatherNetworkServiceType {

    func cities() -> Observable<[CityDTO]>

    func forecasts(with cityId: Int) -> Observable<[ForecastDTO]>

}

class WeatherNetworkService: WeatherNetworkServiceType {

    private static let cityIds = [
        6077243, 524901, 5368361, 1835848, 3128760, 4180439,
        2147714, 264371, 1816670, 2643743, 3451190, 1850147
    ]

    let provider = MoyaProvider<OpenWeatherAPI>(plugins:
    [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])

    func cities() -> Observable<[CityDTO]> {
        provider.rx.request(.cities(WeatherNetworkService.cityIds))
                .filterSuccessfulStatusCodes()
                .asObservable()
                .map([CityDTO].self, atKeyPath: "list")
    }

    func forecasts(with cityId: Int) -> Observable<[ForecastDTO]> {
        provider.rx.request(.forecast(cityId))
                .filterSuccessfulStatusCodes()
                .asObservable()
                .map([ForecastDTO].self, atKeyPath: "list")
    }

}
