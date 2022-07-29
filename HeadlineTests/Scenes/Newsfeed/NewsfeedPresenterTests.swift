//
//  NewsfeedNewsfeedPresenterTests.swift
//  Headline
//
//  Created by Hugo Pivaral on 03/06/2022.
//  Copyright © 2022 Hugop.dev. All rights reserved.
//

import XCTest

class NewsfeedPresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: NewsfeedInteractorInput {

    }

    class MockRouter: NewsfeedRouterInput {

    }

    class MockViewController: NewsfeedViewInput {

        func setupInitialState() {

        }
    }
}
