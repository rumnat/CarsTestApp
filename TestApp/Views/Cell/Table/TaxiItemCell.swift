//
//  TaxiItemCell.swift
//  TestApp
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

import UIKit

class TaxiItemCell: ConfigurableCell<TaxiItemCell.Configuration> {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var firstImageView: UIImageView!
    @IBOutlet private weak var secondImageView: UIImageView!
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        secondImageView.transform = .identity
    }
    
    // MARK: - Overriding
    
    override func configure(with configuration: Configuration) {
        titleLabel.text = configuration.title
        firstImageView.image = configuration.firstImage
        secondImageView.image = configuration.secondImage
        secondImageView.transform = .init(rotationAngle: configuration.rotationAngle)
    }
}

// MARK: - Cell configuration

extension TaxiItemCell {
    struct Configuration: BaseCellConfiguration {
        let title: String
        let firstImage: UIImage
        let secondImage: UIImage
        let rotationAngle: CGFloat
        
        init(title: String, firstImage: UIImage = #imageLiteral(resourceName: "ic_ride"), secondImage: UIImage = #imageLiteral(resourceName: "ic_pointer"), rotationAngle: CGFloat = 0.0) {
            self.title = title
            self.firstImage = firstImage
            self.secondImage = secondImage
            self.rotationAngle = rotationAngle
        }
    }
}
