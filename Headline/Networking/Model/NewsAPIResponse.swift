//
//  NewsAPIResponse.swift
//  Headline
//
//  Created by Hugo Pivaral on 7/06/22.
//

import Foundation

struct NewsAPIResponse: Decodable {
    
    let status: Status
    let totalResults: Int?
    let articles: [Article]?
    let code: String?
    let message: String?
    
    init(status: Status, totalResults: Int?, articles: [Article]?, code: String?, message: String?) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
        self.code = code
        self.message = message
    }
    
    enum Status: String, Decodable {
        case ok = "ok"
        case error = "error"
    }
}
