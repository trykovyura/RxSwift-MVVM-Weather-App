//
// Created by Юрий Трыков on 04/04/2020.
// Copyright (c) 2020 trykov. All rights reserved.
//

import RxSwift
import RxFlow
import RxCocoa
import RxSwiftExt
import RxDataSourcesExt

class WeatherFeedViewModel: ViewModelType, Stepper {

    let steps = PublishRelay<Step>()

    let input = Input()
    let output: Output
    let dependency: Dependency

    required init(dependency: Dependency) {
        self.dependency = dependency
        let activityIndicator = ActivityIndicator()
        // Events
        let cities = Observable.merge(input.refresh, .just(()))
                .flatMap {
                    dependency.interactor.cities()
                            .trackActivity(activityIndicator)
                            .materialize()
                }
                .share()

        let citiesEvent = cities.elements()
                .map(WeatherFeedEvent.cities)
        let searchEvent = input.search
                .map(WeatherFeedEvent.search)
        // State
        let state = WeatherFeedState()
        let stateSeed = Observable.merge(citiesEvent, searchEvent)
                .scan(state, accumulator: dependency.reducer.reduce)
                .startWith(state)
                .share()
        let sections = stateSeed.map(dependency.builder.build)

        // Transition
        let transition = input.select
                .map { Int($0.id) }
                .unwrap()
                .do(onNext: { [steps] cityId in
                    steps.accept(AppStep.weatherForecastIsRequired(cityId: cityId))
                })
                .mapToVoid()

        output = Output(sections: sections.asDriverOnErrorJustComplete(),
                error: cities.errors().asDriverOnErrorJustComplete(),
                loading: activityIndicator.asDriver(),
                transition: transition.asDriverOnErrorJustComplete())
    }
}

extension WeatherFeedViewModel {

    struct Input {
        let select = PublishSubject<WeatherFeedCellViewModel>()
        let search = PublishSubject<String?>()
        let refresh = PublishSubject<Void>()
    }

    struct Output {
        let sections: Driver<[TableSectionModel]>
        let error: Driver<Error>
        let loading: Driver<Bool>
        let transition: Driver<Void>
    }

    struct Dependency {
        let interactor: WeatherFeedInteractorType
        let builder: WeatherFeedBuilderType
        let reducer: WeatherFeedReducerType
    }
}
