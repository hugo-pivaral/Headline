//
//  ArticleDetailArticleDetailRouter.swift
//  Headline
//
//  Created by Hugo Pivaral on 08/07/2022.
//  Copyright © 2022 Hugop.dev. All rights reserved.
//

import SafariServices

class ArticleDetailRouter: ArticleDetailRouterInput {
    
    weak var viewController: ArticleDetailViewController!
    
    func routeToSafariViewController(with url: URL) {
        let config = SFSafariViewController.Configuration()
        
        let browser = SFSafariViewController(url: url, configuration: config)
        browser.modalPresentationStyle = .overFullScreen
        
        viewController.present(browser, animated: true)
    }
}
