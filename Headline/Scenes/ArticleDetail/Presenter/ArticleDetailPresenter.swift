//
//  ArticleDetailArticleDetailPresenter.swift
//  Headline
//
//  Created by Hugo Pivaral on 08/07/2022.
//  Copyright © 2022 Hugop.dev. All rights reserved.
//

import Foundation

class ArticleDetailPresenter: ArticleDetailInteractorOutput {

    weak var view: ArticleDetailViewInput!
    var interactor: ArticleDetailInteractorInput!
    var router: ArticleDetailRouterInput!
    
    var article: ArticleViewModel!
}

extension ArticleDetailPresenter: ArticleDetailModuleInput {
    
    func initializeModule(with viewModel: ArticleViewModel) {
        self.article = viewModel
    }
}


extension ArticleDetailPresenter: ArticleDetailViewOutput {
    
    func viewIsReady() {
        view.setupInitialState(with: article)
    }
    
    func didTapReadMoreAction() {
        guard let stringUrl = article.articleUrl,
              let url = URL(string: stringUrl) else {
            view.showAlert(title: "Error loading article", message: "The article url could not be loaded, please try again later.")
            
            return
        }
        
        router.routeToSafariViewController(with: url)
    }
}
