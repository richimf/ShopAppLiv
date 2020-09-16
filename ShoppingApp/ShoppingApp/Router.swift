//
//  Router.swift
//  ShoppingApp
//
//  Created by Ricardo Montesinos on 15/09/20.
//  Copyright © 2020 Ricardo Montesinos. All rights reserved.
//

import Foundation
import UIKit

final class Router: RouterProtocol {
  
  typealias PresenterProtocols = PresenterProtocol & InteractorOutputProtocol
   
  //SETUP INITIAL VIPER MODULE
   class func createModule(view: ViewController) {
     let presenter: PresenterProtocols = Presenter()
     view.presenter = presenter
     view.presenter?.router = Router()
     view.presenter?.view = view
     view.presenter?.interactor = Interactor()
     view.presenter?.interactor?.presenter = presenter
   }
  
  // GO TO DETAIL VIEW
  func showDetail(data: Product, from view: UIViewController) {
    let vc = DetailViewController()
    vc.setData(data: data)
    view.navigationController?.pushViewController(vc, animated: true)
  }

}
