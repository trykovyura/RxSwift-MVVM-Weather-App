//
// Created by Юрий Трыков on 04/04/2020.
// Copyright (c) 2020 trykov. All rights reserved.
//

import Foundation

struct ForecastDTO {
    let name: String?
    let time: Int?
    let day: String?
}
extension ForecastDTO: Codable {

    enum CodingKeys: String, CodingKey {
        case name = "dt_txt"
        case time = "dt"
        case weather
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(time, forKey: .time)
        try container.encodeIfPresent(day, forKey: .weather)
    }

    // Decodable protocol methods

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        time = try container.decodeIfPresent(Int.self, forKey: .time)
        let weathers: [WeatherDTO]? = try container.decodeIfPresent([WeatherDTO].self, forKey: .weather)
        day = weathers?.first?.main
    }
}
