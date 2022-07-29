//
//  NewsfeedNewsfeedViewOutput.swift
//  Headline
//
//  Created by Hugo Pivaral on 03/06/2022.
//  Copyright © 2022 Hugop.dev. All rights reserved.
//

protocol NewsfeedViewOutput {

    func didSelectNewTab(with category: Category)
    func didSelectRow(with article: ArticleViewModel)
    func didPullToRefresh()
    func viewIsReady()
    func willDisplayRow(at index: Int)
}
