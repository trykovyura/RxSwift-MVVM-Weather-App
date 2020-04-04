//
// Created by Юрий Трыков on 04/04/2020.
// Copyright (c) 2020 trykov. All rights reserved.
//

import RxFlow

class AppFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }

    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        return viewController
    }()

    deinit {
        print("\(type(of: self)): \(#function)")
    }

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else {
            return .none
        }
        switch step {
        case .weatherFeedIsRequired: return navigateToFeedScreen()
        case .weatherForecastIsRequired(let cityId): return navigateToForecastScreen(cityId: cityId)
        }
    }

    private func navigateToFeedScreen() -> FlowContributors {
        let viewController = ApplicationAssembly.assembler.resolver.resolve(WeatherFeedViewController.self)!
        viewController.title = "Weather Feed"
        rootViewController.pushViewController(viewController, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: viewController,
                withNextStepper: viewController.viewModel))
    }

    private func navigateToForecastScreen(cityId: Int) -> FlowContributors {
        let viewController = ApplicationAssembly.assembler.resolver.resolve(WeatherForecastViewController.self,
                argument: cityId)!
        viewController.title = "Weather Forecast"
        rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController,
                withNextStepper: viewController.viewModel))
    }

}
