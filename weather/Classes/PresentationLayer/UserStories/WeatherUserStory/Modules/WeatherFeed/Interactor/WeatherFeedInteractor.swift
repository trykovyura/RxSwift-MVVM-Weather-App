//
//  WeatherFeedWeatherFeedInteractor.swift
//  weather
//
//  Created by trykov on 24/08/2017.
//  Copyright © 2017 trykov. All rights reserved.
//
import RxSwift

protocol WeatherFeedInteractorType {
    func cities() -> Observable<[CityVO]>
}

class WeatherFeedInteractor: WeatherFeedInteractorType {

    let weatherFacade: WeatherFacadeType

    init(weatherFacade: WeatherFacadeType) {
        self.weatherFacade = weatherFacade
    }

    // MARK: - WeatherFeedInteractorType

    func cities() -> Observable<[CityVO]> {
        weatherFacade.cities()
    }

}
