//
//  DetailViewController.swift
//  ShoppingApp
//
//  Created by Ricardo Montesinos on 15/09/20.
//  Copyright © 2020 Ricardo Montesinos. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
  
  private var data: Product?
  private let imageDownloader = ImageDownloader()
  private var productImage: UIImageViewAnchor = {
    let imgView: UIImageViewAnchor = UIImageViewAnchor()
    imgView.contentMode = .scaleAspectFit
    return imgView
  }()
  
  private let productNameLabel: UILabelAlingment = {
    let lbl = UILabelAlingment()
    return lbl.setup(size: .big, isBold: true)
  }()
  
  private let priceLabel: UILabelAlingment = {
    let lbl = UILabelAlingment()
    return lbl.setup(size: .big)
  }()
  
  // MARK: - OVERRIDES
  override func viewDidLoad() {
    super.viewDidLoad()
    self.productNameLabel.text = data?.productDisplayName
    if let price = data?.listPrice {
      self.priceLabel.text =  Utils.setPrice(price)
    }
    loadProductImage()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadProductImage()
  }
  
  private func loadProductImage() {
    guard let urlArt = data?.lgImage else { return }
    DispatchQueue.main.async {
      self.productImage.image = self.imageDownloader.retreiveImage(url: urlArt)
    }
  }
  
  override func loadView() {
    super.loadView()
    self.view.backgroundColor = .white
    self.view.addSubview(productImage)
    setupImageConstraints()
    setupInfoStack()
  }
  
  func setData(data: Product) {
    self.data = data
  }
  
  // MARK: Image SETUP
  private func setupImageConstraints() {
    productImage.arrangeCenterFrom(view: self.view, width: 200, topDistance: 40.0)
  }
  
  // MARK: Product Info SETUP
  private func setupInfoStack() {
    let stackView = UIStackViewAnchor(arrangedSubviews: [productNameLabel, priceLabel])
    stackView.distribution = .fillProportionally
    stackView.axis = .vertical
    stackView.spacing = 3
    self.view.addSubview(stackView)
    let stackAnchor = Anchor(top: productImage.bottomAnchor, left: productImage.leftAnchor, bottom: nil, right: nil)
    let stackPadding = Padding(top: 5, left: 5, bottom: 5, right: 5)
    stackView.anchor(anchor: stackAnchor, padding: stackPadding, width: 200, height: 0, enableInsets: false)
  }
}
