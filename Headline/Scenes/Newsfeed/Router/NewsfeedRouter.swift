//
//  NewsfeedNewsfeedRouter.swift
//  Headline
//
//  Created by Hugo Pivaral on 03/06/2022.
//  Copyright © 2022 Hugop.dev. All rights reserved.
//

import UIKit

class NewsfeedRouter: NewsfeedRouterInput {
    
    weak var viewController: NewsfeedViewController!

    func presentDetailFor(article: ArticleViewModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let articleDetailVC = storyboard.instantiateViewController(withIdentifier: "ArticleDetailViewController") as! ArticleDetailViewController
        articleDetailVC.modalPresentationStyle = .formSheet
        articleDetailVC.moduleInput().initializeModule(with: article)
        
        viewController.present(viewController: articleDetailVC, interactiveDismissalType: .standard)
    }
}
