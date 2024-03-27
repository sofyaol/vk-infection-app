//
//  PersonCollectionViewCell.swift
//  vk-infection-app
//
//  Created by Sofya Olekhnovich on 26.03.2024.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "PersonCell"
    
    var imageView: UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "person"))
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func prepareForReuse() {
        imageView.tintColor = .white
    }
    
    func setup(isInfected: Bool) {
        imageView.tintColor = isInfected ? .red : .white
        setupUI()
        setConstraints()
    }
    
    func infect() {
        imageView.tintColor = .red
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
