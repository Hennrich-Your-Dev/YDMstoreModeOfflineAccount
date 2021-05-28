//
//  OrdersViewController+Layout.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 17/02/21.
//

import UIKit

import YDB2WAssets
import YDExtensions
import YDMOfflineOrders

extension OrdersViewController {
  func setUpLayout() {
    createBackButton()
    createContainerView()
  }

  func createBackButton() {
    let backButtonView = UIButton()
    backButtonView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
    backButtonView.layer.cornerRadius = 16
    backButtonView.layer.applyShadow()
    backButtonView.backgroundColor = .white
    backButtonView.setImage(Icons.leftArrow, for: .normal)
    backButtonView.addTarget(self, action: #selector(onBackAction), for: .touchUpInside)

    let backButton = UIBarButtonItem()
    backButton.customView = backButtonView

    navigationItem.leftBarButtonItem = backButton
  }

  @objc func onBackAction(_ sender: UIButton) {
    viewModel?.onBack()
  }

  func createContainerView() {
    let containerView = UIView()
    view.addSubview(containerView)

    containerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])

    importOrdersView(container: containerView)
  }

  func importOrdersView(container: UIView) {
    ordersViewController = YDMOfflineOrders().start()
    addChild(ordersViewController)

    container.addSubview(ordersViewController.view)

    ordersViewController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      ordersViewController.view.topAnchor.constraint(equalTo: container.topAnchor),
      ordersViewController.view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      ordersViewController.view.trailingAnchor.constraint(equalTo: container.trailingAnchor),
      ordersViewController.view.bottomAnchor.constraint(equalTo: container.bottomAnchor)
    ])
  }
}
