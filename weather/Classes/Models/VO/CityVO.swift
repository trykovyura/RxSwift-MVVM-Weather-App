//
// Created by Юрий Трыков on 26.08.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation

struct CityVO {

    let id: Int
    let name: String
    let weather: String

}

extension CityVO {

    init?(dto: CityDTO) {
        guard let id = dto.id,
              let name = dto.name,
              let weather = dto.weather else {
            return nil
        }
        self.id = id
        self.name = name
        self.weather = weather
    }

}

extension CityVO: Entity {

    typealias RealmEntityType = CityDBO

    var modelObject: CityDBO {
        return CityDBO(entity: self)
    }
}
