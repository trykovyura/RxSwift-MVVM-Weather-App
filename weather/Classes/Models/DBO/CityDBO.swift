//
// Created by Юрий Трыков on 27.08.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation
import RealmSwift

class CityDBO: Object, RealmEntity {

    typealias EntityType = CityVO

    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var weather = ""
    @objc dynamic var created = Date()

    convenience required init(entity: EntityType) {
        self.init()
        self.id = entity.id
        self.name = entity.name
        self.weather = entity.weather
        self.created = Date()
    }

    var plainObject: CityVO {
        return CityVO(id: id, name: name, weather: weather)
    }

    override class func primaryKey() -> String? {
        return "id"
    }
}
