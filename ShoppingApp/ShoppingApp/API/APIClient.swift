//
//  APIClient.swift
//  ShoppingApp
//
//  Created by Ricardo Montesinos on 15/09/20.
//  Copyright © 2020 Ricardo Montesinos. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

protocol APIResponseProtocol {
  func fetchedResult(data: ProductResults)
  func onFailure(_ error: Error)
}

protocol APIClientProtocol: class {
  func search(product: String, pageNumber: String, numberOfItems: String)
}

// MARK: - CONNECTIVITY
// Helps to know if device is connected to internet
final class Connectivity {
  class var isConnectedToInternet: Bool {
    return NetworkReachabilityManager()?.isReachable ?? false
  }
}

// MARK: - CLIENT
final class APIClient: APIClientProtocol {
  
  var delegate: APIResponseProtocol?
  
  func search(product: String, pageNumber: String, numberOfItems: String) {
    let params = [APIShopParams.forcePlp.rawValue: "true",
                  APIShopParams.searchString.rawValue: product,
                  APIShopParams.pageNumber.rawValue: pageNumber,
                  APIShopParams.numberOfItemsPerPage.rawValue: numberOfItems]
     fetchProductListOf(url: .search, params: params)
   }
  
  func fetchProductListOf(url: APIUrls, params: [String : String]) {
    Alamofire.request(url.rawValue, parameters: params).responseObject { (response: DataResponse<ProductResults>) in
      switch response.result {
      case .success(let results):
        self.delegate?.fetchedResult(data: results)
      case .failure(let error):
        self.delegate?.onFailure(error)
      }
    }
  }

  // MARK: - URLSession alternative to ALAMOFIRE.
  //  func search(product: String, pageNumber: String, numberOfItems: String) {
  //    var queryIems = [URLQueryItem]()
  //    queryIems.append(URLQueryItem(name: APIShopParams.searchString.rawValue, value: product))
  //    queryIems.append(URLQueryItem(name: APIShopParams.forcePlp.rawValue, value: "true"))
  //    queryIems.append(URLQueryItem(name: APIShopParams.pageNumber.rawValue, value: pageNumber))
  //    queryIems.append(URLQueryItem(name: APIShopParams.numberOfItemsPerPage.rawValue, value: numberOfItems))
  //    fetchProductListOf(url: .search, queryIems: queryIems)
  //  }
    
  //  func fetchProductListOf(url: APIUrls, queryIems: [URLQueryItem]) {
  //    var urlRequest = URLComponents(string: url.rawValue)
  //    urlRequest?.queryItems = queryIems
  //    guard let url = urlRequest?.url else { return }
  //    let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
  //      if error != nil {
  //        print(error)
  //        return
  //      }
  //      // Serialize the data into an object
  //      do {
  //        if let data = data {
  //          let responseData = try JSONDecoder().decode(ProductResults.self, from: data)
  //          print(responseData)
  //        }
  //      } catch {
  //        print("nada")
  //      }
  //    })
  //    task.resume()
  //  }
}
