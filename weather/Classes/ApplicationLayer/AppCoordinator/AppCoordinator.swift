//
// Created by Юрий Трыков on 04/04/2020.
// Copyright (c) 2020 trykov. All rights reserved.
//

import RxFlow
import RxSwift

class AppCoordinator {

    let disposeBag = DisposeBag()
    var flowCoordinator = FlowCoordinator()

    func start(window: UIWindow?) {
        let appFlow = AppFlow()
        Flows.whenReady(flow1: appFlow) { [window] root in
            window?.rootViewController = root
            window?.makeKeyAndVisible()
        }
        flowCoordinator.rx.willNavigate.subscribe(onNext: { (flow, step) in
            print("will navigate to flow=\(flow) and step=\(step)")
        }).disposed(by: disposeBag)

        flowCoordinator.rx.didNavigate.subscribe(onNext: { (flow, step) in
            print("did navigate to flow=\(flow) and step=\(step)")
        }).disposed(by: disposeBag)
        flowCoordinator.coordinate(flow: appFlow, with: OneStepper(withSingleStep: AppStep.weatherFeedIsRequired))
    }
}
