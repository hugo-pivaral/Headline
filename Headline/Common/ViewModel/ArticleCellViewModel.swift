//
//  NewsArticleCellViewModel.swift
//  Headline
//
//  Created by Hugo Pivaral on 15/05/22.
//

import UIKit

class ArticleViewModel {
    
    private var publishedAt: String?
    private var stringImageUrl: String?
    
    private(set) var articleUrl: String?
    private(set) var title: String?
    private(set) var sourceName: String?
    private(set) var description: String?
    private(set) var author: String?
    
    var publicationDate: String? {
        guard let publishedAt = publishedAt else { return nil }
        
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: publishedAt)
        return date?.timeAgoDisplay()
    }
    
    lazy var imageUrl: URL? = {
        guard let stringUrl = stringImageUrl, let imageUrl = URL(string: stringUrl) else { return nil }
        return imageUrl
    }()
    
    init(title: String?, sourceName: String?, author: String?, description: String?, publishedAt: String?, stringImageUrl: String?, articleUrl: String?) {
        self.title = title
        self.sourceName = sourceName
        self.author = author
        self.description = description
        self.publishedAt = publishedAt
        self.stringImageUrl = stringImageUrl
        self.articleUrl = articleUrl
    }
}
