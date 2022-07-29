//
//  NewsfeedNewsfeedPresenter.swift
//  Headline
//
//  Created by Hugo Pivaral on 03/06/2022.
//  Copyright © 2022 Hugop.dev. All rights reserved.
//

class NewsfeedPresenter: NewsfeedModuleInput {

    weak var view: NewsfeedViewInput!
    var interactor: NewsfeedInteractorInput!
    var router: NewsfeedRouterInput!
    
    var category: Category!
    var currentPage: Int!
}

extension NewsfeedPresenter: NewsfeedViewOutput {
    
    func didSelectRow(with article: ArticleViewModel) {
        router.presentDetailFor(article: article)
    }
    
    func didSelectNewTab(with category: Category) {
        self.category = category
        self.currentPage = 0
        
        interactor.fetchNewsfeedList(category: category, page: 1)
    }
    
    func didPullToRefresh() {
        self.currentPage = 0
        interactor.fetchNewsfeedList(category: category, page: 1)
    }
    
    func viewIsReady() {
        self.category = .General
        self.currentPage = 0
        
        view.showActivityIndicatorView()
        interactor.fetchNewsfeedList(category: category, page: 1)
    }
    
    func willDisplayRow(at index: Int) {
        let pageSize = 25
        let scrollingThreshold = pageSize - 5
        
        if index == (currentPage * pageSize) - scrollingThreshold {
            interactor.fetchNewsfeedList(category: category, page: currentPage + 1)
        }
    }
}

extension NewsfeedPresenter: NewsfeedInteractorOutput {
    
    func didFetchNewsfeedList(articles: [Article]) {
        let viewModels = articles.map { ArticleViewModel(title: $0.title,
                                                         sourceName: $0.source?.name,
                                                         author: $0.author,
                                                         description: $0.description,
                                                         publishedAt: $0.publishedAt,
                                                         stringImageUrl: $0.urlToImage,
                                                         articleUrl: $0.url) }
        
        currentPage += 1
        view.hideActivityIndicatorView()
        
        if currentPage == 1 {
            view.setArticles(with: viewModels)
        } else {
            view.appendArticles(with: viewModels)
        }
    }
    
    func didFailFetchingNewsfeedList() {
        view.hideActivityIndicatorView()
        print("An error ocurred")
    }
}
