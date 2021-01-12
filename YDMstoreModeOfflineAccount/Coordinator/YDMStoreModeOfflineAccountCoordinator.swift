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

  // MARK: Init
//  public init() {}

  // MARK: Actions
  public func start(navCon: UINavigationController) {
    guard let viewController = YDMStoreModeOfflineAccountViewController.initializeFromStoryboard()
//          let config = YDIntegrationHelper.shared.getFeature(featureName: YDConfigKeys.store.rawValue),
//          let storesUrl = config.extras?[YDConfigProperty.storesUrl.rawValue] as? String,
//          let addressUrl = config.extras?[YDConfigProperty.addressUrl.rawValue] as? String
    else {
      fatalError("YDMStoreModeOfflineAccountViewController.initializeFromStoryboard")
    }

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
}
