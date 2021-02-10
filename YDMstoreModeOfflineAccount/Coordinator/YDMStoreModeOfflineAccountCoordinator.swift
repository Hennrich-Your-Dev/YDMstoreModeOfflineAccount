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

public typealias YDMStoreModeOfflineAccount = YDMStoreModeOfflineAccountCoordinator

public class YDMStoreModeOfflineAccountCoordinator: HistoricNavigationDelegate {

  // Properties
  var navigationController: UINavigationController?
  var currentUser: YDCurrentCustomer!

  // MARK: Init
  public init() {}

  // MARK: Actions
  public func start(navCon: UINavigationController, user: YDCurrentCustomer) {
    guard let viewController = YDMStoreModeOfflineAccountViewController.initializeFromStoryboard()
//          let config = YDIntegrationHelper.shared.getFeature(featureName: YDConfigKeys.lasaClientService.rawValue),
//          let storesUrl = config.extras?[YDConfigProperty.storesUrl.rawValue] as? String,
//          let addressUrl = config.extras?[YDConfigProperty.addressUrl.rawValue] as? String
    else {
      fatalError("YDMStoreModeOfflineAccountViewController.initializeFromStoryboard")
    }

    currentUser = user

    let viewModel = YDMStoreModeOfflineAccountViewModel(navigation: self)

    viewController.viewModel = viewModel
    viewController.hero.isEnabled = true
    viewController.hero.modalAnimationType = .fade

    navigationController = navCon
    navigationController?.pushViewController(viewController, animated: true)
  }

  func onBack() {
    navigationController?.popViewController(animated: true)
  }
}

extension YDMStoreModeOfflineAccountCoordinator: YDMStoreModeOfflineAccountNavigationDelegate {
  func onExit() {
    navigationController?.popViewController(animated: true)
  }

  func openUserData() {
    guard let viewController = UserDataViewController.initializeFromStoryboard(),
          let config = YDIntegrationHelper.shared.getFeature(featureName: YDConfigKeys.lasaClientService.rawValue),
          let endPoint = config.endpoint
    else {
      fatalError("UserDataViewController.initializeFromStoryboard")
    }

    let loginApi = "\(endPoint)/portalcliente/login"
    let clientApi = "\(endPoint)/portalcliente/cliente"

    let service = YDServiceClient()
    let serviceUserData = UserDataService(
      service: service,
      loginApi: loginApi,
      clientApi: clientApi
    )

    let viewModel = UserDataViewModel(
      service: serviceUserData,
      navigation: self,
      user: currentUser
    )

    viewController.viewModel = viewModel

    navigationController?.pushViewController(viewController, animated: true)
  }
}

// MARK: User Data Navigation
extension YDMStoreModeOfflineAccountCoordinator: UserDataNavigationDelegate {
  func openUserHistoric() {
    guard let viewController = HistoricViewController.initializeFromStoryboard()
    else {
      fatalError("HistoricViewController.initializeFromStoryboard")
    }

    let service = YDServiceClient()
    let serviceHistoric = HistoricService(service: service)

    let viewModel = HistoricViewModel(
      service: serviceHistoric,
      navigation: self
    )

    viewController.viewModel = viewModel
    navigationController?.pushViewController(viewController, animated: true)
  }

  func openTerms() {
    guard let viewController = TermsViewController.initializeFromStoryboard()
    else {
      fatalError("TermsViewController.initializeFromStoryboard")
    }

    let viewModel = TermsViewModel(navigation: self)

    viewController.viewModel = viewModel
    navigationController?.pushViewController(viewController, animated: true)
  }
}

// MARK: Terms Navigation
extension YDMStoreModeOfflineAccountCoordinator: TermsNavigationDelegate {}
