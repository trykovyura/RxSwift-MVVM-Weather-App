//
// Created by Юрий Трыков on 04/04/2020.
// Copyright (c) 2020 trykov. All rights reserved.
//

import Foundation

struct CityDTO {
    let id: Int?
    let name: String?
    let weather: String?
}

extension CityDTO: Codable {

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case weather
    }

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(weather, forKey: .weather)
    }

    // Decodable protocol methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        let weathers: [WeatherDTO]? = try container.decodeIfPresent([WeatherDTO].self, forKey: .weather)
        weather = weathers?.first?.main
    }

}
