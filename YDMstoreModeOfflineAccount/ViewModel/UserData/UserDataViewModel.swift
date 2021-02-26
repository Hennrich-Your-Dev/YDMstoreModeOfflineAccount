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
  func openUserHistoric(withUser user: UserLogin)
  func openTerms()
}

// MARK: Delegate
protocol UserDataViewModelDelegate {
  var error: Binder<(title: String, message: String)> { get }
  var loading: Binder<Bool> { get }
  var snackBarMessage: Binder<String?> { get }
  var usersInfo: Binder<[DataSet]> { get }
  var userData: UsersInfo? { get set }

  subscript(_ index: Int) -> DataSet? { get }

  func onBack()
  func trackState()
  func getUsersInfo()
  func openHistoric()
  func openTerms()
  func updateInfo()
}

class UserDataViewModel {
  // MARK: Properties
  lazy var logger = Logger.forClass(Self.self)
  let service: UserDataServiceDelegate
  let navigation: UserDataNavigationDelegate

  var error: Binder<(title: String, message: String)> = Binder(("", ""))
  var loading: Binder<Bool> = Binder(false)
  var snackBarMessage: Binder<String?> = Binder(nil)

  let currentUser: YDCurrentCustomer
  var userLogin: UserLogin? = nil
  var userData: UsersInfo? = nil
  var usersInfo: Binder<[DataSet]> = Binder([])

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

      let userLoginString = """
      {
        "cpf": "13569901777",
        "nome": "Natália Prado Tiago",
        "email": "pradocinhosgourmet@gmail.com",
        "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZExhc2EiOiJhM2M5MzgxNy00MGRlLTQzZDEtOWUxMi0wZTk5NGFjODgzNWQiLCJpYXQiOjE2MTI4Nzc4NjIsImV4cCI6MTYxMjk2NDI2Mn0.HZTMQSnHJ79on1U46Wo8KyVbCHTjTAHTGeh4WAw9mR0",
        "id_lasa": "a3c93817-40de-43d1-9e12-0e994ac8835d"
      }
      """

      guard let data = jsonString.data(using: .utf16),
            let json = try? JSONDecoder().decode(UsersInfo.self, from: data),
            let dataUserLogin = userLoginString.data(using: .utf16),
            let userLogin = try? JSONDecoder().decode(UserLogin.self, from: dataUserLogin)
      else {
        return
      }

      self.userLogin = userLogin
      self.userData = json
      self.usersInfo.value = json.getUserDataSets()

      self.loading.value = false
    }
  }

  func getClientInfo(with user: UserLogin) {
    userLogin = user
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
  subscript(_ index: Int) -> DataSet? {
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
//    getUsersInfoMock()
//    return;
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
    guard let user = userLogin else { return }

    navigation.openUserHistoric(withUser: user)
  }

  func openTerms() {
    navigation.openTerms()
  }

  func updateInfo() {
    loading.value = true
    guard let params = try? userData?.asDictionary(),
          let userLogin = userLogin
    else {
      loading.value = false
      error.value = errorMessage
      return
    }

    service.updateInfo(
      user: userLogin,
      parameters: params
    ) { [weak self] (result: Result<Void, YDServiceError>) in
      guard let self = self else { return }
      self.loading.value = false

      switch result {
        case .success:
          self.snackBarMessage.value = "Atualização de dados e permissões salvos com sucesso :)"
        case .failure:
          self.snackBarMessage.value = "Ops! Algo inesperado aconteceu. Tente novamente."
      }
    }
  }
}
