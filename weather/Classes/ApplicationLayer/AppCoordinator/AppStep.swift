//
// Created by Юрий Трыков on 04/04/2020.
// Copyright (c) 2020 trykov. All rights reserved.
//

import RxFlow

enum AppStep: Step {
    case weatherFeedIsRequired
    case weatherForecastIsRequired(cityId: Int)
}
