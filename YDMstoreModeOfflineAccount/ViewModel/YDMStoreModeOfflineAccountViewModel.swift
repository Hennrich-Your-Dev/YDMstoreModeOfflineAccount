//
//  YDMStoreModeOfflineAccountViewModel.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas on 12/01/21.
//

import Foundation

// MARK: Navigation
protocol YDMStoreModeOfflineAccountNavigationDelegate {
  func onExit()
}

// MARK: Delegate
protocol YDMStoreModeOfflineAccountViewModelDelegate {
  func onExit()
  func onCard(tag: Int)
}

// MARK: ViewModel
class YDMStoreModeOfflineAccountViewModel {
  // MARK: Properties
  let navigation: YDMStoreModeOfflineAccountNavigationDelegate
  let service: YDMStoreModeOfflineAccountServiceDelegate
  
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
    } else {
      // open clipboard card
    }
  }
}
