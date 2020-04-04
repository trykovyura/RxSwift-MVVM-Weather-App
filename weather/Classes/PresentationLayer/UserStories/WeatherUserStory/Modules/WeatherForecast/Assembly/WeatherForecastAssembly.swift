//
// Created by Юрий Трыков on 04/04/2020.
// Copyright (c) 2020 trykov. All rights reserved.
//

import Swinject

class WeatherForecastAssembly: Assembly {

    func assemble(container: Container) {
        registerViewController(container: container)
        registerViewModel(container: container)
        registerBuilder(container: container)
        registerInteractor(container: container)
    }

    private func registerViewController(container: Container) {
        container.register(WeatherForecastViewController.self) { (res, cityId: Int) in
            let viewModel = res.resolve(WeatherForecastViewModel.self, argument: cityId)!
            let viewController = WeatherForecastViewController(viewModel: viewModel)
            return viewController
        }.inObjectScope(.transient)
    }

    private func registerViewModel(container: Container) {
        container.register(WeatherForecastViewModel.self) { (res, cityId: Int) in
            let dependency = WeatherForecastViewModel
                    .Dependency(cityId: cityId,
                    interactor: res.resolve(WeatherForecastInteractorType.self)!,
                    builder: res.resolve(WeatherForecastBuilderType.self)!)
            return WeatherForecastViewModel(dependency: dependency)
        }.inObjectScope(.transient)
    }

    private func registerBuilder(container: Container) {
        container.register(WeatherForecastBuilderType.self) { _ in
            WeatherForecastBuilder()
        }.inObjectScope(.transient)
    }

    private func registerInteractor(container: Container) {
        container.register(WeatherForecastInteractorType.self) { res in
            WeatherForecastInteractor(weatherFacade: res.resolve(WeatherFacadeType.self)!)
        }.inObjectScope(.transient)
    }
}
