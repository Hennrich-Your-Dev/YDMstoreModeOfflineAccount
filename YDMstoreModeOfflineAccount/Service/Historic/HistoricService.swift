//
//  HistoricService.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 02/02/21.
//

import Foundation

import YDB2WIntegration
import YDB2WModels
import YDUtilities

// MARK: Protocol
protocol HistoricServiceDelegate: AnyObject {
//  func getUserInfo(
//    with user: UserLogin,
//    onCompletion completion: @escaping (Result<UsersInfo, YDServiceError>) -> Void
//  )
}

class HistoricService {
  // MARK: Properties
  let service: YDServiceClientDelegate
//  let userInfoApi: String

  // MARK: Init
  init(service: YDServiceClientDelegate) {
    self.service = service
//    self.userInfoApi = userInfoApi
  }
}

// MARK: Extension
extension HistoricService: HistoricServiceDelegate {
//  func getUserInfo(
//    with user: UserLogin,
//    onCompletion completion: @escaping (Result<UsersInfo, YDServiceError>) -> Void
//  ) {
//    guard let idLasa = user.idLasa,
//          let token = user.token
//    else {
//       completion(
//        .failure(
//          YDServiceError(withMessage: "Erro desconhecido")
//        )
//      )
//      return
//    }
//
//    let headers: [String: String] = [
//      "Cache-Control": "0",
//      "Ocp-Apim-Subscription-Key": "953582bd88f84bdb9b3ad66d04eaf728",
//      "Authorization": "Bearer \(token)"
//    ]
//
//    let url = "\(userInfoApi)/\(idLasa)"
//
//    service.request(
//      withUrl: url,
//      withMethod: .get,
//      withHeaders: headers,
//      andParameters: nil
//    ) { (response: Result<UsersInfo, YDServiceError>) in
//      switch response {
//        case .success(let usersInfo):
//          usersInfo.socialSecurity = user.socialSecurity
//          completion(.success(usersInfo))
//
//        case .failure(let error):
//          completion(.failure(error))
//      }
//    }
//  }
}
