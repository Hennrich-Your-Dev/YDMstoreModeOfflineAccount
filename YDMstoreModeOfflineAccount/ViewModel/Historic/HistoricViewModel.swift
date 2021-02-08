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

  // MARK: Init
  init(
    service: HistoricServiceDelegate,
    navigation: HistoricNavigationDelegate
  ) {
    self.service = service
    self.navigation = navigation
  }

  // MARK: Actions
  func getMock() -> [HistoricData] {
    guard let path = Bundle.init(for: Self.self)
            .path(forResource: "historicMock", ofType: "json"),
          let url = URL(string: path),
          let data = try? Data(contentsOf: url),
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
    Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
      self.historicList.value = self.getMock()
    }

    // TODO:
    // Service
  }
}
