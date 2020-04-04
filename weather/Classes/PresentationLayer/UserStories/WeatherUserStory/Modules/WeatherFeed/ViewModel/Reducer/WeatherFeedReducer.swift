//
// Created by Юрий Трыков on 04/04/2020.
// Copyright (c) 2020 trykov. All rights reserved.
//

import Foundation

protocol WeatherFeedReducerType {
    func reduce(state: WeatherFeedState, event: WeatherFeedEvent) -> WeatherFeedState
}
class WeatherFeedReducer: WeatherFeedReducerType {
    func reduce(state: WeatherFeedState, event: WeatherFeedEvent) -> WeatherFeedState {
        switch event {
        case .cities(let cities):
            var state = state
            state.cities = cities
            return state
        case .search(let search):
            var state = state
            state.search = search
            return state
        }
    }
}
