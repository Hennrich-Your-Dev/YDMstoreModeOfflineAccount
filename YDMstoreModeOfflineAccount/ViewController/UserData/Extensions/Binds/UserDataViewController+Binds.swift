//
//  UserDataViewController+Binds.swift
//  YDMstoreModeOfflineAccount
//
//  Created by Douglas Hennrich on 25/01/21.
//

import Foundation

extension UserDataViewController {
  func setBinds() {
    viewModel?.error.bind { [weak self] params in
      self?.showAlert(title: params.title, message: params.message)
    }

    viewModel?.loading.bind { [weak self] isLoading in
      if isLoading {
        self?.tableView.isHidden = true
        self?.separatorView.isHidden = true
        self?.activityIndicator.isHidden = false
        self?.activityIndicator.startAnimating()
      } else {
        self?.tableView.isHidden = false
        self?.separatorView.isHidden = false
        self?.activityIndicator.isHidden = true
      }
    }

    viewModel?.usersInfo.bind { [weak self] _ in
      self?.tableView.reloadData()
//      self?.lastUpdateLabelTitle.isHidden = false
//      self?.lastUpdateLabel.isHidden = false
      self?.historicButton.isHidden = false
      self?.separatorView.isHidden = false
    }
  }
}
