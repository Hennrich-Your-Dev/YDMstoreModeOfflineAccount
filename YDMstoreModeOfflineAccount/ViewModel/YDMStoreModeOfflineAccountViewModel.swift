//
//  YDMStoreModeOfflineAccountViewModel.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas on 12/01/21.
//

import Foundation

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
  func onCard(tag: Int)
}

// MARK: ViewModel
class YDMStoreModeOfflineAccountViewModel {
  // MARK: Properties
  let navigation: YDMStoreModeOfflineAccountNavigationDelegate
  let service: YDMStoreModeOfflineAccountServiceDelegate

  var error: Binder<(title: String, message: String)> = Binder(("", ""))
  
  // MARK: Init
  init(
    navigation: YDMStoreModeOfflineAccountNavigationDelegate,
    service: YDMStoreModeOfflineAccountServiceDelegate
  ) {
    self.navigation = navigation
    self.service = service
  }
}

// MARK: Extension Delegate
extension YDMStoreModeOfflineAccountViewModel: YDMStoreModeOfflineAccountViewModelDelegate {
  func onExit() {
    navigation.onExit()
  }

  func onCard(tag: Int) {
    if tag == 0 {
      // open qr card
      error.value = ("Titulo do alerta", String.loremIpsum())

    } else {
      navigation.openUserData()
    }
  }
}
