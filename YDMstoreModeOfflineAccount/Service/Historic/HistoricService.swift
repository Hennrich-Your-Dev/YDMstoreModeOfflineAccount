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
  func getHistoric(
    with user: UserLogin,
    onCompletion completion: @escaping (Result<[HistoricData], YDServiceError>) -> Void
  )
}

class HistoricService {
  // MARK: Properties
  let service: YDServiceClientDelegate
  let historicApi: String

  // MARK: Init
  init(service: YDServiceClientDelegate, historicApi: String) {
    self.service = service
    self.historicApi = historicApi
  }
}

// MARK: Extension
extension HistoricService: HistoricServiceDelegate {
  func getHistoric(
    with user: UserLogin,
    onCompletion completion: @escaping (Result<[HistoricData], YDServiceError>) -> Void
  ) {
    guard let token = user.token
    else {
       completion(
        .failure(
          YDServiceError(withMessage: "Erro desconhecido")
        )
      )
      return
    }

    let headers: [String: String] = [
      "Cache-Control": "0",
      "Ocp-Apim-Subscription-Key": "953582bd88f84bdb9b3ad66d04eaf728",
      "Authorization": "Bearer \(token)"
    ]

    service.request(
      withUrl: historicApi,
      withMethod: .get,
      withHeaders: headers,
      andParameters: nil
    ) { (response: Result<[HistoricData], YDServiceError>) in
      switch response {
        case .success(let historic):
          let sorted = historic.sorted { (lhs, rhs) -> Bool in
            guard let dateLhs = lhs.dateWithDateType else { return false }
            guard let dateRhs = rhs.dateWithDateType else { return true }

            return dateLhs.compare(dateRhs) == .orderedDescending
          }

          completion(.success(sorted))

        case .failure(let error):
          completion(.failure(error))
      }
    }
  }
}
