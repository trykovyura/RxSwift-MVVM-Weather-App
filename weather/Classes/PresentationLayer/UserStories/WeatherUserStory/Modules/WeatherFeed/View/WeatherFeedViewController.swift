//
//  WeatherFeedWeatherFeedViewController.swift
//  weather
//
//  Created by trykov on 24/08/2017.
//  Copyright © 2017 trykov. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa
import NSObject_Rx
import RxDataSourcesExt

class WeatherFeedViewController: UIViewController, ViewCustomizable {

    typealias ViewType = WeatherFeedView

    var viewModel: WeatherFeedViewModel

    init(viewModel: WeatherFeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var director: TableDirector = {
        let director = TableDirector()
        contentView.tableView.rx.setDelegate(director)
                .disposed(by: rx.disposeBag)
        return director
    }()

    // MARK: Life cycle

    override func loadView() {
        loadCustomView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindInput()
        bindOutput()
    }

    func bindInput() {
        contentView.refreshControl.rx.refresh
                .bind(to: viewModel.input.refresh)
                .disposed(by: rx.disposeBag)
        contentView.tableView.rx.viewModelSelected(WeatherFeedCellViewModel.self)
                .bind(to: viewModel.input.select)
                .disposed(by: rx.disposeBag)
        contentView.searchBar.rx.text
                .bind(to: viewModel.input.search)
                .disposed(by: rx.disposeBag)
    }

    func bindOutput() {
        viewModel.output.sections
                .do(onNext: { [contentView] _ in
                    contentView.refreshControl.endRefreshing()
                })
                .drive(contentView.tableView.rx.items(director: director))
                .disposed(by: rx.disposeBag)
        viewModel.output.transition
                .drive()
                .disposed(by: rx.disposeBag)
        viewModel.output.loading
                .drive(rx.loading)
                .disposed(by: rx.disposeBag)
        viewModel.output.error
                .drive(rx.error)
                .disposed(by: rx.disposeBag)
    }
}
