//
//  YDMStoreModeOfflineAccountViewModel.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas on 12/01/21.
//

import UIKit

import YDB2WIntegration
import YDUtilities
import YDExtensions

// MARK: Navigation
protocol HomeViewModelNavigationDelegate {
  func onExit()
  func openUserData()
  func openOfflineOrders()
}

// MARK: Delegate
protocol HomeViewModelDelegate {
  var error: Binder<(title: String, message: String)> { get }

  func onExit()
  func trackState()
  func onCard(tag: Int)
}

// MARK: ViewModel
class HomeViewModel {
  // MARK: Properties
  let navigation: HomeViewModelNavigationDelegate

  var error: Binder<(title: String, message: String)> = Binder(("", ""))

  // MARK: Init
  init(navigation: HomeViewModelNavigationDelegate) {
    self.navigation = navigation
  }
}

// MARK: Extension Delegate
extension HomeViewModel: HomeViewModelDelegate {

  func onExit() {
    navigation.onExit()
  }

  func trackState() {
    YDIntegrationHelper.shared.trackEvent(withName: .offlineAccountPerfil, ofType: .state)
  }

  func onCard(tag: Int) {
    switch tag {
      case 1:
        // QR Card
        error.value = (
          "poooxa, ainda não temos seu cadastro completo",
          "E pra mantermos a segurança dos seus dados, você poderá consultar mais informações com nosso atendimento, através do e-mail: atendimento.acom@americanas.com"
        )

      case 2:
        // User Data
        navigation.openUserData()

      case 3:
        // Offline orders
        navigation.openOfflineOrders()

      default:
        break
    }
  }
}
