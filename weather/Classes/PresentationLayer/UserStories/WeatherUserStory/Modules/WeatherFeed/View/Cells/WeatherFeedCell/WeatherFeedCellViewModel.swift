//
// Created by Юрий Трыков on 04/04/2020.
// Copyright (c) 2020 trykov. All rights reserved.
//

import RxDataSourcesExt

struct WeatherFeedCellViewModel: TableCellViewModel {
    typealias TableCellType = WeatherFeedCell

    let id: String
    let name: String
    let weather: String
    var rowHeight: CGFloat = 44
}
