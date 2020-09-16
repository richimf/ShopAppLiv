//
//  ImageDownloader.swift
//  ShoppingApp
//
//  Created by Ricardo Montesinos on 15/09/20.
//  Copyright © 2020 Ricardo Montesinos. All rights reserved.
//

import UIKit

// DOWNLOAD AND COMPRESSING IMAGE METHOD
class ImageDownloader {
  
  private lazy var imageCache = CacheDataManager.shared.imageCache
  
  // DOWNLOAD IMAGE METHOD
  public func getSavedImageWith(key: NSString) -> UIImage? {
    return imageCache.object(forKey: key)
  }

  // LOAD SAVED IMAGE OR DOWNLOAD IT
  public func retreiveImage(url: String?) -> UIImage? {
    guard let url = url else { return nil }
    if let image = getSavedImageWith(key: url as NSString) {
      return image
    }
    return loadCompressedImage(from: url){}
  }

  // DOWNLOAD IMAGE AND STORE IT INTO CACHE WITH A KEY
  func loadCompressedImage(from path: String, completion: @escaping () -> Void ) -> UIImage {
    let size = CGSize(width: 100, height: 100)
    let key: NSString = NSString(string: path)
    
    // Get Image Cached
    if let imageCached: UIImage = imageCache.object(forKey: key) {
      return imageCached
    }
    // Download and Compress image to fit container size
    DispatchQueue.global(qos: .background).async {
      guard let url: URL = URL(string: path),
            let newimage: UIImage = self.downloadAndCompress(url: url, newSize: size) else { return }
      // Save image on cache
      self.imageCache.setObject(newimage, forKey: key)
      // Show in UI
      DispatchQueue.main.async {
        completion()
      }
    }
    return UIImage()
  }
  
  private func downloadAndCompress(url: URL, newSize: CGSize) -> UIImage? {
    guard let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
      let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil),
      let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) else { return nil }
      let context = CGContext(data: nil,
                             width: Int(newSize.width),
                            height: Int(newSize.height),
                            bitsPerComponent: image.bitsPerComponent,
                            bytesPerRow: image.bytesPerRow,
                            space: image.colorSpace ?? colorSpace,
                            bitmapInfo: image.bitmapInfo.rawValue)
    context?.interpolationQuality = .high
    context?.draw(image, in: CGRect(origin: .zero, size: newSize))
    guard let scaledImage = context?.makeImage() else { return nil }
    return UIImage(cgImage: scaledImage)
  }
}
