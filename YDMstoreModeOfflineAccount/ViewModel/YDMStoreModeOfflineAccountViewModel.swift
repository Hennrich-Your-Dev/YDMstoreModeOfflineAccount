//
//  YDMStoreModeOfflineAccountViewModel.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas on 12/01/21.
//

import Foundation

import YDB2WIntegration
import YDUtilities
import YDExtensions

// MARK: Navigation
protocol YDMStoreModeOfflineAccountNavigationDelegate {
  func onExit()
  func openUserData()
}

// MARK: Delegate
protocol YDMStoreModeOfflineAccountViewModelDelegate {
  var error: Binder<(title: String, message: String)> { get }

  func onExit()
  func trackState()
  func onCard(tag: Int)
}

// MARK: ViewModel
class YDMStoreModeOfflineAccountViewModel {
  // MARK: Properties
  let navigation: YDMStoreModeOfflineAccountNavigationDelegate

  var error: Binder<(title: String, message: String)> = Binder(("", ""))

  // MARK: Init
  init(navigation: YDMStoreModeOfflineAccountNavigationDelegate) {
    self.navigation = navigation
  }
}

// MARK: Extension Delegate
extension YDMStoreModeOfflineAccountViewModel: YDMStoreModeOfflineAccountViewModelDelegate {
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
        break

      default:
        break
    }
  }
}
