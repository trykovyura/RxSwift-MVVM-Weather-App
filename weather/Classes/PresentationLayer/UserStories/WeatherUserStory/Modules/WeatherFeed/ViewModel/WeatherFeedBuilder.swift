//
// Created by Юрий Трыков on 04/04/2020.
// Copyright (c) 2020 trykov. All rights reserved.
//

import RxDataSourcesExt

protocol WeatherFeedBuilderType {
    func build(with state: WeatherFeedState) -> [TableSectionModel]
}

class WeatherFeedBuilder: WeatherFeedBuilderType {
    func build(with state: WeatherFeedState) -> [TableSectionModel] {
        let items = state.cities
                .filter { city in
                    guard let search = state.search, !search.isEmpty else {
                        return true
                    }
                    return city.name.lowercased().range(of: search.lowercased()) != nil
                }
                .map { city in
                    WeatherFeedCellViewModel(id: city.id.description, name: city.name, weather: city.weather)
                }
        return [TableSectionModel(items: items)]
    }
}
