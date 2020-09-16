//
//  SearchView.swift
//  ShoppingApp
//
//  Created by Ricardo Montesinos on 15/09/20.
//  Copyright © 2020 Ricardo Montesinos. All rights reserved.
//

import UIKit

final class SearchView: UIView, ViewSafeAreaProtocol {
  
  func setup(container: UIView, delegate: UITextFieldDelegate?) {
    let textField =  UITextField(frame: CGRect(x: 20, y: 40, width: container.frame.width-40, height: 40))
    textField.placeholder = "Busca un producto..."
    textField.font = UIFont.systemFont(ofSize: 15)
    textField.borderStyle = UITextField.BorderStyle.roundedRect
    textField.autocorrectionType = UITextAutocorrectionType.no
    textField.keyboardType = UIKeyboardType.default
    textField.returnKeyType = UIReturnKeyType.done
    textField.clearButtonMode = UITextField.ViewMode.whileEditing
    textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
    textField.delegate = delegate
    container.addSubview(textField)
  }
  
  func setupSearchView() {
    let searchTextField = UITextField()
    searchTextField.backgroundColor = .red
    let stackView = UIStackViewAnchor(arrangedSubviews: [searchTextField])
    stackView.distribution = .fillEqually
    stackView.axis = .vertical
    stackView.spacing = 5
    self.addSubview(stackView)
    let stackAnchor = Anchor(top: topAnchor, left: rightAnchor, bottom: bottomAnchor, right: rightAnchor)
    let stackPadding = Padding(top: 5, left: 15, bottom: 5, right: 10)
    stackView.anchor(anchor: stackAnchor, padding: stackPadding, width: 0, height: 100, enableInsets: false)
  }
}

