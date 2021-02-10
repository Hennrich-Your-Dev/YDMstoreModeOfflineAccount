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
      if isLoading {
        self?.tableView.isHidden = true
        self?.separatorView.isHidden = true
        self?.exportButton.isHidden = true
        self?.activityIndicator.isHidden = false
        self?.activityIndicator.startAnimating()
      } else {
        self?.tableView.isHidden = false
        self?.separatorView.isHidden = false
        self?.exportButton.isHidden = false
        self?.activityIndicator.isHidden = true
      }
    }

    viewModel?.historicList.bind { [weak self] _ in
      self?.tableView.reloadData()
    }
  }
}
