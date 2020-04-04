//
// Created by Трыков Юрий on 2019-07-03.
// Copyright (c) 2019 trykov. All rights reserved.
//

import Foundation

struct WeatherVO {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

extension WeatherVO {

    init?(dto: WeatherDTO) {
        guard let id = dto.id,
              let main = dto.main,
              let description = dto.description,
              let icon = dto.icon else {
            return nil
        }
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }

}
