//
//  OrdersViewController.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 17/02/21.
//

import UIKit

import YDB2WAssets
import YDExtensions
import YDMOfflineOrders

class OrdersViewController: UIViewController {
  // MARK: Properties
  var viewModel: OrdersViewModelDelegate?
  var ordersViewController: YDMOfflineOrdersViewController

  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "minhas compras nas lojas"

    view.backgroundColor = .white
    setUpLayout()
  }
  
  init(offlineOrderViewController: YDMOfflineOrdersViewController) {
    self.ordersViewController = offlineOrderViewController
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
