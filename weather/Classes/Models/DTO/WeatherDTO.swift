//
// Created by Юрий Трыков on 04/04/2020.
// Copyright (c) 2020 trykov. All rights reserved.
//

import Foundation

struct WeatherDTO: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}
