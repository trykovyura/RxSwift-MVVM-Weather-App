//
// Created by Юрий Трыков on 27.08.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation

struct ForecastVO {
    let name: String
    let time: Int
    let day: String
}

extension ForecastVO {

    init?(dto: ForecastDTO) {
        guard let name = dto.name,
              let time = dto.time,
              let day = dto.day else {
            return nil
        }
        self.name = name
        self.time = time
        self.day = day
    }

}
