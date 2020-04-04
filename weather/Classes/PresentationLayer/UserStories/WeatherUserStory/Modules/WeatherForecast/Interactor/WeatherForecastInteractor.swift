//
//  WeatherForecastWeatherForecastInteractor.swift
//  weather
//
//  Created by trykov on 26/08/2017.
//  Copyright © 2017 trykov. All rights reserved.
//
import RxSwift

protocol WeatherForecastInteractorType {
    func forecast(with cityId: Int) -> Observable<[ForecastVO]>
}

class WeatherForecastInteractor: WeatherForecastInteractorType {

    let weatherFacade: WeatherFacadeType

    init(weatherFacade: WeatherFacadeType) {
        self.weatherFacade = weatherFacade
    }

    // MARK: - WeatherForecastInteractorType

    func forecast(with cityId: Int) -> Observable<[ForecastVO]> {
        weatherFacade.forecasts(with: cityId)
    }
}
