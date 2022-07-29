//
//  ArticleDetailArticleDetailConfigurator.swift
//  Headline
//
//  Created by Hugo Pivaral on 08/07/2022.
//  Copyright © 2022 Hugop.dev. All rights reserved.
//

import UIKit

class ArticleDetailModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? ArticleDetailViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: ArticleDetailViewController) {

        let router = ArticleDetailRouter()
        router.viewController = viewController
        
        let presenter = ArticleDetailPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = ArticleDetailInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
