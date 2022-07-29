//
//  Article.swift
//  Headline
//
//  Created by Hugo Pivaral on 15/05/22.
//

import Foundation

class Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String?
}
