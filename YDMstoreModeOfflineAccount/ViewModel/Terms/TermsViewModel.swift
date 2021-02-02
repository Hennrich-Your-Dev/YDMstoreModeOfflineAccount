//
//  TermsViewModel.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 02/02/21.
//

import Foundation

import YDB2WIntegration
import YDUtilities
import YDExtensions

// MARK: Navigation
protocol TermsNavigationDelegate {
  func onBack()
}

// MARK: Delegate
protocol TermsViewModelDelegate {
  func onBack()
}

// MARK: ViewModel
class TermsViewModel {
  // MARK: Properties
  let navigation: TermsNavigationDelegate

  // MARK: Init
  init(navigation: TermsNavigationDelegate) {
    self.navigation = navigation
  }
}

// MARK: Extension Delegate
extension TermsViewModel: TermsViewModelDelegate {
  func onBack() {
    navigation.onBack()
  }
}
