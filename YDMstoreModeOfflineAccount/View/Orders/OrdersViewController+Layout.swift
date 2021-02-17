//
//  OrdersViewController+Layout.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 17/02/21.
//

import UIKit

import YDB2WAssets
import YDExtensions

extension OrdersViewController {
  func setUpLayout() {
    setViewBackgroundImage()
    createOpacityMask()
    createContainerView()
  }

  func setViewBackgroundImage() {
    if let image = Images.map {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }

  func createOpacityMask() {
    let opacityLayer = CALayer()
    let opacityShape = CAShapeLayer()
    opacityShape.path = UIBezierPath(rect: view.frame).cgPath
    opacityShape.frame = view.bounds
    opacityShape.backgroundColor = UIColor.black.withAlphaComponent(0.1).cgColor
    opacityLayer.mask = opacityShape

    view.layer.addSublayer(opacityLayer)
  }

  func createContainerView() {
    let containerView = UIView()
    view.addSubview(containerView)

    containerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                         constant: 10)
    ])
  }
}
