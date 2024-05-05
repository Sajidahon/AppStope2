//
//  AppDetailController.swift
//  AppStore
//
//  Created by Ualikhan Sabden on 09.12.2023.
//

import UIKit

class AppDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId1 = "cellId1"
    let cellId2 = "cellId2"
    let cellId3 = "cellId3"
    
    var appData: ResultModel?
    var detailData: SearchResultModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: cellId1)
        collectionView.register(ScreenMainCell.self, forCellWithReuseIdentifier: cellId2)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId3)
        
        fetchScreenshots()
    }
    
    func fetchScreenshots() {
        Service.shared.getDetailsForApp(appId: appData?.id ?? "") { result, error in
            if let error = error {
                print("error: \(error)")
                return
            }
            
            if let data = result?.results.first(where: { model in
                model.trackId == Int(self.appData?.id ?? "0")
            }) {
                self.detailData = data
                print("results = \(data)")
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    //numberOfItemsInSection
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    //cellForItemAt
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId1, for: indexPath) as! AppDetailCell
            cell.configure(detailData)
            
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId2, for: indexPath) as! ScreenMainCell
            cell.detailData = detailData
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId3, for: indexPath)
            return cell
        }
    }
    
    //sizeForItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: collectionView.frame.width, height: 200)
        } else if indexPath.item == 1 {
            return CGSize(width: collectionView.frame.width, height: 600)
        } else {
            return CGSize(width: collectionView.frame.width, height: 150)
        }
    }
    
}
