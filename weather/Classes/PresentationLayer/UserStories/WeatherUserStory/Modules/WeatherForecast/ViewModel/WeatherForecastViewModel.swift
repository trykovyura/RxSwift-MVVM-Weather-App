//
// Created by Юрий Трыков on 04/04/2020.
// Copyright (c) 2020 trykov. All rights reserved.
//

import RxSwift
import RxCocoa
import RxFlow
import RxDataSourcesExt
import RxSwiftExt

class WeatherForecastViewModel: ViewModelType, Stepper {

    let steps = PublishRelay<Step>()

    let input = Input()
    let output: Output
    let dependency: Dependency

    required init(dependency: Dependency) {
        self.dependency = dependency
        let activityIndicator = ActivityIndicator()
        let forecast = Observable.merge(input.refresh, .just(()))
                .flatMap {
                    dependency.interactor.forecast(with: dependency.cityId)
                            .trackActivity(activityIndicator)
                            .materialize()
                }
                .share()
        let sections = forecast.elements()
                .map(dependency.builder.build)

        output = Output(sections: sections.asDriverOnErrorJustComplete(),
                error: forecast.errors().asDriverOnErrorJustComplete(),
                loading: activityIndicator.asDriver())

    }
}

extension WeatherForecastViewModel {

    struct Input {
        let refresh = PublishSubject<Void>()
    }

    struct Output {
        let sections: Driver<[TableSectionModel]>
        let error: Driver<Error>
        let loading: Driver<Bool>
    }

    struct Dependency {
        let cityId: Int
        let interactor: WeatherForecastInteractorType
        let builder: WeatherForecastBuilderType
    }
}
