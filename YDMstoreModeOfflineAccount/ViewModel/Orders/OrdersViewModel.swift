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
  var userClientLasaToken: String { get }

  func onBack()
}

// MARK: ViewModel
class OrdersViewModel {
  // MARK: Properties
  let navigation: OrdersNavigationDelegate
  var userClientLasaToken: String

  // MARK: Init
  init(navigation: OrdersNavigationDelegate, userToken: String) {
    self.navigation = navigation
    self.userClientLasaToken = userToken
  }
}

// MARK: Extension Delegate
extension OrdersViewModel: OrdersViewModelDelegate {
  func onBack() {
    navigation.onBack()
  }
}
