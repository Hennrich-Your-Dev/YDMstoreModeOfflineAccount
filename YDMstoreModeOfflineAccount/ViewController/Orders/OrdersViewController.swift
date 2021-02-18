//
//  OrdersViewController.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 17/02/21.
//

import UIKit

import YDB2WAssets
import YDExtensions

class OrdersViewController: UIViewController {
  // MARK: Properties
  var viewModel: OrdersViewModelDelegate?
  var shadowContainerView: UIView!

  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "minhas compras nas lojas"

    view.backgroundColor = .white
    setUpLayout()
  }

  // MARK: Actions
  func toggleNavShadow(_ show: Bool) {
    DispatchQueue.main.async { [weak self] in
      if show {
        UIView.animate(withDuration: 0.5) { [weak self] in
          self?.shadowContainerView.layer.applyShadow()
        }
      } else {
        UIView.animate(withDuration: 0.5) { [weak self] in
          self?.shadowContainerView.layer.shadowOpacity = 0
        }
      }
    }
  }
}

// MARK: Offline Orders Delegate
//extension OrdersViewController: YDMSOfflineOrdersDelegate {
//
//}
