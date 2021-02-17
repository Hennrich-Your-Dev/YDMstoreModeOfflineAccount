//
//  HomeViewController+Layout.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 17/02/21.
//

import UIKit

import YDB2WAssets
import YDExtensions

extension PreHomeViewController {
  func setUpLayout() {
    setViewBackgroundImage()
    createOpacityMask()
    createContainerView()
    createNavBar()
  }

  func setViewBackgroundImage() {
    if let image = Images.map {
      view.backgroundColor = UIColor(patternImage: image)
      view.hero.id = "background"
    }
  }

  func createOpacityMask() {
    let opacityView = UIView()
    opacityView.backgroundColor = UIColor.black.withAlphaComponent(0.75)
    view.addSubview(opacityView)

    opacityView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      opacityView.topAnchor.constraint(equalTo: view.topAnchor),
      opacityView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      opacityView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      opacityView.heightAnchor.constraint(equalToConstant: 100)
    ])
  }

  func createContainerView() {
    let containerView = UIView()
    containerView.backgroundColor = .white
    containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    containerView.layer.cornerRadius = 16

    view.addSubview(containerView)

    containerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                         constant: 18),
      containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }

  func createNavBar() {
//    guard let container = view.subviews.at(1) else { return }
//
//    let navBar = UIView()
//    navBar.backgroundColor = .white
//    container.addSubview(navBar)
//
//    navBar.translatesAutoresizingMaskIntoConstraints = false
//    NSLayoutConstraint.activate([
//      navBar.heightAnchor.constraint(equalToConstant: 48),
//      navBar.topAnchor.constraint(equalTo: container.topAnchor,
//                                  constant: 20),
//      navBar.leadingAnchor.constraint(equalTo: container.leadingAnchor),
//      navBar.trailingAnchor.constraint(equalTo: container.trailingAnchor)
//    ])
//
//    createBackButton(parent: navBar)
  }

  func createBackButton(parent navBar: UIView) {
//    let backButton = UIButton()
//    backButton.setImage(Icons.leftArrow, for: .normal)
//    backButton.backgroundColor = .white
//    backButton.tintColor = UIColor.Zeplin.black
//    navBar.addSubview(backButton)
//
//    backButton.translatesAutoresizingMaskIntoConstraints = false
//    NSLayoutConstraint.activate([
//      backButton.widthAnchor.constraint(equalToConstant: 32),
//      backButton.heightAnchor.constraint(equalToConstant: 32),
//      backButton.topAnchor.constraint(equalTo: navBar.topAnchor),
//      backButton.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 16),
//    ])
//
//    backButton.layer.cornerRadius = 16
//    backButton.layer.applyShadow()
//    backButton.addTarget(self,
//                         action: #selector(onBackAction),
//                         for: .touchUpInside)
  }
}
