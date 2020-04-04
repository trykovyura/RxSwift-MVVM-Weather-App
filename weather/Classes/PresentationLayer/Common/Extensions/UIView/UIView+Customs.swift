//
// Created by Юрий Трыков on 04/04/2020.
// Copyright (c) 2020 trykov. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {

    func addSubviewFullscreen(view: UIView, animated: Bool) {
        guard animated else {
            addSubview(view)
            return
        }
        UIView.transition(with: self, duration: 0.5, options: [.transitionCrossDissolve],
                animations: {
                    self.addSubview(view)
                }, completion: nil)

        view.snp.makeConstraints { make in
            make.leading.top.bottom.trailing.equalTo(self)
        }
    }

    func removeSubview(view: UIView, animated: Bool) {
        guard animated else {
            view.removeFromSuperview()
            return
        }
        UIView.transition(with: self, duration: 0.5,
                options: [.transitionCrossDissolve], animations: {
            view.removeFromSuperview()
        }, completion: nil)
    }
}
