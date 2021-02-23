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
  var historicList: Binder<[HistoricData]> { get }

  subscript(index: Int) -> HistoricData? { get }
  func onBack()
  func getHistoricList()
}

class HistoricViewModel {
  // MARK: Properties
  let service: HistoricServiceDelegate
  let navigation: HistoricNavigationDelegate

  var error: Binder<(title: String, message: String)> = Binder(("", ""))
  var loading: Binder<Bool> = Binder(false)

  var historicList: Binder<[HistoricData]> = Binder([])
  let user: UserLogin

  // MARK: Init
  init(
    service: HistoricServiceDelegate,
    navigation: HistoricNavigationDelegate,
    currentUser: UserLogin
  ) {
    self.service = service
    self.navigation = navigation
    self.user = currentUser
  }

  // MARK: Actions
  func getMock() -> [HistoricData] {
    let bundle = Bundle(for: type(of: self))

    guard let pathString = bundle.path(forResource: "historicMock", ofType: "json"),
          let data = try? Data(contentsOf: URL(fileURLWithPath: pathString)),
          let json = try? JSONDecoder().decode([HistoricData].self, from: data)
    else {
      fatalError()
    }

    return json
  }
}

// MARK: Extension
extension HistoricViewModel: HistoricViewModelDelegate {
  subscript(index: Int) -> HistoricData? {
    return historicList.value.at(index)
  }

  func onBack() {
    navigation.onBack()
  }

  func getHistoricList() {
    loading.value = true
//    Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
//      self.historicList.value = self.getMock()
//      self.loading.value = false
//    }

    service.getHistoric(with: user) { [weak self] (result: Result<[HistoricData], YDServiceError>) in
      guard let self = self else { return }
      self.loading.value = false

      switch result {
        case .success(let historic):
          self.historicList.value = historic

        case .failure(let error):
          self.error.value = ("Ops", error.message)
      }
    }
  }
}
