//
//  OrdersViewModel.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 17/02/21.
//

import Foundation

// MARK: Navigation
protocol OrdersNavigationDelegate {
  func onBack()
}

// MARK: Delegate
protocol OrdersViewModelDelegate {
  func onBack()
}

// MARK: ViewModel
class OrdersViewModel {
  // MARK: Properties
  let navigation: OrdersNavigationDelegate

  // MARK: Init
  init(navigation: OrdersNavigationDelegate) {
    self.navigation = navigation
  }
}

// MARK: Extension Delegate
extension OrdersViewModel: OrdersViewModelDelegate {
  func onBack() {
    navigation.onBack()
  }
}
