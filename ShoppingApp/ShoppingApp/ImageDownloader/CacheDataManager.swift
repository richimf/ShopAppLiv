//
//  LocalDataManager.swift
//  TopSongs
//
//  Created by Ricardo Montesinos on 09/03/20.
//  Copyright © 2020 RicardoMontesinos. All rights reserved.
//

import UIKit

// MARK: - IMAGE CACHE SINGLETON
public class CacheDataManager {
  
  static let shared = CacheDataManager()
  
  private(set) var imageCache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()

  init() { }

}
