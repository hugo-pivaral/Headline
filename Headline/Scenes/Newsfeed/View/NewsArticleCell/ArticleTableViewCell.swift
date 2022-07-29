//
//  ArticleTableViewCell.swift
//  Headline
//
//  Created by Hugo Pivaral on 1/05/22.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = UIColor(color: .contentPrimary)
            titleLabel.font = UIFont(font: .georgia, weight: .bold, size: 18.0)
            titleLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet private weak var timeLabel: UILabel! {
        didSet {
            timeLabel.textColor = UIColor(color: .contentSecondary)
            timeLabel.font = UIFont.systemFont(ofSize: 15.0)
        }
    }
    
    @IBOutlet private weak var sourceLabel: UILabel! {
        didSet {
            sourceLabel.textColor = UIColor(color: .contentSecondary)
            sourceLabel.font = UIFont.systemFont(ofSize: 15.0)
        }
    }
    
    @IBOutlet private weak var articleImage: LoadableImageView! {
        didSet {
            articleImage.backgroundColor = UIColor(color: .backgroundSecondary)
            articleImage.layer.cornerRadius = 15.0
            articleImage.layer.masksToBounds = true
        }
    }
    
    @IBOutlet private weak var timeIcon: UIImageView! {
        didSet {
            timeIcon.tintColor = UIColor(color: .contentSecondary)
            timeIcon.image = UIImage(image: .iconsClock)
        }
    }
    
    
    // MARK: - Overrides
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        articleImage.cancelImageLoad()
        articleImage.image = nil
    }
    
    
    // MARK: - Helpers
    
    func configure(with viewModel: ArticleViewModel, loader: ImageLoaderProvider) {
        backgroundColor = UIColor(color: .backgroundPrimary)
        
        titleLabel.text = viewModel.title
        timeLabel.text = viewModel.publicationDate
        sourceLabel.text = viewModel.sourceName
        
        if let imageUrl = viewModel.imageUrl {
            articleImage.loadImage(from: imageUrl, with: loader)
        } else {
            articleImage.image = UIImage(image: .emptyStateImage)
        }   
    }
}
