//
//  Protocols.swift
//  ShoppingApp
//
//  Created by Ricardo Montesinos on 15/09/20.
//  Copyright © 2020 Ricardo Montesinos. All rights reserved.
//

import UIKit

protocol DownloadImageProtocol {
  func searchProduct(name: String)
  func downloadImage(url: String?, completion: @escaping () -> Void) -> UIImage?
}

protocol DetailViewProtocol {
  //func showDetail(data: MusicData, from view: UIViewController)
}

// MARK: - VIPER Protocols
protocol ViewProtocol: class {
  var presenter: PresenterProtocol? { get set}
  // PRESENTER -> VIEW
  func reloadView()
  func showError()
}

protocol PresenterProtocol: class, DownloadImageProtocol, DetailViewProtocol {
  var view: ViewProtocol? { get set }
  var interactor: InteractorInputProtocol? { get set}
  var router: RouterProtocol? { get set }
  // VIEW -> PRESENTER
  var data: ProductResults? { get set }
  func numberOfItems() -> Int
  func getItem(at index: Int) -> Product?
//  func getItem(at index: Int) -> String?
  func clearData()
  func showHistorySearches()
  func getHistoryItem(at index: Int) -> String?
  func showDetail(data: Product, from view: UIViewController)
}

protocol InteractorInputProtocol: class, DownloadImageProtocol {
  var presenter: InteractorOutputProtocol? { get set}
  // PRESENTER -> INTERACTOR
  func getHistory() -> [String]? 
}

protocol InteractorOutputProtocol: class {
  // INTERACTOR -> PRESENTER
  func update(data: ProductResults?)
  func showError()
}

protocol RouterProtocol: class, DetailViewProtocol {
  // PRESENTER -> ROUTER
  func showDetail(data: Product, from view: UIViewController)
}
