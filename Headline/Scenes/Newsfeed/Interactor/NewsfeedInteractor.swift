//
//  NewsfeedNewsfeedInteractor.swift
//  Headline
//
//  Created by Hugo Pivaral on 03/06/2022.
//  Copyright © 2022 Hugop.dev. All rights reserved.
//

import Foundation
import UIKit

class NewsfeedInteractor: NewsfeedInteractorInput {

    lazy var networkingClient: NetworkingClient = NetworkingClient()
    weak var output: NewsfeedInteractorOutput!
    
    func fetchNewsfeedList(category name: Category, page: Int) {
        let resource = NetworkingResource(category: name, page: page)
        let url = resource.topHeadlines
        
        networkingClient.performRequest(to: url, withType: NewsAPIResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                print(response)
                if let articles = response.articles {
                    self?.output.didFetchNewsfeedList(articles: articles)
                } else {
                    self?.output.didFailFetchingNewsfeedList()
                }
                
            case .failure(_):
                self?.output.didFailFetchingNewsfeedList()
            }
        }
    }
}
