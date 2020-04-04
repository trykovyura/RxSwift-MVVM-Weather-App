//
// Created by Юрий Трыков on 04/04/2020.
// Copyright (c) 2020 trykov. All rights reserved.
//

import UIKit

class WeatherForecastView: UIView {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        return tableView
    }()
    let refreshControl = UIRefreshControl()

    init() {
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherForecastView: CustomView {

    func setupUI() {
        backgroundColor = .white
        addSubview(tableView)
        tableView.refreshControl = refreshControl
    }

    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
