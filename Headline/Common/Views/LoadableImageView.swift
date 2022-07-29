//
//  LoadableImageView.swift
//  Headline
//
//  Created by Hugo Pivaral on 6/07/22.
//

import UIKit

class LoadableImageView: UIImageView {
    
    // MARK: Parameters
    
    var uuid: UUID!
    var provider: ImageLoaderProvider!
    
    
    // MARK: Views
    
    var activityIndicator: UIActivityIndicatorView? {
        didSet {
            activityIndicator?.style = .medium
            activityIndicator?.color = UIColor(color: .contentSecondary)
            activityIndicator?.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    
    // MARK: Public helpers
    
    func loadImage(from url: URL, with provider: ImageLoaderProvider) {
        showActivityIndicator()
        self.provider = provider
        
        self.uuid = provider.loadImage(from: url) { [weak self] result in
            self?.hideActivityIndicator()
            
            switch result {
            case .success(let image):
                self?.image = image
            case .failure(_):
                self?.image = UIImage(image: .emptyStateImage)
            }
        }
    }
    
    func cancelImageLoad() {
        guard let uuid = uuid else { return }
        provider?.cancelImageLoad(for: uuid)
        hideActivityIndicator()
    }
    
    
    // MARK: Private helpers
    
    private func showActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        self.addSubview(activityIndicator!)
        
        activityIndicator?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicator?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator?.startAnimating()
    }
    
    private func hideActivityIndicator() {
        activityIndicator?.removeFromSuperview()
    }
}
