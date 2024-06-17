//
//  UIView+Extension.swift
//  bottomCard
//
//  Created by sagar on 07/04/23.
//  Copyright © 2023 fluffy. All rights reserved.
//

import Foundation
import UIKit

extension UIView  {
    // render the view within the view's bounds, then capture it as image
  func asImage() -> UIImage {
    let renderer = UIGraphicsImageRenderer(bounds: bounds)
      return renderer.image(actions: { rendererContext in
        layer.render(in: rendererContext.cgContext)
    })
  }
}
