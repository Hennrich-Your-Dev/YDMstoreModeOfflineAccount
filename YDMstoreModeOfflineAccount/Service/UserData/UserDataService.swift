//
//  UserDataService.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 25/01/21.
//

import Foundation

import YDB2WIntegration
import YDB2WModels
import YDUtilities

// MARK: Protocol
protocol UserDataServiceDelegate: AnyObject {
  func login(
    user: YDCurrentCustomer,
    onCompletion completion: @escaping (Result<UserLogin, YDServiceError>) -> Void
  )

  func getUserInfo(
    with user: UserLogin,
    onCompletion completion: @escaping (Result<UsersInfo, YDServiceError>) -> Void
  )

  func updateInfo(
    user: UserLogin,
    parameters: [String: Any],
    onCompletion completion: @escaping (Result<Void, YDServiceError>) -> Void
  )
}

class UserDataService {
  // MARK: Properties
  let service: YDServiceClientDelegate
  let loginApi: String
  let clientApi: String

  // MARK: Init
  init(
    service: YDServiceClientDelegate,
    loginApi: String,
    clientApi: String
  ) {
    self.service = service
    self.loginApi = loginApi
    self.clientApi = clientApi
  }
}

// MARK: Extension
extension UserDataService: UserDataServiceDelegate {
  func login(
    user: YDCurrentCustomer,
    onCompletion completion: @escaping (Result<UserLogin, YDServiceError>) -> Void
  ) {
    let headers: [String: String] = [
      "Content-Type": "application/json",
      "Ocp-Apim-Subscription-Key": "953582bd88f84bdb9b3ad66d04eaf728"
    ]

    let parameters: [String: Any] = [
      "id_cliente": user.id,
      "access_code_cliente": user.accessToken
    ]

    service.request(
      withUrl: loginApi,
      withMethod: .post,
      withHeaders: headers,
      andParameters: parameters
    ) { (response: Result<UserLogin, YDServiceError>) in
      switch response {
        case .success(let userLogin):
          completion(.success(userLogin))

        case .failure(let error):
          completion(.failure(error))
      }
    }
  }

  func getUserInfo(
    with user: UserLogin,
    onCompletion completion: @escaping (Result<UsersInfo, YDServiceError>) -> Void
  ) {
    guard let idLasa = user.idLasa,
          let token = user.token
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

    let url = "\(clientApi)/\(idLasa)"

    service.request(
      withUrl: url,
      withMethod: .get,
      withHeaders: headers,
      andParameters: nil
    ) { (response: Result<UsersInfo, YDServiceError>) in
      switch response {
        case .success(let usersInfo):
          usersInfo.socialSecurity = user.socialSecurity
          completion(.success(usersInfo))

        case .failure(let error):
          completion(.failure(error))
      }
    }
  }

  func updateInfo(
    user: UserLogin,
    parameters: [String: Any],
    onCompletion completion: @escaping (Result<Void, YDServiceError>) -> Void
  ) {
    guard let idLasa = user.idLasa,
          let token = user.token
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

    let url = "\(clientApi)/\(idLasa)"

    service.request(
      withUrl: url,
      withMethod: .post,
      withHeaders: headers,
      andParameters: parameters
    ) { (response: Result<[String: String], YDServiceError>) in
      switch response {
        case .success:
          completion(.success(()))

        case .failure(let error):
          completion(.failure(error))
      }
    }
  }
}
