//
//  ShoppingApp
//
//  Created by Ricardo Montesinos on 15/09/20.
//  Copyright © 2020 Ricardo Montesinos. All rights reserved.
//

import UIKit

// THIS CLASS CHANGES THE TEXT ALIGNMENT OF UILABEL.
class UILabelAlingment: UILabel {

  override func drawText(in rect: CGRect) {
    var newRect = rect
    switch contentMode {
    case .top:
      newRect.size.height = sizeThatFits(rect.size).height
    case .bottom:
      let height = sizeThatFits(rect.size).height
      newRect.origin.y += rect.size.height - height
      newRect.size.height = height
    default:
      ()
    }
    super.drawText(in: newRect)
  }
  
  func setup(size: FontSize, textColor: UIColor = .black, isBold: Bool = false) -> UILabelAlingment {
    let lbl = UILabelAlingment()
    lbl.textColor = textColor
    lbl.numberOfLines = 0
    let size = size.rawValue
    lbl.font = isBold ? UIFont.boldSystemFont(ofSize: size) : UIFont.systemFont(ofSize: size)
    lbl.textAlignment = .left
    return lbl
  }
}
