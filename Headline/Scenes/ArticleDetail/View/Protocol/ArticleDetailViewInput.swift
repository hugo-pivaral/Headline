//
//  ArticleDetailArticleDetailViewInput.swift
//  Headline
//
//  Created by Hugo Pivaral on 08/07/2022.
//  Copyright © 2022 Hugop.dev. All rights reserved.
//

protocol ArticleDetailViewInput: AnyObject {

    func setupInitialState(with viewModel: ArticleViewModel)
    func showAlert(title: String, message: String)
    func moduleInput() -> ArticleDetailModuleInput
}
