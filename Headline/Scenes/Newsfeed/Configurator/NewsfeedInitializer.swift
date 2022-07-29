//
//  NewsfeedNewsfeedInitializer.swift
//  Headline
//
//  Created by Hugo Pivaral on 03/06/2022.
//  Copyright © 2022 Hugop.dev. All rights reserved.
//

import UIKit

class NewsfeedModuleInitializer: NSObject {

    @IBOutlet weak var newsfeedViewController: NewsfeedViewController!

    override func awakeFromNib() {

        let configurator = NewsfeedModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: newsfeedViewController)
    }

}
