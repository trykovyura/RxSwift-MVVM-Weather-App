//
// Created by Юрий Трыков on 04/04/2020.
// Copyright (c) 2020 trykov. All rights reserved.
//

import UIKit

protocol ViewCustomizable {

    associatedtype ViewType: UIView

    var contentView: ViewType { get }
    func loadCustomView()
}

extension ViewCustomizable where Self: UIViewController {

    var contentView: ViewType {
        guard let view = view as? ViewType else {
            fatalError()
        }
        return view
    }
    func loadCustomView() {
        view = ViewType()
    }
}
