//
//  NewsfeedNewsfeedViewInput.swift
//  Headline
//
//  Created by Hugo Pivaral on 03/06/2022.
//  Copyright © 2022 Hugop.dev. All rights reserved.
//

protocol NewsfeedViewInput: AnyObject {

    func setupInitialState()
    func showActivityIndicatorView()
    func hideActivityIndicatorView()
    func setArticles(with list: [ArticleViewModel])
    func appendArticles(with list: [ArticleViewModel])
}
