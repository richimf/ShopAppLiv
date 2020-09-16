//
//  Presenter.swift
//  ShoppingApp
//
//  Created by Ricardo Montesinos on 15/09/20.
//  Copyright © 2020 Ricardo Montesinos. All rights reserved.
//

import UIKit

final class Presenter: PresenterProtocol {
  
  weak var view: ViewProtocol?
  var interactor: InteractorInputProtocol?
  var router: RouterProtocol?
  
  var data: ProductResults?
  var history: [String]?
  
  func showDetail(data: Product, from view: UIViewController) {
    router?.showDetail(data: data, from: view)
  }

  func searchProduct(name: String) {
    interactor?.searchProduct(name: name)
  }

  func numberOfItems() -> Int {
    if let records = data?.plpResults?.records?.count {
      return records
    } else {
      return history?.count ?? 0
    }
  }
    
  func getItem(at index: Int) -> Product? {
    return data?.plpResults?.records?[index]
  }
  
  func getHistoryItem(at index: Int) -> String? {
    return history?[index]
  }

  func clearData() {
    self.data = nil
  }

  func showHistorySearches() {
    history = interactor?.getHistory()
    view?.reloadView()
  }
  
  func downloadImage(url: String?, completion: @escaping () -> Void) -> UIImage? {
    guard let url = url else { return nil }
    return interactor?.downloadImage(url: url, completion: completion)
  }
}
extension Presenter: InteractorOutputProtocol {
  func update(data: ProductResults?) {
    self.data = data
    view?.reloadView()
  }
  
  func showError() {
    view?.showError()
  }
}
