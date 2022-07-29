//
//  ArticleDetailArticleDetailConfiguratorTests.swift
//  Headline
//
//  Created by Hugo Pivaral on 08/07/2022.
//  Copyright © 2022 Hugop.dev. All rights reserved.
//

import XCTest

class ArticleDetailModuleConfiguratorTests: XCTestCase {

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
        let viewController = ArticleDetailViewControllerMock()
        let configurator = ArticleDetailModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "ArticleDetailViewController is nil after configuration")
        XCTAssertTrue(viewController.output is ArticleDetailPresenter, "output is not ArticleDetailPresenter")

        let presenter: ArticleDetailPresenter = viewController.output as! ArticleDetailPresenter
        XCTAssertNotNil(presenter.view, "view in ArticleDetailPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in ArticleDetailPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is ArticleDetailRouter, "router is not ArticleDetailRouter")

        let interactor: ArticleDetailInteractor = presenter.interactor as! ArticleDetailInteractor
        XCTAssertNotNil(interactor.output, "output in ArticleDetailInteractor is nil after configuration")
    }

    class ArticleDetailViewControllerMock: ArticleDetailViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
