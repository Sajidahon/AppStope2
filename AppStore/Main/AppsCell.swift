//
//  AppsCell.swift
//  AppStore
//
//  Created by Ualikhan Sabden on 09.12.2023.
//

import UIKit

class AppsCell: UICollectionViewCell {
    
    var appsData: FeedModel? {
        didSet {
            DispatchQueue.main.async {
                self.horizontalCollectionView.reloadData()
            }
        }
    }
    
    lazy var horizontalCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var didSelectHandler: ((Int) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupUI()
    }
    
    func setupCollectionView() {
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        
        horizontalCollectionView.backgroundColor = .white
        horizontalCollectionView.register(AppRowCell.self, forCellWithReuseIdentifier: "cellId")
        horizontalCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        horizontalCollectionView.isPagingEnabled = true
        if let flowLayout = horizontalCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
    }
        
    func setupUI() {
        addSubview(horizontalCollectionView)
        horizontalCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        horizontalCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        horizontalCollectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        horizontalCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppsCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    //cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! AppRowCell
        cell.configure(appsData?.results[indexPath.item])
        
        return cell
    }
    
    //sizeForItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let perCellHeight: CGFloat = 90.0
        
        let cellWidth = collectionView.frame.width - 48
        
        return CGSize(width: cellWidth, height: perCellHeight)
    }
    
    //minimumLineSpacingForSectionAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    //minimumInteritemSpacingForSectionAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectHandler?(indexPath.item)
    }
}

