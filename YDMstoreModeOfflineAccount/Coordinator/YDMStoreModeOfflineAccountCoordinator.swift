//
//  YDMStoreModeOfflineAccountCoordinator.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas on 12/01/21.
//

import UIKit
import Hero

import YDB2WIntegration
import YDExtensions
import YDUtilities
import YDB2WModels
import YDSpacey

public typealias YDMStoreModeOfflineAccount = YDMStoreModeOfflineAccountCoordinator

public class YDMStoreModeOfflineAccountCoordinator: HistoricNavigationDelegate {

  // Properties
  var rootNavigationController: UINavigationController?
  var navigationController: UINavigationController?
  var currentUser: YDCurrentCustomer!

  // MARK: Init
  public init() {}

  // MARK: Actions
  public func start(navCon: UINavigationController?, user: YDCurrentCustomer) {
    let viewController = PreHomeViewController()

    currentUser = user

    let viewModel = PreHomeViewModel(navigation: self)
    viewController.viewModel = viewModel

    rootNavigationController = navCon
    rootNavigationController?.pushViewController(viewController, animated: true)
  }

  func startHome() {
    guard let viewController = HomeViewController.initializeFromStoryboard()
    else {
      fatalError("HomeViewController.initializeFromStoryboard")
    }

    let viewModel = HomeViewModel(navigation: self, user: currentUser)
    viewController.viewModel = viewModel

    navigationController?.pushViewController(viewController, animated: false)
  }

  func onExit() {
    rootNavigationController?.popViewController(animated: true)
  }

  func onBack() {
    navigationController?.popViewController(animated: true)
  }
}

extension YDMStoreModeOfflineAccountCoordinator: PreHomeNavigationDelegate {
  func assignInternalNavigationController(_ nav: UINavigationController?) {
    navigationController = nav
    startHome()
  }
}

// MARK: Home
extension YDMStoreModeOfflineAccountCoordinator: HomeViewModelNavigationDelegate {
  func openUserData() {
    guard let viewController = UserDataViewController.initializeFromStoryboard()
    else {
      fatalError("UserDataViewController.initializeFromStoryboard")
    }

    let viewModel = UserDataViewModel(
      navigation: self,
      user: currentUser
    )

    viewController.viewModel = viewModel

    navigationController?.pushViewController(viewController, animated: true)
  }

  func openOfflineOrders() {
    let viewController = OrdersViewController()
    let viewModel = OrdersViewModel(navigation: self)

    viewController.viewModel = viewModel
    navigationController?.pushViewController(viewController, animated: true)
  }
}

// MARK: User Data Navigation
extension YDMStoreModeOfflineAccountCoordinator: UserDataNavigationDelegate {
  func openUserHistoric(withUser user: YDLasaClientLogin) {
    guard let viewController = HistoricViewController.initializeFromStoryboard()
    else {
      fatalError("HistoricViewController.initializeFromStoryboard")
    }

    let viewModel = HistoricViewModel(
      navigation: self,
      currentUser: user
    )

    viewController.viewModel = viewModel
    navigationController?.pushViewController(viewController, animated: true)
  }

  func openTerms() {
    guard let viewController = TermsViewController.initializeFromStoryboard()
    else {
      fatalError("TermsViewController.initializeFromStoryboard")
    }

    let spaceyViewModel = YDSpaceyViewModel(supportedTypes: [.termsOfUse])
    let spaceyId = "politica-de-privacidade"

    let viewModel = TermsViewModel(
      navigation: self,
      spaceyViewModel: spaceyViewModel,
      spaceyId: spaceyId
    )

    viewController.viewModel = viewModel
    navigationController?.pushViewController(viewController, animated: true)
  }
}

// MARK: Terms Navigation
extension YDMStoreModeOfflineAccountCoordinator: TermsNavigationDelegate {}

// MARK: Orders Navigation
extension YDMStoreModeOfflineAccountCoordinator: OrdersNavigationDelegate {}
