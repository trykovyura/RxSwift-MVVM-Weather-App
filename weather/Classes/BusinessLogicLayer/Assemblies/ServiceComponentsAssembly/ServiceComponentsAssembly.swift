//
// Created by Юрий Трыков on 27.08.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation
import Swinject

class ServiceComponentsAssembly: Assembly {

    func assemble(container: Container) {
        container.register(WeatherNetworkServiceType.self) { _ in
            WeatherNetworkService()
        }.inObjectScope(.transient)

        container.register(WeatherRepositoryServiceType.self) { _ in
            WeatherRepositoryService()
        }.inObjectScope(.transient)

        container.register(WeatherFacadeType.self) { res in
            WeatherFacade(
                    weatherNetworkService: res.resolve(WeatherNetworkServiceType.self)!,
                    weatherRepositoryService: res.resolve(WeatherRepositoryServiceType.self)!)
        }.inObjectScope(.transient)

    }
}
