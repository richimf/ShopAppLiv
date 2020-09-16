//
//  ViewController.swift
//  ShoppingApp
//
//  Created by Ricardo Montesinos on 15/09/20.
//  Copyright © 2020 Ricardo Montesinos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ViewProtocol {

  // MARK: - PROPERTIES
  private let tableView: UITableViewSafeArea = UITableViewSafeArea()
  private let historyCellId: String = "historyCellId"
  private let productCellId: String = "productCellId"
  private let rowHeight: CGFloat = 110
  private var searchView: SearchView?

  // MARK: - VIPER
  var presenter: PresenterProtocol?
  
  // MARK: - OVERRIDES
  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
    // VIPER VIEW CONNECTION
    Router.createModule(view: self)
    presenter?.showHistorySearches()
    self.navigationController?.navigationBar.tintColor = AppColors().Main
  }
  
  override func loadView() {
    super.loadView()
    view.backgroundColor = .white
    setupTableView()
    setupSearchView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  // MARK: - PRIVATE METHODS
  private func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorStyle = .none
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = rowHeight
    tableView.register(ProductCell.self, forCellReuseIdentifier: productCellId)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: historyCellId)
    tableView.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height-100)
    self.view.addSubview(tableView)
    //tableView.setupAnchorWithSafeArea(container: self.view, safeArea: view.layoutMarginsGuide)
  }
  
  private func setupSearchView() {
    searchView = SearchView()
    searchView?.setup(container: self.view, delegate: self)
  }
  
  // MARK: - VIEW PROTOCOL METHODS
  func reloadView() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  func showError() {
    let alert = Utils.showAlert(title: "Error", message: "Request failed")
    DispatchQueue.main.async {
      self.present(alert, animated: true)
    }
  }
}

// MARK: - EXTENSIONS
extension ViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter?.numberOfItems() ?? 0
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return rowHeight
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let data = presenter?.getItem(at: indexPath.row) else { return }
    presenter?.showDetail(data: data, from: self)
    self.tableView.deselectRow(at: indexPath, animated: true)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let data = presenter?.getItem(at: indexPath.row) {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: productCellId, for: indexPath)
        as? ProductCell else { return UITableViewCell() }
      let image = presenter?.downloadImage(url: data.lgImage) { self.reloadRowAt(indexPath) }
      cell.set(product: data, cover: image)
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: historyCellId, for: indexPath) as UITableViewCell
      cell.selectionStyle = .none
      cell.textLabel?.text = presenter?.getHistoryItem(at: indexPath.row)
      return cell
    }
  }
  
  private func reloadRowAt(_ indexPath: IndexPath) {
    self.tableView.beginUpdates()
    self.tableView.reloadRows( at: [indexPath], with: .fade)
    self.tableView.endUpdates()
  }
}
extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    if let input = textField.text {
      presenter?.searchProduct(name: input)
    }
    return true
  }

  //TEXTFIELD IS EMPTY NOW
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let textFieldRange = NSRange(location: 0, length: textField.text?.count ?? 0)
    if NSEqualRanges(range, textFieldRange) && string.count == 0 {
      showHistory()
    }
    return true
  }

  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    showHistory()
    return true
  }

  private func showHistory() {
    presenter?.clearData()
    presenter?.showHistorySearches()
  }
}

