//
//  APIConstants.swift
//  ShoppingApp
//
//  Created by Ricardo Montesinos on 15/09/20.
//  Copyright © 2020 Ricardo Montesinos. All rights reserved.
//

import Foundation

// MARK: API
public enum APIUrls: String {
  case search = "https://shoppapp.liverpool.com.mx/appclienteservices/services/v3/plp"
}
public enum APIShopParams: String {
  case forcePlp = "force-plp"
  case searchString = "search-string"
  case pageNumber = "page-number"
  case numberOfItemsPerPage = "number-of-items-per-page"
}
