//
// Created by Юрий Трыков on 04/04/2020.
// Copyright (c) 2020 trykov. All rights reserved.
//

import Foundation

enum WeatherFeedEvent {
    case cities([CityVO])
    case search(String?)
}
