//
//  Models.swift
//  ShoppingApp
//
//  Created by Ricardo Montesinos on 15/09/20.
//  Copyright © 2020 Ricardo Montesinos. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

public struct ProductResults {
  let plpResults: PlpResults?
}
extension ProductResults: ImmutableMappable {
  public init(map: Map) throws {
    plpResults = try map.value("plpResults")
  }
}

public struct PlpResults {
  let label: String?
  let records: [Product]?
}
extension PlpResults: ImmutableMappable {
  public init(map: Map) throws {
    label = try map.value("label")
    records = try map.value("records")
  }
}

public struct Product {
    let productID: String?
    let skuRepositoryID: String?
    let productDisplayName: String?
    let productType: String?
    let productRatingCount: Double?
    let productAvgRating: Double?
    let listPrice: Double?
    let minimumListPrice: Double?
    let maximumListPrice: Double?
    let promoPrice: Double?
    let minimumPromoPrice: Double?
    let maximumPromoPrice: Double?
    let isHybrid: Bool?
    let isMarketPlace: Bool?
    let isImportationProduct: Bool?
    let seller: String?
    let category: String?
    let smImage: String?
    let lgImage: String?
    let xlImage: String?
}
extension Product: ImmutableMappable {
  public init(map: Map) throws {
    productID = try map.value("productId")
    skuRepositoryID = try map.value("skuRepositoryId")
    productDisplayName = try map.value("productDisplayName")
    productType = try map.value("productType")
    productRatingCount = try map.value("productRatingCount")
    productAvgRating = try map.value("productAvgRating")
    listPrice = try map.value("listPrice")
    minimumListPrice = try map.value("minimumListPrice")
    maximumListPrice = try map.value("maximumListPrice")
    promoPrice = try map.value("promoPrice")
    minimumPromoPrice = try map.value("minimumPromoPrice")
    maximumPromoPrice = try map.value("maximumPromoPrice")
    isHybrid = try map.value("isHybrid")
    isMarketPlace = try map.value("isMarketPlace")
    isImportationProduct = try map.value("isImportationProduct")
    seller = try map.value("seller")
    category = try map.value("category")
    smImage = try map.value("smImage")
    lgImage = try map.value("lgImage")
    xlImage = try map.value("xlImage")
  }
}

// MARK: - URLSession alternative to ALAMOFIRE.
//public struct ProductResults: Codable {
//  let status: Status
//  let plpResults: PlpResults
//}
//public struct Status: Codable {
//  let status: String
//}
//public struct PlpResults: Codable {
//  let label: String
//  let records: [Product]
//}
//public struct Product: Codable {
//    let productID: String?
//    let skuRepositoryID: String?
//    let productDisplayName: String?
//    let productType: String?
//    let productRatingCount: Double?
//    let productAvgRating: Double?
//    let listPrice: Double?
//    let minimumListPrice: Double?
//    let maximumListPrice: Double?
//    let promoPrice: Double?
//    let minimumPromoPrice: Double?
//    let maximumPromoPrice: Double?
//    let isHybrid: Bool?
//    let isMarketPlace: Bool?
//    let isImportationProduct: Bool?
//    let seller: String?
//    let category: String?
//    let smImage: String?
//    let lgImage: String?
//    let xlImage: String?
//    let brand: String?
//}
