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

public class YDMStoreModeOfflineAccountCoordinator {

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

    let service = YDServiceClient()
    let serviceOfflineAccount = YDMStoreModeOfflineAccountService(service: service)

    let viewModel = YDMStoreModeOfflineAccountViewModel(navigation: self, service: serviceOfflineAccount)

    viewController.viewModel = viewModel
    viewController.hero.isEnabled = true
    viewController.hero.modalAnimationType = .fade

    navigationController = navCon
    navigationController?.pushViewController(viewController, animated: true)
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
    let userInfoApi = "\(endPoint)/portalcliente/cliente"

    let service = YDServiceClient()
    let serviceUserData = UserDataService(
      service: service,
      loginApi: loginApi,
      userInfoApi: userInfoApi
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
  func onBack() {
    navigationController?.popViewController(animated: true)
  }

  func openUserHistoric() {
    //
  }
}
