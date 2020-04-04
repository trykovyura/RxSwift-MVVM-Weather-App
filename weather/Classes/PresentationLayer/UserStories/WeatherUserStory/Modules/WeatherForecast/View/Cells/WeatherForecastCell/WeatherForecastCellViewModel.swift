//
// Created by Юрий Трыков on 04/04/2020.
// Copyright (c) 2020 trykov. All rights reserved.
//

import RxDataSourcesExt

struct WeatherForecastCellViewModel: TableCellViewModel {
    typealias TableCellType = WeatherForecastCell
    let id: String
    let name: String
    let weather: String
    var rowHeight: CGFloat = 44
}
