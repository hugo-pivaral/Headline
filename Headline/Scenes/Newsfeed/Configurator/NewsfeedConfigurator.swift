//
//  NewsfeedNewsfeedConfigurator.swift
//  Headline
//
//  Created by Hugo Pivaral on 03/06/2022.
//  Copyright © 2022 Hugop.dev. All rights reserved.
//

import UIKit

class NewsfeedModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? NewsfeedViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: NewsfeedViewController) {

        let router = NewsfeedRouter()
        router.viewController = viewController

        let presenter = NewsfeedPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = NewsfeedInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
