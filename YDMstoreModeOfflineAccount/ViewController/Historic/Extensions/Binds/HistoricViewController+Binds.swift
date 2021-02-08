//
//  HistoricViewController+Binds.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 08/02/21.
//

import UIKit

extension HistoricViewController {
  func setBinds() {
    viewModel?.loading.bind { [weak self] isLoading in
      isLoading ? self?.view.startLoader() : self?.view.stopLoader()
    }

    viewModel?.historicList.bind { [weak self] _ in
      self?.tableView.reloadData()
    }
  }
}
