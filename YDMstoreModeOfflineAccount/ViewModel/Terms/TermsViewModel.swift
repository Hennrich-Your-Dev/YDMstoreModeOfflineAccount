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
import YDSpacey
import YDB2WModels

// MARK: Navigation
protocol TermsNavigationDelegate {
  func onBack()
}

// MARK: Delegate
protocol TermsViewModelDelegate {
  var loading: Binder<Bool> { get }
  var list: Binder<[YDSpaceyCommonStruct]> { get }

  func getSpacey()
  func onBack()
}

// MARK: ViewModel
class TermsViewModel {
  // MARK: Properties
  let navigation: TermsNavigationDelegate
  let spaceyViewModel: YDSpaceyViewModelDelegate
  let spaceyId: String

  var loading = Binder(false)
  var list: Binder<[YDSpaceyCommonStruct]> = Binder([])

  // MARK: Init
  init(
    navigation: TermsNavigationDelegate,
    spaceyViewModel: YDSpaceyViewModelDelegate,
    spaceyId: String
  ) {
    self.navigation = navigation
    self.spaceyViewModel = spaceyViewModel
    self.spaceyId = spaceyId

    configureBind()
    YDIntegrationHelper.shared.trackEvent(withName: .offlineAccountTerms, ofType: .state)
  }

  func configureBind() {
    spaceyViewModel.loading.bind { [weak self] isLoading in
      guard let self = self else { return }
      self.loading.value = isLoading
    }

    spaceyViewModel.componentsList.bind { [weak self] list in
      guard let self = self else { return }
      self.list.value = list
    }
  }
}

// MARK: Extension Delegate
extension TermsViewModel: TermsViewModelDelegate {
  func getSpacey() {
    spaceyViewModel.getSpacey(withId: spaceyId, customApi: nil)
  }

  func onBack() {
    navigation.onBack()
  }
}
