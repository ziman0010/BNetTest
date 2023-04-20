//
//  SearchCell.swift
//  BNet
//
//  Created by Алексей Черанёв on 19.04.2023.
//

import UIKit

final class SearchCell: UICollectionViewCell {
    
    static let reuseId = String(describing: SearchCell.self)
    
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    private let imageLoader: ImageLoader = Factory.shared.createImageLoader()
    
    override func layoutSubviews() {
            super.layoutSubviews()
            
            layer.shadowPath = UIBezierPath(
                roundedRect: bounds,
                cornerRadius: 8
            ).cgPath
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = nil
    }
    
    func set(viewObject: Item) {
        configureCellView()
        imageLoader.loadFromHost(urlString: viewObject.image) { image in
            DispatchQueue.main.async {
                self.imageView?.image = image
            }
        }
        nameLabel?.text = viewObject.name
        descriptionLabel?.text = viewObject.description
    }
    
    private func configureCellView() {
        
        
        layer.backgroundColor = UIColor.white.cgColor
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 8
        layer.masksToBounds = false

        layer.shadowRadius = 2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.15
    }
}
