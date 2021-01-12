//
//  YDMStoreModeOfflineAccountCoordinator.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas on 12/01/21.
//

import UIKit

import YDB2WIntegration
import YDExtensions
import YDUtilities

public typealias YDMStoreModeOfflineAccount = YDMStoreModeOfflineAccountCoordinator

public class YDMStoreModeOfflineAccountCoordinator {

  // Properties
  var rootViewController: UIViewController {
    return self.navigationController
  }

  lazy var navigationController: UINavigationController = {
    let nav = UINavigationController()
    nav.isNavigationBarHidden = true
    nav.modalPresentationStyle = .fullScreen
    return nav
  }()

  // MARK: Init
  public init() {}

  // MARK: Actions
  public func start() {
    guard let viewController = YDMStoreModeOfflineAccountViewController.initializeFromStoryboard()
//          let config = YDIntegrationHelper.shared.getFeature(featureName: YDConfigKeys.store.rawValue),
//          let storesUrl = config.extras?[YDConfigProperty.storesUrl.rawValue] as? String,
//          let addressUrl = config.extras?[YDConfigProperty.addressUrl.rawValue] as? String
    else {
      fatalError("YDMStoreModeOfflineAccountViewController.initializeFromStoryboard")
    }
    
    let topViewController = UIApplication.shared.keyWindow?
      .rootViewController?.topMostViewController()

    let service = YDServiceClient()
    let serviceOfflineAccount = YDMStoreModeOfflineAccountService(service: service)
    
    let viewModel = YDMStoreModeOfflineAccountViewModel(navigation: self, service: serviceOfflineAccount)
    
    viewController.viewModel = viewModel
    
    navigationController.viewControllers = [viewController]
    topViewController?.present(navigationController, animated: true, completion: nil)
  }
}

extension YDMStoreModeOfflineAccountCoordinator: YDMStoreModeOfflineAccountNavigationDelegate {
  func onExit() {
    rootViewController.dismiss(animated: true, completion: nil)
  }
}
