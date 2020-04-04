//
// Created by Юрий Трыков on 04/04/2020.
// Copyright (c) 2020 trykov. All rights reserved.
//

import Foundation

protocol CustomView {
    func setupUI()
    func setupConstraints()
}

extension CustomView {
    func setupUI() {}
    func setupConstraints() {}
}
