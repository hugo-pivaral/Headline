//
//  ArticleDetailArticleDetailInitializer.swift
//  Headline
//
//  Created by Hugo Pivaral on 08/07/2022.
//  Copyright © 2022 Hugop.dev. All rights reserved.
//

import UIKit

class ArticleDetailModuleInitializer: NSObject {

    @IBOutlet weak var articledetailViewController: ArticleDetailViewController!

    override func awakeFromNib() {

        let configurator = ArticleDetailModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: articledetailViewController)
    }

}
