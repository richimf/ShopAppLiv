//
//  ShoppingApp
//
//  Created by Ricardo Montesinos on 15/09/20.
//  Copyright © 2020 Ricardo Montesinos. All rights reserved.
//

import UIKit

// MARK: - COLORS
/// Folly Color, kind of red/pink
struct AppColors {
  let Main = UIColor(red:0.99, green:0.52, blue:0.92, alpha:1.00)
  let Main50 = UIColor(red:0.99, green:0.52, blue:0.92, alpha:0.50)
  let GrayLight = UIColor(red:0.74, green:0.74, blue:0.74, alpha:1.00)
  let BlackSoft = UIColor(red:0.13, green:0.15, blue:0.18, alpha:1.00)
}

enum FontSize: CGFloat {
  case huge = 20
  case big = 18
  case regular = 16
  case small = 14
}

struct Padding {
  let top: CGFloat?
  let left: CGFloat?
  let bottom: CGFloat?
  let right: CGFloat?
}

struct Anchor {
  let top: NSLayoutYAxisAnchor?
  let left: NSLayoutXAxisAnchor?
  let bottom: NSLayoutYAxisAnchor?
  let right: NSLayoutXAxisAnchor?
}
