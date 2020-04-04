//
// Created by Юрий Трыков on 04/04/2020.
// Copyright (c) 2020 trykov. All rights reserved.
//

import RxDataSourcesExt

protocol WeatherForecastBuilderType {
    func build(with forecast: [ForecastVO]) -> [TableSectionModel]
}
class WeatherForecastBuilder: WeatherForecastBuilderType {
    func build(with forecast: [ForecastVO]) -> [TableSectionModel] {
        let viewModels = forecast.map { forecast in
            WeatherForecastCellViewModel(id: UUID().uuidString, name: forecast.day, weather: forecast.name)
        }
        return [TableSectionModel(items: viewModels)]
    }
}
