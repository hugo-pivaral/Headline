//
//  NewsfeedNewsfeedConfiguratorTests.swift
//  Headline
//
//  Created by Hugo Pivaral on 03/06/2022.
//  Copyright © 2022 Hugop.dev. All rights reserved.
//

import XCTest

class NewsfeedModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {

        //given
        let viewController = NewsfeedViewControllerMock()
        let configurator = NewsfeedModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "NewsfeedViewController is nil after configuration")
        XCTAssertTrue(viewController.output is NewsfeedPresenter, "output is not NewsfeedPresenter")

        let presenter: NewsfeedPresenter = viewController.output as! NewsfeedPresenter
        XCTAssertNotNil(presenter.view, "view in NewsfeedPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in NewsfeedPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is NewsfeedRouter, "router is not NewsfeedRouter")

        let interactor: NewsfeedInteractor = presenter.interactor as! NewsfeedInteractor
        XCTAssertNotNil(interactor.output, "output in NewsfeedInteractor is nil after configuration")
    }

    class NewsfeedViewControllerMock: NewsfeedViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
