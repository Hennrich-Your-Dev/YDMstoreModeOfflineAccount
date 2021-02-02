//
//  YDMStoreModeOfflineAccountUserDataViewModel.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 25/01/21.
//

import Foundation

import YDUtilities
import YDExtensions
import YDB2WIntegration

// MARK: Navigation
protocol UserDataNavigationDelegate {
  func onBack()
  func openUserHistoric()
  func openTerms()
}

// MARK: Delegate
protocol UserDataViewModelDelegate {
  var error: Binder<(title: String, message: String)> { get }
  var loading: Binder<Bool> { get }
  var usersInfo: Binder<[UserDataSet]> { get }
  var userData: UsersInfo? { get set }

  subscript(_ index: Int) -> UserDataSet? { get }

  func onBack()
  func trackState()
  func getUsersInfo()
  func openHistoric()
  func openTerms()
}

class UserDataViewModel {
  // MARK: Properties
  let service: UserDataServiceDelegate
  let navigation: UserDataNavigationDelegate

  var error: Binder<(title: String, message: String)> = Binder(("", ""))
  var loading: Binder<Bool> = Binder(false)

  let currentUser: YDCurrentCustomer
  var userData: UsersInfo? = nil
  var usersInfo: Binder<[UserDataSet]> =  Binder([])

  let errorMessageIncompletePerfil = (
    title: "poooxa, ainda não temos seu cadastro completo",
    message: "E pra mantermos a segurança dos seus dados, você poderá consultar mais informações com nosso atendimento, através do e-mail: atendimento.acom@americanas.com"
  )
  let errorMessage = (
    title: "poooxa, não encontramos os seus dados aqui",
    message: "Você pode consultar mais informações com nosso atendimento, através do e-mail: atendimento.acom@americanas.com"
  )

  // MARK: Init
  init(
    service: UserDataServiceDelegate,
    navigation: UserDataNavigationDelegate,
    user: YDCurrentCustomer
  ) {
    self.service = service
    self.navigation = navigation
    self.currentUser = user
  }

  // MARK: Actions
  func getUsersInfoMock() {
    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
      let jsonString = """
      {
        "id_lasa": "a3c93817-40de-43d1-9e12-0e994ac8835d",
        "nome_completo": "Natália Prado Tiago",
        "sexo": null,
        "estado_civil": null,
        "data_nascimento": "1994-10-29T00:00:00",
        "logradouro": "Rua Senador Vergueiro",
        "numero": "5",
        "complemento": "Bloco 3 apto 316 - Perto da renner",
        "municipio": "Rio de Janeiro",
        "cep": "22230000",
        "bairro": "Flamengo",
        "uf": "BR",
        "telefone_celular": "33933198",
        "telefone_residencial": "",
        "email": "nataliaprado29@gmail.com",
        "optin_marketing": false,
        "optin_termos_condicoes": false
      }
      """

      guard let data = jsonString.data(using: .utf16),
            let json = try? JSONDecoder().decode(UsersInfo.self, from: data) else {
        return
      }

      self.userData = json
      self.usersInfo.value = json.getUserDataSets()

      self.loading.value = false
    }
  }

  func getClientInfo(with user: UserLogin) {
    service.getUserInfo(with: user) { [weak self] (result: Result<UsersInfo, YDServiceError>) in
      guard let self = self else { return }

      switch result {
        case .success(let data):
          self.userData = data
          self.usersInfo.value = data.getUserDataSets()
          self.loading.value = false

        case .failure(let error):
          self.loading.value = false

          if let status = error.statusCode,
             status == 308 {
            self.error.value = self.errorMessageIncompletePerfil
            return
          }

          self.error.value = self.errorMessage
      }
    }
  }
}

// MARK: Extension
extension UserDataViewModel: UserDataViewModelDelegate {
  subscript(_ index: Int) -> UserDataSet? {
    return usersInfo.value.at(index)
  }

  func onBack() {
    navigation.onBack()
  }

  func trackState() {
    YDIntegrationHelper.shared.trackEvent(withName: .offlineAccountUsersInfo, ofType: .state)
  }

  func getUsersInfo() {
    loading.value = true
    // getUsersInfoMock()

    service.login(user: currentUser) { [weak self] (response: Result<UserLogin, YDServiceError>) in
      guard let self = self else { return }

      switch response {
        case .success(let userLoginData):
          self.getClientInfo(with: userLoginData)

        case .failure(let error):
          self.loading.value = false

          if let status = error.statusCode,
             status == 308 {
            self.error.value = self.errorMessageIncompletePerfil
            return
          }

          self.error.value = self.errorMessage
      }
    }
  }

  func openHistoric() {
    navigation.openUserHistoric()
  }

  func openTerms() {
    navigation.openTerms()
  }
}