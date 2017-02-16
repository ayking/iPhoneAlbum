//
//  ViewController.swift
//  iPhoneAlbum
//
//  Created by Alan YU on 15/2/2017.
//  Copyright © 2017 Alan YU. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
    
    fileprivate let Spacing = CGFloat(0.5)
    fileprivate let Column = CGFloat(3)
    
    fileprivate var PhotoWidth = CGFloat(0)
    fileprivate var assetList = [PHAsset]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        PhotoWidth = view.frame.size.width / Column - Spacing
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: PHFetchOptions())
        smartAlbums.enumerateObjects({ (collection, i, stop) in
            let assets = PHAsset.fetchAssets(in: collection, options: fetchOptions)
            assets.enumerateObjects({ (asset, i, stop) in
                self.assetList.append(asset)
            })
        })
        
        collectionView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: PhotoWidth, height: PhotoWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return Spacing
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assetList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoViewCell", for: indexPath) as! PhotoViewCell
        cell.asset = assetList[indexPath.item]
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
}

