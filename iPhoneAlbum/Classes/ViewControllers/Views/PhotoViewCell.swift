//
//  PhotoViewCell.swift
//  iPhoneAlbum
//
//  Created by Alan YU on 15/2/2017.
//  Copyright © 2017 Alan YU. All rights reserved.
//

import UIKit
import Photos

class PhotoViewCell: UICollectionViewCell {
    
    private static let imageManager = PHCachingImageManager()
    
    @IBOutlet weak var imageView: UIImageView!
    
    private var requestID: PHImageRequestID?
    
    var asset: PHAsset? {
        didSet {
            
            imageView.image = nil
            
            if let requestID = self.requestID {
                PhotoViewCell.imageManager.cancelImageRequest(requestID)
                NSLog("Cancel request : \(requestID)")
                self.requestID = nil
            }
            
            if let strongAsset = asset {
            
                let scale = UIScreen.main.scale
                let size = CGSize(width: frame.size.width * scale, height: frame.size.height * scale)
                
                let requestOptions = PHImageRequestOptions()
                //requestOptions.deliveryMode = .highQualityFormat
                requestOptions.isSynchronous = false
                
                self.requestID = PhotoViewCell.imageManager.requestImage(
                    for: strongAsset,
                    targetSize: size,
                    contentMode: .aspectFill,
                    options: requestOptions,
                    resultHandler: { [weak self] image, info in
                        if let strongSelf = self {
                            strongSelf.imageView.image = image
                            strongSelf.requestID = nil
                        }
                    }
                )
                
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
