//
//  SearchController.swift
//  AppStore
//
//  Created by Ualikhan Sabden on 02.12.2023.
//

import UIKit

class SearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var timer: Timer?
    var searchData = [SearchResultModel]()
    
    lazy var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        definesPresentationContext = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
        searchController.searchBar.placeholder = "Search application"
        searchController.searchBar.delegate = self
        searchController.definesPresentationContext = false
        searchController.obscuresBackgroundDuringPresentation = false
        
        collectionView.backgroundColor = .white
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search text:\(searchText)")
        
        timer?.invalidate()
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            Service.shared.searchApp(searchTerm: searchText) { (res, err) in
                
                if let err = err {
                    print("Failed to fetch apps:" , err)
                    return
                }
                
                self.searchData = res?.results ?? []
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
        
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! AppRowCell
        cell.configure(searchData[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width - 20, height: 90)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AppDetailController(collectionViewLayout: UICollectionViewFlowLayout())
        
        let appData = searchData[indexPath.item]
        vc.detailData = appData
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
