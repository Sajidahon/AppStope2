//
//  MainViewController.swift
//  AppStore
//
//  Created by Ualikhan Sabden on 02.12.2023.
//

import UIKit

class MainViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let cellId1 = "cellId1"
    let cellId2 = "cellId2"
    let cellId3 = "cellId3"
    
    var topFreeAppsData: FeedModel?
    var topPaidAppsData: FeedModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(BannerMainCell.self, forCellWithReuseIdentifier: cellId1)
        collectionView.register(AppsCell.self, forCellWithReuseIdentifier: cellId2)
        collectionView.register(AppsCell.self, forCellWithReuseIdentifier: cellId3)
    }
    
    func fetchData() {
        Service.shared.getTopApps(string: "top-free") { feeds, error in
            if let error = error {
                print("error: \(error)")
                return
            }
            
            if let feed = feeds?.feed {
                self.topFreeAppsData = feed
    
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
        }
        
        
        Service.shared.getTopApps(string: "top-paid") { feeds, error in
            if let error = error {
                print("error: \(error)")
                return
            }
            
            if let feed = feeds?.feed {
                self.topPaidAppsData = feed
    
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId1, for: indexPath) as! BannerMainCell
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId2, for: indexPath) as! AppsCell
            cell.appsData = self.topFreeAppsData
            
            cell.didSelectHandler = { index in
                let vc = AppDetailController(collectionViewLayout: UICollectionViewFlowLayout())
                vc.appData = self.topFreeAppsData?.results[index]
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId3, for: indexPath) as! AppsCell
            cell.appsData = self.topPaidAppsData
            

            cell.didSelectHandler = { index in
                let vc = AppDetailController(collectionViewLayout: UICollectionViewFlowLayout())
                vc.appData = self.topPaidAppsData?.results[index]
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            return cell
        }
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: collectionView.frame.width, height: 150)
        } else if indexPath.item == 1 {
            let perCellHeight: CGFloat = 90.0
            let spaces: CGFloat = 5.0
            
            let height = (perCellHeight * 3) + (spaces * 2)
            
            return CGSize(width: collectionView.frame.width, height: height)
        } else {
            let perCellHeight: CGFloat = 90.0
            let spaces: CGFloat = 5.0
            
            let height = (perCellHeight * 3) + (spaces * 2)
            
            return CGSize(width: collectionView.frame.width, height: height)
        }
    }
    
//    //didSelectItemAt
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = AppDetailController(collectionViewLayout: UICollectionViewFlowLayout())
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
}


