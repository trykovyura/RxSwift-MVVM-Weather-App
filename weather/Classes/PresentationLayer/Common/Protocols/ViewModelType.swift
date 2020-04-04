//
// Created by Юрий Трыков on 04/04/2020.
// Copyright (c) 2020 trykov. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    associatedtype Dependency

    var input: Input { get }
    var output: Output { get }
    init(dependency: Dependency)
}
