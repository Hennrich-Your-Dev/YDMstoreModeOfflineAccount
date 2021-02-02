//
//  HistoricViewModel.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 02/02/21.
//

import Foundation

import YDUtilities
import YDExtensions
import YDB2WIntegration

// MARK: Navigation
protocol HistoricNavigationDelegate {
  func onBack()
}

// MARK: Delegate
protocol HistoricViewModelDelegate {
  var error: Binder<(title: String, message: String)> { get }
  var loading: Binder<Bool> { get }

  func onBack()
}

class HistoricViewModel {
  // MARK: Properties
  let service: HistoricServiceDelegate
  let navigation: HistoricNavigationDelegate

  var error: Binder<(title: String, message: String)> = Binder(("", ""))
  var loading: Binder<Bool> = Binder(false)

  // MARK: Init
  init(
    service: HistoricServiceDelegate,
    navigation: HistoricNavigationDelegate
  ) {
    self.service = service
    self.navigation = navigation
  }

  // MARK: Actions
//  func getUsersInfoMock() {
//    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
//      let jsonString = """
//      {
//        "id_lasa": "a3c93817-40de-43d1-9e12-0e994ac8835d",
//        "nome_completo": "Natália Prado Tiago",
//        "sexo": null,
//        "estado_civil": null,
//        "data_nascimento": "1994-10-29T00:00:00",
//        "logradouro": "Rua Senador Vergueiro",
//        "numero": "5",
//        "complemento": "Bloco 3 apto 316 - Perto da renner",
//        "municipio": "Rio de Janeiro",
//        "cep": "22230000",
//        "bairro": "Flamengo",
//        "uf": "BR",
//        "telefone_celular": "33933198",
//        "telefone_residencial": "",
//        "email": "nataliaprado29@gmail.com",
//        "optin_marketing": false,
//        "optin_termos_condicoes": false
//      }
//      """
//
//      guard let data = jsonString.data(using: .utf16),
//            let json = try? JSONDecoder().decode(UsersInfo.self, from: data) else {
//        return
//      }
//
//      self.userData = json
//      self.usersInfo.value = json.getUserDataSets()
//
//      self.loading.value = false
//    }
//  }
}

// MARK: Extension
extension HistoricViewModel: HistoricViewModelDelegate {
  func onBack() {
    navigation.onBack()
  }

//  func getUsersInfo() {
//    loading.value = true
//    // getUsersInfoMock()
//
//    service.login(user: currentUser) { [weak self] (response: Result<UserLogin, YDServiceError>) in
//      guard let self = self else { return }
//
//      switch response {
//        case .success(let userLoginData):
//          self.getClientInfo(with: userLoginData)
//
//        case .failure(let error):
//          self.loading.value = false
//
//          if let status = error.statusCode,
//             status == 308 {
//            self.error.value = self.errorMessageIncompletePerfil
//            return
//          }
//
//          self.error.value = self.errorMessage
//      }
//    }
//  }
}
