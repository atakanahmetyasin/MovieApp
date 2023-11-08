//
//  MovieCell.swift
//  MovieApp
//
//  Created by Ahmet Yasin Atakan on 6.11.2023.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    var movieImageView : UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "kenny")
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var nameLabel : UILabel = {
        var nameLabel = UILabel()
        nameLabel.text = "Name"
//        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    var yearLabel : UILabel = {
        var yearLabel = UILabel()
        yearLabel.text = "Year"
        yearLabel.textAlignment = .center
        yearLabel.textColor = .white
        yearLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        return yearLabel
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        contentView.addSubview(movieImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(yearLabel)
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 30),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 30),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: 175),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 70),
            nameLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor,constant: 40),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),

            yearLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 10),
            yearLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor)
        ])
    }
}
