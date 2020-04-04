//
// Created by Юрий Трыков on 04/04/2020.
// Copyright (c) 2020 trykov. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

extension ObservableType {

    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            Driver.empty()
        }
    }
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}
extension Reactive where Base: UIRefreshControl {
    public var refresh: ControlEvent<Void> {
        return controlEvent(.valueChanged)
    }
}
extension Reactive where Base: UIViewController {

    var loading: Binder<Bool> {
        return Binder(self.base) { viewController, loading in
            let loadingTag = 100
            if loading {
                guard viewController.view.viewWithTag(loadingTag) == nil else {
                    return
                }
                let loadingView = LoadingView()
                loadingView.tag = loadingTag
                viewController.view.addSubviewFullscreen(view: loadingView, animated: true)
            } else if let loadingView = viewController.view.viewWithTag(loadingTag) {
                viewController.view.removeSubview(view: loadingView, animated: true)
            }
        }
    }
    var error: Binder<Error> {
        return Binder(self.base) { viewController, _ in
            let alert = UIAlertController(title: "Error",
                    message: "Something went wrong",
                    preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Ok",
                    style: .default,
                    handler: { _ -> Void in })
            alert.addAction(yesAction)
            viewController.present(alert, animated: true)
        }
    }
}
