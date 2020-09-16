//
//  Interactor.swift
//  ShoppingApp
//
//  Created by Ricardo Montesinos on 15/09/20.
//  Copyright © 2020 Ricardo Montesinos. All rights reserved.
//

import Foundation
//
//  Interactor.swift
//  TopSongs
//
//  Created by Ricardo Montesinos on 08/03/20.
//  Copyright © 2020 RicardoMontesinos. All rights reserved.
//

import UIKit

final class Interactor: InteractorInputProtocol {

  // MARK: - VIPER
  weak var presenter: InteractorOutputProtocol?
  private let apiClient = APIClient()
  private let imageDownloader = ImageDownloader()
  private let historySearch = HistorySearch()
  
  func searchProduct(name: String) {
    historySearch.saveRecord(name)
    apiClient.delegate = self
    apiClient.search(product: name, pageNumber: "1", numberOfItems: "10")
  }
  
  func getHistory() -> [String]? {
    return historySearch.getHistory()
  }

  func downloadImage(url: String?, completion: @escaping () -> Void) -> UIImage? {
    guard let url = url else { return nil }
    if let image = imageDownloader.getSavedImageWith(key: url as NSString) {
      completion()
      return image
    }
    return imageDownloader.loadCompressedImage(from: url, completion: completion)
  }
}
extension Interactor: APIResponseProtocol {
  func fetchedResult(data: ProductResults) {
    presenter?.update(data: data)
  }
  
  func onFailure(_ error: Error) {
     presenter?.showError()
  }
}
