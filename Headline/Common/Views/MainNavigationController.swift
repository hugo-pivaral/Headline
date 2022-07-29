//
//  MainNavigationController.swift
//  Headline
//
//  Created by Hugo Pivaral on 9/07/22.
//

import UIKit

class MainNavigationController: UINavigationController {

    // MARK: Properties
    
    private var standardAppereance: UINavigationBarAppearance {
        let standardAppearance = UINavigationBarAppearance()
        
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = UIColor(color: .backgroundPrimary)
        standardAppearance.backgroundEffect = nil
        standardAppearance.shadowImage = nil
        standardAppearance.shadowColor = .clear
        standardAppearance.titleTextAttributes = [.font : UIFont(font: .georgia, weight: .bold, size: 17.0), .foregroundColor : UIColor(color: .contentPrimary)]
        standardAppearance.largeTitleTextAttributes = [.font : UIFont(font: .georgia, weight: .bold, size: 34.0), .foregroundColor : UIColor(color: .contentPrimary)]
        
        return standardAppearance
    }
    
    private var scrollAppearance: UINavigationBarAppearance {
        let scrollAppearance = UINavigationBarAppearance()
        
        scrollAppearance.configureWithOpaqueBackground()
        scrollAppearance.backgroundColor = UIColor(color: .backgroundPrimary)
        scrollAppearance.backgroundEffect = nil
        scrollAppearance.shadowImage = nil
        scrollAppearance.shadowColor = .clear
        scrollAppearance.titleTextAttributes = [.font : UIFont(font: .georgia, weight: .bold, size: 17.0), .foregroundColor : UIColor(color: .contentPrimary)]
        scrollAppearance.largeTitleTextAttributes = [.font : UIFont(font: .georgia, weight: .bold, size: 34.0), .foregroundColor : UIColor(color: .contentPrimary)]
        
        return scrollAppearance
    }
    
    
    // MARK: Helpers
    
    private func configureAppereance() {
        navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationBar.standardAppearance = standardAppereance
        navigationBar.scrollEdgeAppearance = scrollAppearance
    }
    
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppereance()
    }
}
