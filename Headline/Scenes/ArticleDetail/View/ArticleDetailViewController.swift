//
//  ArticleDetailArticleDetailViewController.swift
//  Headline
//
//  Created by Hugo Pivaral on 08/07/2022.
//  Copyright © 2022 Hugop.dev. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController, CustomPresentable {

    
    // MARK: - Properties
    
    var imageLoader: ImageLoader!
    
    var transitionManager: ModalTransitionManagerProvider?
    
    var output: ArticleDetailViewOutput!
    
    var article: ArticleViewModel! {
        didSet {
            setUpArticle()
        }
    }
    
    
    // MARK: - Views
    
    @IBOutlet private weak var sourceLabel: InsetLabel! {
        didSet {
            sourceLabel.layer.cornerRadius = 15
            sourceLabel.layer.borderWidth = 1.0
            sourceLabel.layer.masksToBounds = true
            sourceLabel.layer.borderColor = UIColor(color: .contentSecondary).withAlphaComponent(0.25).cgColor
            sourceLabel.contentInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
            sourceLabel.backgroundColor = UIColor(color: .backgroundTertiary)
            sourceLabel.textColor = UIColor(color: .contentSecondary)
            sourceLabel.font = UIFont.systemFont(ofSize: 14.0)
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet private weak var infoLabel: UILabel! {
        didSet {
            infoLabel.numberOfLines = 0
            infoLabel.font = UIFont.systemFont(ofSize: 16.0)
            infoLabel.textColor = UIColor(color: .contentSecondary)
        }
    }
    
    @IBOutlet weak var articleImage: LoadableImageView! {
        didSet {
            articleImage.layer.cornerRadius = 15
            articleImage.layer.masksToBounds = true
            articleImage.contentMode = .scaleAspectFill
            articleImage.backgroundColor = UIColor(color: .backgroundSecondary)
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var readMoreContainerView: UIView! {
        didSet {
            readMoreContainerView.layer.cornerRadius = 23
            readMoreContainerView.layer.borderWidth = 1.0
            readMoreContainerView.layer.masksToBounds = true
            readMoreContainerView.layer.borderColor = UIColor(color: .contentSecondary).withAlphaComponent(0.25).cgColor
            readMoreContainerView.backgroundColor = UIColor(color: .backgroundTertiary)
        }
    }
    
    @IBOutlet weak var readMoreActionLabel: UILabel! {
        didSet {
            readMoreActionLabel.text = "Tap here "
            readMoreActionLabel.isUserInteractionEnabled = true
            readMoreActionLabel.font = .systemFont(ofSize: 16.0)
            readMoreActionLabel.textColor = UIColor(color: .primaryTint)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapReadMoreActionLabel(_:)))
            readMoreActionLabel.addGestureRecognizer(tapGesture)
        }
    }
    
    @IBOutlet weak var readMoreTextLabel: UILabel! {
        didSet {
            readMoreTextLabel.text = "to read the full story"
            readMoreTextLabel.font = .systemFont(ofSize: 16.0)
            readMoreTextLabel.textColor = UIColor(color: .contentSecondary)
        }
    }
    
    
    // MARK: - IBActions
    
    @objc func didTapReadMoreActionLabel(_ sender: UITapGestureRecognizer) {
        print("TAPPED")
        output.didTapReadMoreAction()
    }

    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLoader = ImageLoader(compressionEnabled: false)
        view.backgroundColor = UIColor(color: .backgroundPrimary)
        output.viewIsReady()
    }
    
    
    // MARK: Private helpers
    
    private func setUpArticle() {
        sourceLabel.text = article.sourceName
        titleLabel.text = article.title
        infoLabel.text = "By \(article.author ?? "Unknown") ∙ \(article.publicationDate ?? "")"
        descriptionLabel.text = article.description
        
        
        titleLabel.attributedText = article.title?.attributed(with: UIFont(font: .georgia, weight: .bold, size: 26.0),
                                                              color: UIColor(color: .contentPrimary),
                                                              lineSpacing: 2.0)
        
        descriptionLabel.attributedText = article.description?.attributed(with: .systemFont(ofSize: 16.0),
                                                                          color: UIColor(color: .contentPrimary),
                                                                          lineSpacing: 3.0)
        
        if let imageUrl = article.imageUrl {
            articleImage.loadImage(from: imageUrl, with: imageLoader)
        } else {
            articleImage.image = UIImage(image: .emptyStateImage)
        }
        
    }
}


// MARK: ArticleDetailViewInput

extension ArticleDetailViewController: ArticleDetailViewInput {
    
    func showAlert(title: String, message: String) {
        showAlert(title: title, message: message, completion: nil)
    }
    
    func moduleInput() -> ArticleDetailModuleInput {
        output as! ArticleDetailModuleInput
    }
    
    func setupInitialState(with viewModel: ArticleViewModel) {
        self.article = viewModel
    }
}
