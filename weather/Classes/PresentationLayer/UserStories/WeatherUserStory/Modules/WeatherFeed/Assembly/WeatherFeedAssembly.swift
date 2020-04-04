//
// Created by Юрий Трыков on 04/04/2020.
// Copyright (c) 2020 trykov. All rights reserved.
//

import Foundation
import Swinject

class WeatherFeedAssembly: Assembly {

    func assemble(container: Container) {
        registerViewController(container: container)
        registerViewModel(container: container)
        registerBuilder(container: container)
        registerInteractor(container: container)
        registerReducer(container: container)
    }

    private func registerViewController(container: Container) {
        container.register(WeatherFeedViewController.self) { res in
            let viewModel = res.resolve(WeatherFeedViewModel.self)!
            let viewController = WeatherFeedViewController(viewModel: viewModel)
            return viewController
        }.inObjectScope(.transient)
    }

    private func registerViewModel(container: Container) {
        container.register(WeatherFeedViewModel.self) { (res) in
            let dependency = WeatherFeedViewModel
                    .Dependency(interactor: res.resolve(WeatherFeedInteractorType.self)!,
                    builder: res.resolve(WeatherFeedBuilderType.self)!,
                    reducer: res.resolve(WeatherFeedReducerType.self)!)
            return WeatherFeedViewModel(dependency: dependency)
        }.inObjectScope(.transient)
    }

    private func registerBuilder(container: Container) {
        container.register(WeatherFeedBuilderType.self) { _ in
            WeatherFeedBuilder()
        }.inObjectScope(.transient)
    }

    private func registerInteractor(container: Container) {
        container.register(WeatherFeedInteractorType.self) { res in
            WeatherFeedInteractor(weatherFacade: res.resolve(WeatherFacadeType.self)!)
        }.inObjectScope(.transient)
    }

    private func registerReducer(container: Container) {
        container.register(WeatherFeedReducerType.self) { _ in
            WeatherFeedReducer()
        }.inObjectScope(.transient)
    }
}
