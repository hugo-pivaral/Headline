//
//  NetworkingResource.swift
//  Headline
//
//  Created by Hugo Pivaral on 16/05/22.
//

import Foundation

enum NewsEndpoint: String {
    
    case topHeadlines = "/v2/top-headlines"
    case everything = "/v2/everything"
    case sources = "/v2/top-headlines/sources"
}

struct NetworkingResource {
    
    // MARK: Properties
    
    private var category: Category
    private var host: String
    private var page: Int
    
    private var apiKey: String {
        guard let url = Bundle.main.url(forResource: "Configuration", withExtension: "plist"),
              let config = NSDictionary(contentsOf: url) as? [String: Any],
              let apiKey = config["apiKey"] as? String else {
            
            fatalError("Configure your API key from https://newsapi.org/register in the Configuration.plist file to run the app.")
        }
        
        return apiKey
    }
    
    var topHeadlines: URL {
        let stringURL = host + NewsEndpoint.topHeadlines.rawValue + "?country=us&apiKey=\(apiKey)&category=\(category)&page=\(page)&pageSize=25"

        return URL(string: stringURL)!
    }
    
    var everything: URL {
        let stringURL = host + NewsEndpoint.everything.rawValue + "?country=us&apiKey=\(apiKey)&page=\(page)&pageSize=25"

        return URL(string: stringURL)!
    }
    
    var sources: URL {
        let stringURL = host + NewsEndpoint.sources.rawValue + "?country=us&apiKey=\(apiKey)"

        return URL(string: stringURL)!
    }
    
    
    // MARK: Initializer
    
    init(category: Category, page: Int) {
        self.host = "https://newsapi.org"
        self.category = category
        self.page = page
    }
}
