//
//  WeatherFeedCell.swift
//  weather
//
//  Created by Юрий Трыков on 25.08.17.
//  Copyright © 2017 trykov. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSourcesExt

class WeatherFeedCell: UITableViewCell, ConfigurableCell {

    var disposeBag = DisposeBag()

    lazy var titleLabel = UILabel()
    lazy var detailLabel = UILabel()

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: WeatherFeedCellViewModel) {
        titleLabel.text = viewModel.name
        detailLabel.text = viewModel.weather
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

extension WeatherFeedCell: CustomView {

    func setupUI() {
        addSubview(titleLabel)
        addSubview(detailLabel)
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        detailLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
}
