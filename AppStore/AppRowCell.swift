//
//  AppRowCell.swift
//  AppStore
//
//  Created by Ualikhan Sabden on 02.12.2023.
//

import UIKit

class AppRowCell: UICollectionViewCell {
    
    lazy var appImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Monopoly"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.text = "Match dice & collect coins"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var getButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get", for: .normal)
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        
        addSubview(appImageView)
        appImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        appImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        appImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        appImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        appImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        appImageView.layer.cornerRadius = 12
        appImageView.clipsToBounds = true
        
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: appImageView.rightAnchor, constant: 10).isActive = true
        
        addSubview(descLabel)
        descLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        descLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0).isActive = true
        descLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        
        addSubview(getButton)
        getButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        getButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        getButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        getButton.leftAnchor.constraint(greaterThanOrEqualTo: nameLabel.rightAnchor, constant: 20).isActive = true
        getButton.layer.cornerRadius = 15
        getButton.clipsToBounds = true
    }
    
    
    func configure(_ data: ResultModel?) {
        nameLabel.text = data?.name
        descLabel.text = data?.artistName
        appImageView.downloaded(from: data?.artworkUrl100 ?? "")
    }
    
    func configure(_ data: SearchResultModel?) {
        nameLabel.text = data?.trackName
        descLabel.text = data?.artistName
        appImageView.downloaded(from: data?.artworkUrl100 ?? "")
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
