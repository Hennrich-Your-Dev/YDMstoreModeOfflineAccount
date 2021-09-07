//
//  YDMStoreModeOfflineAccountViewModel.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas on 12/01/21.
//

import UIKit

import YDB2WIntegration
import YDUtilities
import YDExtensions
import YDB2WModels
import YDB2WComponents

// MARK: Navigation
protocol HomeViewModelNavigationDelegate {
  func onExit()
  func openUserData()
  func openOfflineOrders()
}

// MARK: Delegate
protocol HomeViewModelDelegate {
  var currentUser: YDCurrentCustomer { get }
  var error: Binder<(title: String, message: String)> { get }

  func onExit()
  func trackState()
  func onCard(tag: Int)
  
  func fromQuizWrongAnswer(autoExit: Bool)
}

// MARK: ViewModel
class HomeViewModel {
  // MARK: Properties
  let navigation: HomeViewModelNavigationDelegate
  var currentUser: YDCurrentCustomer
  var error: Binder<(title: String, message: String)> = Binder(("", ""))

  var userClientLasaToken: String = ""

  // MARK: Init
  init(
    navigation: HomeViewModelNavigationDelegate,
    user: YDCurrentCustomer
  ) {
    self.navigation = navigation
    self.currentUser = user
  }
}

// MARK: Extension Delegate
extension HomeViewModel: HomeViewModelDelegate {
  func onExit() {
    navigation.onExit()
  }

  func trackState() {
    YDIntegrationHelper.shared.trackEvent(withName: .offlineAccountPerfil, ofType: .state)
  }

  func onCard(tag: Int) {
    switch tag {
      case 1:
        // QR Card
        error.value = (
          "poooxa, ainda não temos seu cadastro completo",
          "E pra mantermos a segurança dos seus dados, você poderá consultar mais informações com nosso atendimento, através do e-mail: atendimento.acom@americanas.com"
        )

      case 2:
        // User Data
        let parameters = TrackEvents.offlineAccountPerfil.parameters(body: ["action": "meus dados"])
        
        YDIntegrationHelper.shared
          .trackEvent(
            withName: .offlineAccountPerfil,
            ofType: .action,
            withParameters: parameters
          )
        
        navigation.openUserData()

      case 3:
        // Offline orders
        let parameters = TrackEvents.offlineAccountPerfil.parameters(body: ["action": "minhas compras"])
        
        YDIntegrationHelper.shared
          .trackEvent(
            withName: .offlineAccountPerfil,
            ofType: .action,
            withParameters: parameters
          )
        
        navigation.openOfflineOrders()

      default:
        break
    }
  }
  
  func fromQuizWrongAnswer(autoExit: Bool = false) {
    let title = autoExit ?
      "poooxa, ainda não temos seu cadastro completo" :
      "poooxa, não encontramos os seus dados aqui"
    let message = autoExit ?
      "Pra completar o seu cadastro entre em contato com nosso atendimento, através do e-mail: atendimento.acom@americanas.com" :
      "Você pode consultar mais informações com nosso atendimento, através do e-mail: atendimento.acom@americanas.com"
    
    let parameters = autoExit ?
      TrackEvents.quizIncompleteRegistration.parameters(body: [:]) :
      TrackEvents.quizRegistrationNotFound.parameters(body: [:])
    
    YDIntegrationHelper.shared.trackEvent(
      withName: autoExit ? .quizIncompleteRegistration : .quizRegistrationNotFound,
      ofType: .action,
      withParameters: parameters
    )
    
    YDDialog().start(
      ofType: .simple,
      customTitle: title,
      customMessage: message,
      messageLink: [
        "message": "atendimento.acom@americanas.com",
        "link": "mailto:atendimento.acom@americanas.com"
      ]
    )
  }
}
