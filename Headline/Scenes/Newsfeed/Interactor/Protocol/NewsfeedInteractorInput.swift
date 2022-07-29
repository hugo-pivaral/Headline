//
//  NewsfeedNewsfeedInteractorInput.swift
//  Headline
//
//  Created by Hugo Pivaral on 03/06/2022.
//  Copyright © 2022 Hugop.dev. All rights reserved.
//

import Foundation

protocol NewsfeedInteractorInput {
    
    func fetchNewsfeedList(category name: Category, page: Int)
}
