//
//  HistorySearch.swift
//  ShoppingApp
//
//  Created by Ricardo Montesinos on 15/09/20.
//  Copyright © 2020 Ricardo Montesinos. All rights reserved.
//

import Foundation

final class HistorySearch {
  
  var searchedInput: [String] = []
  let defaults = UserDefaults.standard
  let historyKey = "history"

  func saveRecord(_ value: String) {
    searchedInput.append(value)
    defaults.set(searchedInput, forKey: historyKey)
  }
  
  func getHistory() -> [String]? {
    return defaults.stringArray(forKey: historyKey)
  }
}
