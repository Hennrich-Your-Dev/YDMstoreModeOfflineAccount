//
//  YDMStoreModeOfflineAccountService.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas on 12/01/21.
//

import Foundation

import YDB2WIntegration
import YDB2WModels
import YDUtilities

// MARK: Protocol
protocol YDMStoreModeOfflineAccountServiceDelegate: AnyObject {
  
}

class YDMStoreModeOfflineAccountService {
  // MARK: Properties
  let service: YDServiceClientDelegate

  // MARK: Init
  init(service: YDServiceClientDelegate) {
    self.service = service
  }
}

// MARK: Extension
extension YDMStoreModeOfflineAccountService: YDMStoreModeOfflineAccountServiceDelegate {
//  func getNearstLasas(
//    with location: CLLocationCoordinate2D,
//    onCompletion: @escaping (Result<[YDStore], Error>) -> Void
//  ) {
//    guard let config = YDIntegrationHelper.shared
//            .getFeature(featureName: YDConfigKeys.store.rawValue),
//          let extras = config.extras,
//          let storesUrl = extras[YDConfigProperty.storesUrl.rawValue] as? String,
//          let type = extras[YDConfigProperty.storesType.rawValue] as? String,
//          let radius = extras[YDConfigProperty.maxStoreRange.rawValue] as? String
//    else {
//      fatalError("Can't get url extras")
//    }
//
//    let parameters: [String: Any] = [
//      "latitude": location.latitude,
//      "longitude": location.longitude,
//      "type": type,
//      "radius": radius
//    ]
//
//    service.request(
//      withUrl: storesUrl,
//      withMethod: .get,
//      andParameters: parameters) { (response: Result<YDStores, Error>) in
//      switch response {
//      case .success(let stores):
//        let sorted = stores.stores.sorted { $0.distance < $1.distance }
//
//        onCompletion(.success(sorted))
//
//      case .failure(let error):
//        onCompletion(.failure(error))
//      }
//    }
//  }
}
